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
  - wget h
  - export SRC_PATHS="$(pwd)"
  - export EXTRA_CMAKE_ARGS="-DENABLE_CORBA=ON -DCORBA_IMPLEMENTATION=OMNIORB"
install:
  # Build in an isolated catkin workspace
  - source /opt/ros/hydro/setup.bash
  - catkin_make_isolated --install --source . -j1 --cmake-args $EXTRA_CMAKE_ARGS

script: ""
```
