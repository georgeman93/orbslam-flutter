#!/usr/bin/env python3

import cv2 # version 4.6.6 
import os
import time 
W = 1920//2
H = 1080//2
print(f"Using openCV version {cv2.__version__}")
video = cv2.VideoCapture("test.mp4")
cv2.namedWindow("video", cv2.WINDOW_AUTOSIZE)

# Initiate ORB detector
orb = cv2.ORB_create()

class FeatureExtractor():
    """
    I want to use this to improve on the current orb detector by running detectAndCompute on each grid cell
    """
    GX = 16//2
    GY = 12//2
    def __init__(self):
        self.orb = cv2.ORB_create()


    def extract(self, frame):
        # find the keypoints and descriptors with ORB
        kp_arr = []
        h, w = frame.shape[:2]
        sy, sx = h//self.GY, w//self.GX # cell size
        for ry in range(0, h, sy):
            for rx in range(0, w, sx):
                img_cell = frame[ry:ry+sy, rx:rx+sx]
                # cv2.imshow("cell", img_cell)
                # cv2.waitKey(0)
                # print(f"looking for features in {rx}:{rx+sx}, {ry}:{ry+sy}")
                kp_temp = self.orb.detect(img_cell, None)
                if len(kp_temp) != 0:
                    for p in kp_temp:
                        p.pt = (p.pt[0]+rx, p.pt[1]+ry) # shift the points back to the original frame
                    kp_arr.append(kp_temp)
                    print(f"Found {len(kp_temp)} keypoints in cell ({rx},{ry})")
        return kp_arr

fe = FeatureExtractor()

if video.isOpened():
    # show one frame at a time
    key = cv2.waitKey(0)
    while video.isOpened() and key not in [ord('q'), ord('k')]:
        # Read video capture
        ret, frame = video.read()
        if frame is None:
            continue

        kp_arr = fe.extract(frame)
        
        # draw only keypoints location,not size and orientation
        for kp in kp_arr:
            frame = cv2.drawKeypoints(frame, kp, None, color=(0,255,0), flags=0)
        # Display each frame
        cv2.imshow("video", frame)
        # time.sleep(1)
        key = cv2.waitKey(30)

video.release()
cv2.destroyAllWindows()
print("Done")
