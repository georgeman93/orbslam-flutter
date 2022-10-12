#include <opencv2/opencv.hpp>
#include <iostream>
#include "orbslam.hpp"

int main(int argc, char** argv) {
    ORBSLAM orb = ORBSLAM();
    cv::Mat grey;
    cv::Mat prev_grey;
    std::vector<cv::KeyPoint> keypoints;
    cv::Mat descriptors;
    std::vector<cv::DMatch> matches;

    std::cout << "Using OpenCV version " << CV_VERSION_MAJOR << "." << CV_VERSION_MINOR << "." << CV_VERSION_REVISION << std::endl;
    cv::VideoCapture cap("test.mp4");

    if (!cap.isOpened()) {
        std::cout << "Error opening video stream or file" << std::endl;
        return -1;
    }

    while (1) {
        cv::Mat frame;
        cap >> frame; // get a new frame from camera
        if (frame.empty()) {
            std::cout << "Empty frame" << std::endl;
            break;
        }

        // convert to grayscale
        cv::cvtColor(frame, grey, cv::COLOR_BGR2GRAY);

        // extract features, descriptors and matches across frames
        std::tie(keypoints, descriptors, matches) = orb.compute(prev_grey, grey);

        prev_grey = grey.clone();

        // draw the keypoints
        cv::drawKeypoints(frame, keypoints, frame, cv::Scalar(255, 0, 0), cv::DrawMatchesFlags::DRAW_RICH_KEYPOINTS);

        cv::imshow("Frame", frame);

        char c = (char)cv::waitKey(30);
        if (c == 27) // Esc key
            break;
    }


    cap.release();
    cv::destroyAllWindows();
    return 0;
}