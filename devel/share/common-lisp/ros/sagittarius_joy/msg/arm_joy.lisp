; Auto-generated. Do not edit!


(cl:in-package sagittarius_joy-msg)


;//! \htmlinclude arm_joy.msg.html

(cl:defclass <arm_joy> (roslisp-msg-protocol:ros-message)
  ((ee_x_cmd
    :reader ee_x_cmd
    :initarg :ee_x_cmd
    :type cl:fixnum
    :initform 0)
   (ee_y_cmd
    :reader ee_y_cmd
    :initarg :ee_y_cmd
    :type cl:fixnum
    :initform 0)
   (ee_z_cmd
    :reader ee_z_cmd
    :initarg :ee_z_cmd
    :type cl:fixnum
    :initform 0)
   (ee_roll_cmd
    :reader ee_roll_cmd
    :initarg :ee_roll_cmd
    :type cl:fixnum
    :initform 0)
   (ee_pitch_cmd
    :reader ee_pitch_cmd
    :initarg :ee_pitch_cmd
    :type cl:fixnum
    :initform 0)
   (ee_yaw_cmd
    :reader ee_yaw_cmd
    :initarg :ee_yaw_cmd
    :type cl:fixnum
    :initform 0)
   (pose_cmd
    :reader pose_cmd
    :initarg :pose_cmd
    :type cl:fixnum
    :initform 0)
   (reset_cmd
    :reader reset_cmd
    :initarg :reset_cmd
    :type cl:fixnum
    :initform 0)
   (speed_cmd
    :reader speed_cmd
    :initarg :speed_cmd
    :type cl:fixnum
    :initform 0)
   (gripper_spacing_cmd
    :reader gripper_spacing_cmd
    :initarg :gripper_spacing_cmd
    :type cl:fixnum
    :initform 0)
   (torque_cmd
    :reader torque_cmd
    :initarg :torque_cmd
    :type cl:fixnum
    :initform 0)
   (torque_lev_cmd
    :reader torque_lev_cmd
    :initarg :torque_lev_cmd
    :type cl:fixnum
    :initform 0)
   (super_cmd
    :reader super_cmd
    :initarg :super_cmd
    :type cl:fixnum
    :initform 0))
)

