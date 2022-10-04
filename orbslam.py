import cv2
import numpy as np

class ORBSLAM():
    """
    Wrapper for the ORB feature detector and matcher
    """
    def __init__(self):
        self.orb = cv2.ORB_create()
        self.matcher = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)
        self.prev = None

    def extract(self, frame):
        # find the keypoints and descriptors with ORB
        corners = cv2.goodFeaturesToTrack(frame, 0, 0.01, 10)
        kps = [cv2.KeyPoint(x=f[0][0], y=f[0][1], size=20) for f in corners]
        _, des = self.orb.compute(frame, kps)

        return kps, des

    def match(self, des1, des2):
        """Match descriptors from two images"""
        print(des1)
        matches = self.matcher.match(des1, des2)
        matches = sorted(matches, key = lambda x:x.distance)
        print(f"Found {len(matches)} matches")
        return matches

    def compute(self, prev_frame, frame):
        """Compute keypoints, descriptors and matches across frames"""
        # extract features
        kps, des = self.extract(frame)

        if prev_frame is None:
            # save the previous frame
            self.prev = {'kps': kps, 'des': des} 
            return kps, des, None

        # match features
        matches = self.match(des, self.prev['des'])

        # save the previous frame
        self.prev = {'kps': kps, 'des': des}
        return kps, des, matches
