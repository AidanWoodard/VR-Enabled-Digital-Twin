# Install script for directory: /home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_perception/sagittarius_object_color_detector

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/xrlab23/ROS_Files/sagittarius_ws/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/action" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_perception/sagittarius_object_color_detector/action/SGRCtrl.action")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/msg" TYPE FILE FILES
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
    "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/cmake" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/build/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detector-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/include/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/roseus/ros/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/common-lisp/ros/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/gennodejs/ros/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/xrlab23/ROS_Files/sagittarius_ws/devel/lib/python3/dist-packages/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/lib/python3/dist-packages/sagittarius_object_color_detector")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/sagittarius_object_color_detector" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/include/sagittarius_object_color_detector/HSVParamsConfig.h")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/sagittarius_object_color_detector" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/lib/python3/dist-packages/sagittarius_object_color_detector/__init__.py")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/xrlab23/ROS_Files/sagittarius_ws/devel/lib/python3/dist-packages/sagittarius_object_color_detector/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages/sagittarius_object_color_detector" TYPE DIRECTORY FILES "/home/xrlab23/ROS_Files/sagittarius_ws/devel/lib/python3/dist-packages/sagittarius_object_color_detector/cfg")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/build/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detector.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/cmake" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/build/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detector-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector/cmake" TYPE FILE FILES
    "/home/xrlab23/ROS_Files/sagittarius_ws/build/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detectorConfig.cmake"
    "/home/xrlab23/ROS_Files/sagittarius_ws/build/sagittarius_perception/sagittarius_object_color_detector/catkin_generated/installspace/sagittarius_object_color_detectorConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/sagittarius_object_color_detector" TYPE FILE FILES "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_perception/sagittarius_object_color_detector/package.xml")
endif()

