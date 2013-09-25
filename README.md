ROS Continuous Integration Tools
================================

### Travis Examples

#### Isolated Catkin Build

```yml
language: [cpp, python]
python: ["2.7"]
compiler: [gcc]
before_install:
  # Define some config vars
  - export CI_SOURCE_PATH=$(pwd)
  # Bootstrap a minimal ROS installation
  - git clone https://raw.github.com/jhu-lcsr/ros_ci_tools /tmp/ros_ci_tools && export PATH=/tmp/ros_ci_tools:$PATH
  - ros_ci_bootstrap
  - source /opt/ros/$ROS_DISTRO/setup.bash
  - push_catkin_ws_isolated ~/ws_isolated
  # Clone other source deps
  - ln -s $CI_SOURCE_PATH src/
  # Install dependencies for source repos
  - rosdep install --from-paths src --ignore-src --rosdistro $ROS_DISTRO -y > /dev/null
install:
  # Build in an isolated catkin workspace
  - export EXTRA_CMAKE_ARGS="-DENABLE_CORBA=ON -DCORBA_IMPLEMENTATION=OMNIORB"
  - catkin_make_isolated --install --source . -j1 --cmake-args $EXTRA_CMAKE_ARGS
script:
  # Run tests... 
  - ""
```

#### Isolated Catkin Underlay with Normal Catkin Build

```yml
language: [cpp, python]
python: ["2.7"]
compiler: [gcc]
before_install:
  # Define some config vars
  - export EXTRA_CMAKE_ARGS="-DENABLE_CORBA=ON -DCORBA_IMPLEMENTATION=OMNIORB"
  # Bootstrap a minimal ROS installation
  - wget https://raw.github.com/jhu-lcsr/ros_ci_tools/master/ros_ci_bootstrap.sh && chmod +x ros_ci_bootstrap.sh
  - ./ros_ci_bootstrap.sh
  # Install dependencies
  - rosdep install --from-paths . --ignore-src --rosdistro $ROS_DISTRO -y > /dev/null
install:
  # Build in an isolated catkin workspace
  - source /opt/ros/hydro/setup.bash
  - catkin_make_isolated --install --source . -j1 --cmake-args $EXTRA_CMAKE_ARGS
script:
  # Run tests... 
  - ""
```
