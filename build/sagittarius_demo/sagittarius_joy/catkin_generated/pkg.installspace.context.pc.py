# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "roscpp;rospy;joy;sdk_sagittarius_arm;sensor_msgs".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lsagittarius_joy".split(';') if "-lsagittarius_joy" != "" else []
PROJECT_NAME = "sagittarius_joy"
PROJECT_SPACE_DIR = "/home/xrlab23/ROS_Files/sagittarius_ws/install"
PROJECT_VERSION = "0.0.0"
