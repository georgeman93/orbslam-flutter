/**
 * @file orbslam.cpp
 * @author George O'Connor
 * @brief Class to to do useful orb slam things
 * @version 0.1
 * @date 2022-10-07
 *
 * @copyright Copyright (c) 2022
 *
 */

#include "orbslam.hpp"


ORBSLAM::ORBSLAM() {
    _orb = cv::ORB::create();
    _matcher = cv::DescriptorMatcher::create("BruteForce-Hamming");
};

ORBSLAM::~ORBSLAM() {
    _orb.release();
    _matcher.release();
};


std::tuple<std::vector<cv::KeyPoint>, cv::Mat>  ORBSLAM::extract(cv::Mat frame) {
    /**
     * @brief Extracts features from a frame
     *
     * @param frame
     * @return std::tuple<std::vector<cv::KeyPoint>, cv::Mat>
     */
    std::vector<cv::KeyPoint> keypoints;
    std::vector<cv::Point2f> corners;
    cv::goodFeaturesToTrack(frame, corners, 1000, 0.01, 10);
    cv::KeyPoint::convert(corners, keypoints, 10, 1, 0, -1);
    cv::Mat descriptors;
    _orb->compute(frame, keypoints, descriptors);
    return std::make_tuple(keypoints, descriptors);

}

std::vector<cv::DMatch> ORBSLAM::match(cv::Mat prev_descriptors, cv::Mat descriptors) {
    /**
     * @brief Matches features between two frames
     *
     * @param prev_descriptors
     * @param descriptors
     * @return std::vector<cv::DMatch>
     */
    std::vector<cv::DMatch> matches;
    _matcher->match(prev_descriptors, descriptors, matches);
    // sort matches by distance
    std::sort(matches.begin(), matches.end());
    return matches;
}

std::tuple<std::vector<cv::KeyPoint>, cv::Mat, std::vector<cv::DMatch>> ORBSLAM::compute(cv::Mat prev_frame, cv::Mat frame) {
    /**
     * @brief Extract and match feautres between the current frame and the previous frame
     * If there is no previous frame, then just extract features
     *
     * @param prev_frame
     * @param frame
     * @return std::tuple<std::vector<cv::KeyPoint>, cv:Mat, cv::DMatch>
     */
    std::vector<cv::KeyPoint> keypoints;
    cv::Mat descriptors;
    std::vector<cv::DMatch> matches;

    std::tie(keypoints, descriptors) = extract(frame);
    if (prev_frame.empty()) {
        _prev_descriptors = descriptors;
        _prev_keypoints = keypoints;
        return std::make_tuple(keypoints, descriptors, matches);
    }

    matches = match(_prev_descriptors, descriptors);
    _prev_descriptors = descriptors;
    _prev_keypoints = keypoints;
    return std::make_tuple(keypoints, descriptors, matches);
}

