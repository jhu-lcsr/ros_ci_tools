#!/usr/bin/env bash

# Env defaults
[ -z "$ROS_DISTRO" ] && ROS_DISTRO="hydro"
[ -z "$SRC_PATHS" ] && SRC_PATHS=$(pwd)

echo "[ros_ci_tools] Bootstraping a ROS $ROS_DISTRO installation..."

# Add the ubuntu package repos
sudo sh -c 'echo "deb http://packages.ros.org/ros/ubuntu precise main" > /etc/apt/sources.list.d/ros-latest.list'
# Get the apt key
wget http://packages.ros.org/ros.key -O - | sudo apt-key add -

# Update package indexes
sudo apt-get update -qq
sudo apt-get install -qq -y python-catkin-pkg python-rosdep ros-$ROS_DISTRO-catkin
sudo rosdep init
rosdep update
rosdep install --from-paths $SRC_PATHS --ignore-src --rosdistro $ROS_DISTRO -y > /dev/null
