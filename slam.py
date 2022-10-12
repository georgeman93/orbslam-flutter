#!/usr/bin/env python3

from cgitb import grey
import cv2 # version 4.6.6 
import os
import time 
import numpy as np
import orbslam
import asyncio
import websockets
print(f"Using openCV version {cv2.__version__}")


# cv2.namedWindow("video", cv2.WINDOW_AUTOSIZE)


orb = orbslam.ORBSLAM()

# create websocket server
async def handler(websocket, path):
    video = cv2.VideoCapture("c++_implementation/test.mp4")
    if video.isOpened():
        # show one frame at a time
        prev_frame = None
        frame_i = 0
        play = True
        while video.isOpened():
            if play is True:
                # Read video capture
                ret, frame = video.read()
                if frame is None:
                    continue
                
                print(f"Frame {frame_i}") 
                # convert to grayscale
                grey_frame = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)

                # extract features, descriptors and matches across frames
                kps, des, matches = orb.compute(prev_frame, grey_frame)

                # draw the keypoints
                frame = cv2.drawKeypoints(frame, kps, None, color=(0,255,0), flags=0)

                #check if array contains element 
                if None not in [kps, orb.prev['kps'], matches] and 0 not in [len(kps), len(orb.prev['kps']), len(matches)]:
                    # print("prev kps", len(orb.prev['kps']))
                    # print("kps", len(kps))
                    # print("matches", len(matches))

                    try:
                        frame = cv2.drawMatches(prev_frame, orb.prev['kps'], frame, kps, matches, None, flags=cv2.DrawMatchesFlags_DRAW_RICH_KEYPOINTS)
                    except:
                        print("Error drawing matches")

                prev_frame = grey_frame
                
                # for i in corners:
                #     x,y = i.ravel()
                #     cv2.circle(frame,(x,y),3,255,-1)   
                # Display each frame
                cv2.imshow("video", frame)
                frame_i += 1
                # send the frame encoded with base64
                await websocket.send(cv2.imencode('.jpg', frame)[1].tobytes())

            time.sleep(1)
            # check for pause/play/restart commands from the client 
            try:
                recieved_data = await asyncio.wait_for(websocket.recv(), timeout=0.5)
                print(f"{recieved_data}")
                if recieved_data == "pause":
                    print("Pausing video")
                    play = False
                elif recieved_data == "play":
                    print("Playing video")
                    play = True
                elif recieved_data == "restart":
                    print("Restarting video")
                    video.release()
                    video = cv2.VideoCapture("c++_implementation/test.mp4")
                    frame_i = 0

            
            except asyncio.TimeoutError:
                    pass





    cv2.destroyAllWindows()
    print("Done")

# run the flutter app
# os.system("flutter run")

start_server = websockets.serve(handler, "localhost", 8080)
asyncio.get_event_loop().run_until_complete(start_server)
asyncio.get_event_loop().run_forever()
