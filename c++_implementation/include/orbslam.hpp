#pragma once
#include <iostream>
#include <opencv2/opencv.hpp>
#include "opencv2/video/tracking.hpp"
#include <opencv2/imgproc.hpp>

class ORBSLAM {
    /**
     * @brief So far we want to be able to give it a current and past frame
     * and get back matching features
     */
public:
    ORBSLAM();
    ~ORBSLAM();
    std::tuple<std::vector<cv::KeyPoint>, cv::Mat>  extract(cv::Mat frame);
    std::vector<cv::DMatch> match(cv::Mat descriptors1, cv::Mat descriptors2);
    std::tuple<std::vector<cv::KeyPoint>, cv::Mat, std::vector<cv::DMatch>> compute(cv::Mat prev_frame, cv::Mat frame);

private:
    cv::Ptr<cv::ORB> _orb;
    cv::Ptr<cv::DescriptorMatcher> _matcher;
    cv::Mat _prev_descriptors;
    std::vector<cv::KeyPoint> _prev_keypoints;
};
