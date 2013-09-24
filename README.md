ROS Continuous Integration Tools
================================

### Examples

#### Travis

Example `.travis.yml`:
```yml
language: [cpp, python]
python: ["2.7"]
compiler: [gcc]
before_install:
  - export SRC_PATHS="$(pwd)"
  - export EXTRA_CMAKE_ARGS="-DENABLE_CORBA=ON -DCORBA_IMPLEMENTATION=OMNIORB"
  - wget https://raw.github.com/jhu-lcsr/ros_ci_tools/master/ros_ci_bootstrap.sh  
  - chmod +x ros_ci_bootstrap.sh
  - ./ros_ci_bootstrap.sh
install:
  # Build in an isolated catkin workspace
  - source /opt/ros/hydro/setup.bash
  - catkin_make_isolated --install --source . -j1 --cmake-args $EXTRA_CMAKE_ARGS
script: ""
```
