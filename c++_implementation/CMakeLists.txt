cmake_minimum_required(VERSION 3.22)
project(orbslam_flutter)
find_package(OpenCV REQUIRED)

# target_include_directories(slam.cpp
# PRIVATE
# ${PROJECT_SOURCE_DIR}/include
# )
# Create a sources variable with a link to all cpp files to compile
set(SOURCES
    src/slam.cpp
    src/orbslam.cpp
)
add_executable(slam ${SOURCES})
include_directories(${OpenCV_INCLUDE_DIRS} include)
target_link_libraries(slam ${OpenCV_LIBS})