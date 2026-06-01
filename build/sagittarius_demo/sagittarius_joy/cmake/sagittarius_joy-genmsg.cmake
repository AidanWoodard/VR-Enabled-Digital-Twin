# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "sagittarius_joy: 1 messages, 0 services")

set(MSG_I_FLAGS "-Isagittarius_joy:/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(sagittarius_joy_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" NAME_WE)
add_custom_target(_sagittarius_joy_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "sagittarius_joy" "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(sagittarius_joy
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_joy
)

### Generating Services

### Generating Module File
_generate_module_cpp(sagittarius_joy
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_joy
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(sagittarius_joy_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(sagittarius_joy_generate_messages sagittarius_joy_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" NAME_WE)
add_dependencies(sagittarius_joy_generate_messages_cpp _sagittarius_joy_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_joy_gencpp)
add_dependencies(sagittarius_joy_gencpp sagittarius_joy_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_joy_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(sagittarius_joy
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_joy
)

### Generating Services

### Generating Module File
_generate_module_eus(sagittarius_joy
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_joy
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(sagittarius_joy_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(sagittarius_joy_generate_messages sagittarius_joy_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" NAME_WE)
add_dependencies(sagittarius_joy_generate_messages_eus _sagittarius_joy_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_joy_geneus)
add_dependencies(sagittarius_joy_geneus sagittarius_joy_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_joy_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(sagittarius_joy
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_joy
)

### Generating Services

### Generating Module File
_generate_module_lisp(sagittarius_joy
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_joy
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(sagittarius_joy_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(sagittarius_joy_generate_messages sagittarius_joy_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" NAME_WE)
add_dependencies(sagittarius_joy_generate_messages_lisp _sagittarius_joy_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_joy_genlisp)
add_dependencies(sagittarius_joy_genlisp sagittarius_joy_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_joy_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(sagittarius_joy
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_joy
)

### Generating Services

### Generating Module File
_generate_module_nodejs(sagittarius_joy
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_joy
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(sagittarius_joy_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(sagittarius_joy_generate_messages sagittarius_joy_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" NAME_WE)
add_dependencies(sagittarius_joy_generate_messages_nodejs _sagittarius_joy_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_joy_gennodejs)
add_dependencies(sagittarius_joy_gennodejs sagittarius_joy_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_joy_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(sagittarius_joy
  "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_joy
)

### Generating Services

### Generating Module File
_generate_module_py(sagittarius_joy
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_joy
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(sagittarius_joy_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(sagittarius_joy_generate_messages sagittarius_joy_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/xrlab23/ROS_Files/sagittarius_ws/src/sagittarius_demo/sagittarius_joy/msg/arm_joy.msg" NAME_WE)
add_dependencies(sagittarius_joy_generate_messages_py _sagittarius_joy_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(sagittarius_joy_genpy)
add_dependencies(sagittarius_joy_genpy sagittarius_joy_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS sagittarius_joy_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_joy)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/sagittarius_joy
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_joy_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_joy_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(sagittarius_joy_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_joy)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/sagittarius_joy
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(sagittarius_joy_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(sagittarius_joy_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(sagittarius_joy_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_joy)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/sagittarius_joy
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_joy_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_joy_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(sagittarius_joy_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_joy)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/sagittarius_joy
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_joy_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_joy_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(sagittarius_joy_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_joy)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_joy\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/sagittarius_joy
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(sagittarius_joy_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(sagittarius_joy_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(sagittarius_joy_generate_messages_py std_msgs_generate_messages_py)
endif()
