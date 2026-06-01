# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sdk_sagittarius_arm: 2 messages, 2 services")

set(MSG_I_FLAGS "-Isdk_sagittarius_arm:/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sdk_sagittarius_arm_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" NAME_WE)
add_custom_target(_sdk_sagittarius_arm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sdk_sagittarius_arm" "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" ""
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" NAME_WE)
add_custom_target(_sdk_sagittarius_arm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sdk_sagittarius_arm" "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" ""
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" NAME_WE)
add_custom_target(_sdk_sagittarius_arm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sdk_sagittarius_arm" "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" ""
)

get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" NAME_WE)
add_custom_target(_sdk_sagittarius_arm_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sdk_sagittarius_arm" "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_msg_cpp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Services
_generate_srv_cpp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_srv_cpp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Module File
_generate_module_cpp(sdk_sagittarius_arm
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sdk_sagittarius_arm_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sdk_sagittarius_arm_generate_messages sdk_sagittarius_arm_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_cpp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_cpp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_cpp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_cpp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sdk_sagittarius_arm_gencpp)
add_dependencies(sdk_sagittarius_arm_gencpp sdk_sagittarius_arm_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sdk_sagittarius_arm_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_msg_eus(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Services
_generate_srv_eus(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_srv_eus(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Module File
_generate_module_eus(sdk_sagittarius_arm
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sdk_sagittarius_arm_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sdk_sagittarius_arm_generate_messages sdk_sagittarius_arm_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_eus _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_eus _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_eus _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_eus _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sdk_sagittarius_arm_geneus)
add_dependencies(sdk_sagittarius_arm_geneus sdk_sagittarius_arm_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sdk_sagittarius_arm_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_msg_lisp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Services
_generate_srv_lisp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_srv_lisp(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Module File
_generate_module_lisp(sdk_sagittarius_arm
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sdk_sagittarius_arm_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sdk_sagittarius_arm_generate_messages sdk_sagittarius_arm_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_lisp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_lisp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_lisp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_lisp _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sdk_sagittarius_arm_genlisp)
add_dependencies(sdk_sagittarius_arm_genlisp sdk_sagittarius_arm_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sdk_sagittarius_arm_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_msg_nodejs(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Services
_generate_srv_nodejs(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_srv_nodejs(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Module File
_generate_module_nodejs(sdk_sagittarius_arm
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sdk_sagittarius_arm_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sdk_sagittarius_arm_generate_messages sdk_sagittarius_arm_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_nodejs _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_nodejs _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_nodejs _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_nodejs _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sdk_sagittarius_arm_gennodejs)
add_dependencies(sdk_sagittarius_arm_gennodejs sdk_sagittarius_arm_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sdk_sagittarius_arm_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_msg_py(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Services
_generate_srv_py(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm
)
_generate_srv_py(sdk_sagittarius_arm
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm
)

### Generating Module File
_generate_module_py(sdk_sagittarius_arm
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sdk_sagittarius_arm_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sdk_sagittarius_arm_generate_messages sdk_sagittarius_arm_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/ArmRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_py _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/msg/SingleRadControl.msg" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_py _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ArmInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_py _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sdk_sagittarius_arm/srv/ServoRtInfo.srv" NAME_WE)
add_dependencies(sdk_sagittarius_arm_generate_messages_py _sdk_sagittarius_arm_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sdk_sagittarius_arm_genpy)
add_dependencies(sdk_sagittarius_arm_genpy sdk_sagittarius_arm_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sdk_sagittarius_arm_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sdk_sagittarius_arm
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(sdk_sagittarius_arm_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sdk_sagittarius_arm
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(sdk_sagittarius_arm_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sdk_sagittarius_arm
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(sdk_sagittarius_arm_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sdk_sagittarius_arm
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(sdk_sagittarius_arm_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sdk_sagittarius_arm
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(sdk_sagittarius_arm_generate_messages_py std_msgs_generate_messages_py)
endif()
