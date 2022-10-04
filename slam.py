#!/usr/bin/env python3

from cgitb import grey
import cv2 # version 4.6.6 
import os
import time 
import numpy as np
import orbslam
print(f"Using openCV version {cv2.__version__}")

video = cv2.VideoCapture("test.mp4")
cv2.namedWindow("video", cv2.WINDOW_AUTOSIZE)


orb = orbslam.ORBSLAM()

if video.isOpened():
    # show one frame at a time
    key = cv2.waitKey(0)
    prev_frame = None
    frame_i = 0
    while video.isOpened() and key not in [ord('q'), ord('k')]:
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
            print("prev kps", len(orb.prev['kps']))
            print("kps", len(kps))
            print("matches", len(matches))

            frame = cv2.drawMatches(prev_frame, orb.prev['kps'], frame, kps, matches, None, flags=cv2.DrawMatchesFlags_NOT_DRAW_SINGLE_POINTS)

        prev_frame = grey_frame


        
        # for i in corners:
        #     x,y = i.ravel()
        #     cv2.circle(frame,(x,y),3,255,-1)   
        # Display each frame
        cv2.imshow("video", frame)
        # time.sleep(1)
        key = cv2.waitKey(30)

        frame_i += 1

cv2.destroyAllWindows()
print("Done")
