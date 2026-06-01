# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sagittarius_object_color_detector: 7 messages, 0 services")

set(MSG_I_FLAGS "-Isagittarius_object_color_detector:/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Iactionlib_msgs:/opt/ros/noetic/share/actionlib_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sagittarius_object_color_detector_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" "std_msgs/Header:sagittarius_object_color_detector/SGRCtrlGoal:sagittarius_object_color_detector/SGRCtrlFeedback:sagittarius_object_color_detector/SGRCtrlResult:sagittarius_object_color_detector/SGRCtrlActionGoal:sagittarius_object_color_detector/SGRCtrlActionResult:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:sagittarius_object_color_detector/SGRCtrlActionFeedback"
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" "std_msgs/Header:sagittarius_object_color_detector/SGRCtrlGoal:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" "sagittarius_object_color_detector/SGRCtrlResult:std_msgs/Header:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID"
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" "std_msgs/Header:actionlib_msgs/GoalStatus:actionlib_msgs/GoalID:sagittarius_object_color_detector/SGRCtrlFeedback"
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" ""
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" ""
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" NAME_WE)
add_custom_target(_sagittarius_object_color_detector_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_object_color_detector" "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_cpp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
)

### Generating Services

### Generating Module File
_generate_module_cpp(sagittarius_object_color_detector
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sagittarius_object_color_detector_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sagittarius_object_color_detector_generate_messages sagittarius_object_color_detector_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_cpp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_object_color_detector_gencpp)
add_dependencies(sagittarius_object_color_detector_gencpp sagittarius_object_color_detector_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_object_color_detector_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_eus(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
)

### Generating Services

### Generating Module File
_generate_module_eus(sagittarius_object_color_detector
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sagittarius_object_color_detector_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sagittarius_object_color_detector_generate_messages sagittarius_object_color_detector_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_eus _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_object_color_detector_geneus)
add_dependencies(sagittarius_object_color_detector_geneus sagittarius_object_color_detector_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_object_color_detector_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_lisp(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
)

### Generating Services

### Generating Module File
_generate_module_lisp(sagittarius_object_color_detector
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sagittarius_object_color_detector_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sagittarius_object_color_detector_generate_messages sagittarius_object_color_detector_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_lisp _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_object_color_detector_genlisp)
add_dependencies(sagittarius_object_color_detector_genlisp sagittarius_object_color_detector_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_object_color_detector_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_nodejs(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
)

### Generating Services

### Generating Module File
_generate_module_nodejs(sagittarius_object_color_detector
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sagittarius_object_color_detector_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sagittarius_object_color_detector_generate_messages sagittarius_object_color_detector_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_object_color_detector_gennodejs)
add_dependencies(sagittarius_object_color_detector_gennodejs sagittarius_object_color_detector_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_object_color_detector_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg"
  "${MSG_I_FLAGS}"
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalStatus.msg;/opt/ros/noetic/share/actionlib_msgs/cmake/../msg/GoalID.msg;/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)
_generate_msg_py(sagittarius_object_color_detector
  "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
)

### Generating Services

### Generating Module File
_generate_module_py(sagittarius_object_color_detector
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sagittarius_object_color_detector_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sagittarius_object_color_detector_generate_messages sagittarius_object_color_detector_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlAction.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlActionFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlGoal.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlResult.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/devel/share/sagittarius_object_color_detector/msg/SGRCtrlFeedback.msg" NAME_WE)
add_dependencies(sagittarius_object_color_detector_generate_messages_py _sagittarius_object_color_detector_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_object_color_detector_genpy)
add_dependencies(sagittarius_object_color_detector_genpy sagittarius_object_color_detector_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_object_color_detector_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_object_color_detector
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET actionlib_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_cpp actionlib_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_object_color_detector
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(sagittarius_object_color_detector_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(sagittarius_object_color_detector_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(sagittarius_object_color_detector_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET actionlib_msgs_generate_messages_eus)
  add_dependencies(sagittarius_object_color_detector_generate_messages_eus actionlib_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_object_color_detector
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET actionlib_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_object_color_detector_generate_messages_lisp actionlib_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_object_color_detector
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET actionlib_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_object_color_detector_generate_messages_nodejs actionlib_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_object_color_detector
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(sagittarius_object_color_detector_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(sagittarius_object_color_detector_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(sagittarius_object_color_detector_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET actionlib_msgs_generate_messages_py)
  add_dependencies(sagittarius_object_color_detector_generate_messages_py actionlib_msgs_generate_messages_py)
endif()