(cl:defclass arm_joy (<arm_joy>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <arm_joy>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'arm_joy)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sagittarius_joy-msg:<arm_joy> is deprecated: use sagittarius_joy-msg:arm_joy instead.")))

(cl:ensure-generic-function 'ee_x_cmd-val :lambda-list '(m))
(cl:defmethod ee_x_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:ee_x_cmd-val is deprecated.  Use sagittarius_joy-msg:ee_x_cmd instead.")
  (ee_x_cmd m))

(cl:ensure-generic-function 'ee_y_cmd-val :lambda-list '(m))
(cl:defmethod ee_y_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:ee_y_cmd-val is deprecated.  Use sagittarius_joy-msg:ee_y_cmd instead.")
  (ee_y_cmd m))

(cl:ensure-generic-function 'ee_z_cmd-val :lambda-list '(m))
(cl:defmethod ee_z_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:ee_z_cmd-val is deprecated.  Use sagittarius_joy-msg:ee_z_cmd instead.")
  (ee_z_cmd m))

(cl:ensure-generic-function 'ee_roll_cmd-val :lambda-list '(m))
(cl:defmethod ee_roll_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:ee_roll_cmd-val is deprecated.  Use sagittarius_joy-msg:ee_roll_cmd instead.")
  (ee_roll_cmd m))

(cl:ensure-generic-function 'ee_pitch_cmd-val :lambda-list '(m))
(cl:defmethod ee_pitch_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:ee_pitch_cmd-val is deprecated.  Use sagittarius_joy-msg:ee_pitch_cmd instead.")
  (ee_pitch_cmd m))

(cl:ensure-generic-function 'ee_yaw_cmd-val :lambda-list '(m))
(cl:defmethod ee_yaw_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:ee_yaw_cmd-val is deprecated.  Use sagittarius_joy-msg:ee_yaw_cmd instead.")
  (ee_yaw_cmd m))

(cl:ensure-generic-function 'pose_cmd-val :lambda-list '(m))
(cl:defmethod pose_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:pose_cmd-val is deprecated.  Use sagittarius_joy-msg:pose_cmd instead.")
  (pose_cmd m))

(cl:ensure-generic-function 'reset_cmd-val :lambda-list '(m))
(cl:defmethod reset_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:reset_cmd-val is deprecated.  Use sagittarius_joy-msg:reset_cmd instead.")
  (reset_cmd m))

(cl:ensure-generic-function 'speed_cmd-val :lambda-list '(m))
(cl:defmethod speed_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:speed_cmd-val is deprecated.  Use sagittarius_joy-msg:speed_cmd instead.")
  (speed_cmd m))

(cl:ensure-generic-function 'gripper_spacing_cmd-val :lambda-list '(m))
(cl:defmethod gripper_spacing_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:gripper_spacing_cmd-val is deprecated.  Use sagittarius_joy-msg:gripper_spacing_cmd instead.")
  (gripper_spacing_cmd m))

(cl:ensure-generic-function 'torque_cmd-val :lambda-list '(m))
(cl:defmethod torque_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:torque_cmd-val is deprecated.  Use sagittarius_joy-msg:torque_cmd instead.")
  (torque_cmd m))

(cl:ensure-generic-function 'torque_lev_cmd-val :lambda-list '(m))
(cl:defmethod torque_lev_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:torque_lev_cmd-val is deprecated.  Use sagittarius_joy-msg:torque_lev_cmd instead.")
  (torque_lev_cmd m))

(cl:ensure-generic-function 'super_cmd-val :lambda-list '(m))
(cl:defmethod super_cmd-val ((m <arm_joy>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_joy-msg:super_cmd-val is deprecated.  Use sagittarius_joy-msg:super_cmd instead.")
  (super_cmd m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<arm_joy>)))
    "Constants for message type '<arm_joy>"
  '((:EE_X_INC . 1)
    (:EE_X_DEC . 2)
    (:EE_Y_INC . 3)
    (:EE_Y_DEC . 4)
    (:EE_Z_INC . 5)
    (:EE_Z_DEC . 6)
    (:EE_ROLL_CCW . 7)
    (:EE_ROLL_CW . 8)
    (:EE_PITCH_UP . 9)
    (:EE_PITCH_DOWN . 10)
    (:EE_YAW_LEFT . 11)
    (:EE_YAW_RIGHT . 12)
    (:UP_POSE . 13)
    (:HOME_POSE . 14)
    (:SLEEP_POSE . 15)
    (:POSITION_RESET . 16)
    (:ORIENTATION_RESET . 17)
    (:SPEED_INC . 18)
    (:SPEED_DEC . 19)
    (:GRIPPER_SPACING_INC . 20)
    (:GRIPPER_SPACING_DEC . 21)
    (:TORQUE_ON . 22)
    (:TORQUE_OFF . 23)
    (:TORQUE_INC . 24)
    (:TORQUE_DEC . 25)
    (:SUPER_KEY . 26))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'arm_joy)))
    "Constants for message type 'arm_joy"
  '((:EE_X_INC . 1)
    (:EE_X_DEC . 2)
    (:EE_Y_INC . 3)
    (:EE_Y_DEC . 4)
    (:EE_Z_INC . 5)
    (:EE_Z_DEC . 6)
    (:EE_ROLL_CCW . 7)
    (:EE_ROLL_CW . 8)
    (:EE_PITCH_UP . 9)
    (:EE_PITCH_DOWN . 10)
    (:EE_YAW_LEFT . 11)
    (:EE_YAW_RIGHT . 12)
    (:UP_POSE . 13)
    (:HOME_POSE . 14)
    (:SLEEP_POSE . 15)
    (:POSITION_RESET . 16)
    (:ORIENTATION_RESET . 17)
    (:SPEED_INC . 18)
    (:SPEED_DEC . 19)
    (:GRIPPER_SPACING_INC . 20)
    (:GRIPPER_SPACING_DEC . 21)
    (:TORQUE_ON . 22)
    (:TORQUE_OFF . 23)
    (:TORQUE_INC . 24)
    (:TORQUE_DEC . 25)
    (:SUPER_KEY . 26))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <arm_joy>) ostream)
  "Serializes a message object of type '<arm_joy>"
  (cl:let* ((signed (cl:slot-value msg 'ee_x_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ee_y_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ee_z_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ee_roll_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ee_pitch_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'ee_yaw_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'pose_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'reset_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'speed_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'gripper_spacing_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'torque_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'torque_lev_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'super_cmd)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <arm_joy>) istream)
  "Deserializes a message object of type '<arm_joy>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ee_x_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ee_y_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ee_z_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ee_roll_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ee_pitch_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'ee_yaw_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'pose_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'reset_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'speed_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'gripper_spacing_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'torque_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'torque_lev_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'super_cmd) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<arm_joy>)))
  "Returns string type for a message object of type '<arm_joy>"
  "sagittarius_joy/arm_joy")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'arm_joy)))
  "Returns string type for a message object of type 'arm_joy"
  "sagittarius_joy/arm_joy")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<arm_joy>)))
  "Returns md5sum for a message object of type '<arm_joy>"
  "aee021bfef1da6cac98533007e49228c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'arm_joy)))
  "Returns md5sum for a message object of type 'arm_joy"
  "aee021bfef1da6cac98533007e49228c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<arm_joy>)))
  "Returns full string definition for message of type '<arm_joy>"
  (cl:format cl:nil "~%# This message is used specifically in the sagittarius_joy package~%#~%# Maps raw 'joy' commands to more specific ones to control an sagittarius~%~%# enum values that define the joystick controls for the robot~%~%#########################################################################################################~%~%# Control the motion of the virtual 'ee_gripper_link' or end effector using the modern_robotics_ik engine~%# Position Control~%int8 EE_X_INC = 1~%int8 EE_X_DEC = 2~%int8 EE_Y_INC = 3~%int8 EE_Y_DEC = 4~%int8 EE_Z_INC = 5~%int8 EE_Z_DEC = 6~%~%# Orientation Control~%int8 EE_ROLL_CCW = 7~%int8 EE_ROLL_CW = 8~%int8 EE_PITCH_UP = 9~%int8 EE_PITCH_DOWN = 10~%int8 EE_YAW_LEFT = 11~%int8 EE_YAW_RIGHT = 12~%~%#########################################################################################################~%~%# Control the motion of independent joints on the Arm or send predefined robot poses~%# Pose Control~%int8 UP_POSE = 13~%int8 HOME_POSE = 14~%int8 SLEEP_POSE = 15~%~%# Position and Orientation reset~%int8 POSITION_RESET = 16~%int8 ORIENTATION_RESET = 17~%~%#########################################################################################################~%~%# Customize configurations for the Sagittarius Arm~%# Inc/Dec Joint speed~%int8 SPEED_INC = 18~%int8 SPEED_DEC = 19~%~%# Inc/Dec Gripper spacing~%int8 GRIPPER_SPACING_INC = 20~%int8 GRIPPER_SPACING_DEC = 21~%~%# Torque On/Off all servos~%int8 TORQUE_ON = 22~%int8 TORQUE_OFF = 23~%~%# Torque Inc/Dec all servos~%int8 TORQUE_INC = 24~%int8 TORQUE_DEC = 25~%~%#########################################################################################################~%~%# Other function for the Sagittarius Arm~%# Super Key~%int8 SUPER_KEY = 26~%~%#########################################################################################################~%~%# Control the motion of the Sagittarius Arm~%int8 ee_x_cmd~%int8 ee_y_cmd~%int8 ee_z_cmd~%int8 ee_roll_cmd~%int8 ee_pitch_cmd~%int8 ee_yaw_cmd~%~%# Independent Joint/Pose Control~%int8 pose_cmd~%int8 reset_cmd~%~%# Misc. Configs~%int8 speed_cmd~%int8 gripper_spacing_cmd~%int8 torque_cmd~%int8 torque_lev_cmd~%~%# Super key~%int8 super_cmd~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'arm_joy)))
  "Returns full string definition for message of type 'arm_joy"
  (cl:format cl:nil "~%# This message is used specifically in the sagittarius_joy package~%#~%# Maps raw 'joy' commands to more specific ones to control an sagittarius~%~%# enum values that define the joystick controls for the robot~%~%#########################################################################################################~%~%# Control the motion of the virtual 'ee_gripper_link' or end effector using the modern_robotics_ik engine~%# Position Control~%int8 EE_X_INC = 1~%int8 EE_X_DEC = 2~%int8 EE_Y_INC = 3~%int8 EE_Y_DEC = 4~%int8 EE_Z_INC = 5~%int8 EE_Z_DEC = 6~%~%# Orientation Control~%int8 EE_ROLL_CCW = 7~%int8 EE_ROLL_CW = 8~%int8 EE_PITCH_UP = 9~%int8 EE_PITCH_DOWN = 10~%int8 EE_YAW_LEFT = 11~%int8 EE_YAW_RIGHT = 12~%~%#########################################################################################################~%~%# Control the motion of independent joints on the Arm or send predefined robot poses~%# Pose Control~%int8 UP_POSE = 13~%int8 HOME_POSE = 14~%int8 SLEEP_POSE = 15~%~%# Position and Orientation reset~%int8 POSITION_RESET = 16~%int8 ORIENTATION_RESET = 17~%~%#########################################################################################################~%~%# Customize configurations for the Sagittarius Arm~%# Inc/Dec Joint speed~%int8 SPEED_INC = 18~%int8 SPEED_DEC = 19~%~%# Inc/Dec Gripper spacing~%int8 GRIPPER_SPACING_INC = 20~%int8 GRIPPER_SPACING_DEC = 21~%~%# Torque On/Off all servos~%int8 TORQUE_ON = 22~%int8 TORQUE_OFF = 23~%~%# Torque Inc/Dec all servos~%int8 TORQUE_INC = 24~%int8 TORQUE_DEC = 25~%~%#########################################################################################################~%~%# Other function for the Sagittarius Arm~%# Super Key~%int8 SUPER_KEY = 26~%~%#########################################################################################################~%~%# Control the motion of the Sagittarius Arm~%int8 ee_x_cmd~%int8 ee_y_cmd~%int8 ee_z_cmd~%int8 ee_roll_cmd~%int8 ee_pitch_cmd~%int8 ee_yaw_cmd~%~%# Independent Joint/Pose Control~%int8 pose_cmd~%int8 reset_cmd~%~%# Misc. Configs~%int8 speed_cmd~%int8 gripper_spacing_cmd~%int8 torque_cmd~%int8 torque_lev_cmd~%~%# Super key~%int8 super_cmd~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <arm_joy>))
  (cl:+ 0
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <arm_joy>))
  "Converts a ROS message object to a list"
  (cl:list 'arm_joy
    (cl:cons ':ee_x_cmd (ee_x_cmd msg))
    (cl:cons ':ee_y_cmd (ee_y_cmd msg))
    (cl:cons ':ee_z_cmd (ee_z_cmd msg))
    (cl:cons ':ee_roll_cmd (ee_roll_cmd msg))
    (cl:cons ':ee_pitch_cmd (ee_pitch_cmd msg))
    (cl:cons ':ee_yaw_cmd (ee_yaw_cmd msg))
    (cl:cons ':pose_cmd (pose_cmd msg))
    (cl:cons ':reset_cmd (reset_cmd msg))
    (cl:cons ':speed_cmd (speed_cmd msg))
    (cl:cons ':gripper_spacing_cmd (gripper_spacing_cmd msg))
    (cl:cons ':torque_cmd (torque_cmd msg))
    (cl:cons ':torque_lev_cmd (torque_lev_cmd msg))
    (cl:cons ':super_cmd (super_cmd msg))
))
