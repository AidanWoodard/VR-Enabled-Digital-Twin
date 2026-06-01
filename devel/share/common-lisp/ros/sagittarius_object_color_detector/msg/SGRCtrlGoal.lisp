; Auto-generated. Do not edit!


(cl:in-package sagittarius_object_color_detector-msg)


;//! \htmlinclude SGRCtrlGoal.msg.html

(cl:defclass <SGRCtrlGoal> (roslisp-msg-protocol:ros-message)
  ((grasp_type
    :reader grasp_type
    :initarg :grasp_type
    :type cl:fixnum
    :initform 0)
   (action_type
    :reader action_type
    :initarg :action_type
    :type cl:fixnum
    :initform 0)
   (pos_x
    :reader pos_x
    :initarg :pos_x
    :type cl:float
    :initform 0.0)
   (pos_y
    :reader pos_y
    :initarg :pos_y
    :type cl:float
    :initform 0.0)
   (pos_z
    :reader pos_z
    :initarg :pos_z
    :type cl:float
    :initform 0.0)
   (pos_roll
    :reader pos_roll
    :initarg :pos_roll
    :type cl:float
    :initform 0.0)
   (pos_pitch
    :reader pos_pitch
    :initarg :pos_pitch
    :type cl:float
    :initform 0.0)
   (pos_yaw
    :reader pos_yaw
    :initarg :pos_yaw
    :type cl:float
    :initform 0.0))
)

(cl:defclass SGRCtrlGoal (<SGRCtrlGoal>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SGRCtrlGoal>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SGRCtrlGoal)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sagittarius_object_color_detector-msg:<SGRCtrlGoal> is deprecated: use sagittarius_object_color_detector-msg:SGRCtrlGoal instead.")))

(cl:ensure-generic-function 'grasp_type-val :lambda-list '(m))
(cl:defmethod grasp_type-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:grasp_type-val is deprecated.  Use sagittarius_object_color_detector-msg:grasp_type instead.")
  (grasp_type m))

(cl:ensure-generic-function 'action_type-val :lambda-list '(m))
(cl:defmethod action_type-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:action_type-val is deprecated.  Use sagittarius_object_color_detector-msg:action_type instead.")
  (action_type m))

(cl:ensure-generic-function 'pos_x-val :lambda-list '(m))
(cl:defmethod pos_x-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:pos_x-val is deprecated.  Use sagittarius_object_color_detector-msg:pos_x instead.")
  (pos_x m))

(cl:ensure-generic-function 'pos_y-val :lambda-list '(m))
(cl:defmethod pos_y-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:pos_y-val is deprecated.  Use sagittarius_object_color_detector-msg:pos_y instead.")
  (pos_y m))

(cl:ensure-generic-function 'pos_z-val :lambda-list '(m))
(cl:defmethod pos_z-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:pos_z-val is deprecated.  Use sagittarius_object_color_detector-msg:pos_z instead.")
  (pos_z m))

(cl:ensure-generic-function 'pos_roll-val :lambda-list '(m))
(cl:defmethod pos_roll-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:pos_roll-val is deprecated.  Use sagittarius_object_color_detector-msg:pos_roll instead.")
  (pos_roll m))

(cl:ensure-generic-function 'pos_pitch-val :lambda-list '(m))
(cl:defmethod pos_pitch-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:pos_pitch-val is deprecated.  Use sagittarius_object_color_detector-msg:pos_pitch instead.")
  (pos_pitch m))

(cl:ensure-generic-function 'pos_yaw-val :lambda-list '(m))
(cl:defmethod pos_yaw-val ((m <SGRCtrlGoal>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sagittarius_object_color_detector-msg:pos_yaw-val is deprecated.  Use sagittarius_object_color_detector-msg:pos_yaw instead.")
  (pos_yaw m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<SGRCtrlGoal>)))
    "Constants for message type '<SGRCtrlGoal>"
  '((:GRASP_NONE . 0)
    (:GRASP_OPEN . 1)
    (:GRASP_CLOSE . 2)
    (:ACTION_TYPE_XYZ . 0)
    (:ACTION_TYPE_XYZ_RPY . 1)
    (:ACTION_TYPE_DEFINE_STAY . 2)
    (:ACTION_TYPE_DEFINE_SAVE . 3)
    (:ACTION_TYPE_PICK_XYZ . 4)
    (:ACTION_TYPE_PICK_XYZ_RPY . 5)
    (:ACTION_TYPE_PUT_XYZ . 6)
    (:ACTION_TYPE_PUT_XYZ_RPY . 7))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'SGRCtrlGoal)))
    "Constants for message type 'SGRCtrlGoal"
  '((:GRASP_NONE . 0)
    (:GRASP_OPEN . 1)
    (:GRASP_CLOSE . 2)
    (:ACTION_TYPE_XYZ . 0)
    (:ACTION_TYPE_XYZ_RPY . 1)
    (:ACTION_TYPE_DEFINE_STAY . 2)
    (:ACTION_TYPE_DEFINE_SAVE . 3)
    (:ACTION_TYPE_PICK_XYZ . 4)
    (:ACTION_TYPE_PICK_XYZ_RPY . 5)
    (:ACTION_TYPE_PUT_XYZ . 6)
    (:ACTION_TYPE_PUT_XYZ_RPY . 7))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SGRCtrlGoal>) ostream)
  "Serializes a message object of type '<SGRCtrlGoal>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'grasp_type)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action_type)) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_z))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_roll))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_pitch))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'pos_yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SGRCtrlGoal>) istream)
  "Deserializes a message object of type '<SGRCtrlGoal>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'grasp_type)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'action_type)) (cl:read-byte istream))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_x) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_y) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_z) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_roll) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_pitch) (roslisp-utils:decode-double-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pos_yaw) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SGRCtrlGoal>)))
  "Returns string type for a message object of type '<SGRCtrlGoal>"
  "sagittarius_object_color_detector/SGRCtrlGoal")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SGRCtrlGoal)))
  "Returns string type for a message object of type 'SGRCtrlGoal"
  "sagittarius_object_color_detector/SGRCtrlGoal")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SGRCtrlGoal>)))
  "Returns md5sum for a message object of type '<SGRCtrlGoal>"
  "50de9136543629965d564bc3ef4187c9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SGRCtrlGoal)))
  "Returns md5sum for a message object of type 'SGRCtrlGoal"
  "50de9136543629965d564bc3ef4187c9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SGRCtrlGoal>)))
  "Returns full string definition for message of type '<SGRCtrlGoal>"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# Define the goal~%~%# grasp_type 参数的定义项~%# 设置当前夹爪状态，在动作执行之前设置~%uint8 GRASP_NONE = 0 # 自定义动作下使用，夹爪不做处理~%uint8 GRASP_OPEN = 1 # 打开夹爪, 放下动作~%uint8 GRASP_CLOSE = 2 # 闭合夹爪, 抓取动作~%~%# action_type 参数的定义项~%# 需要执行动作的类型，可以指定末端姿态或者自动计算~%# 自定义姿态：是让机械臂到某个目标点~%# 预设动作：是执行某个预设的一系列动作~%uint8 ACTION_TYPE_XYZ = 0 # 自定义姿态：末端姿态使用动态计算~%uint8 ACTION_TYPE_XYZ_RPY = 1 # 自定义姿态：末端姿态使用给定姿态~%uint8 ACTION_TYPE_DEFINE_STAY = 2 # 预设动作：待机状态~%uint8 ACTION_TYPE_DEFINE_SAVE = 3 # 预设动作：安全位置状态~%uint8 ACTION_TYPE_PICK_XYZ = 4 # 预设动作：XYZ拾取动作~%uint8 ACTION_TYPE_PICK_XYZ_RPY = 5 # 预设动作：XYZ+RPY拾取动作~%uint8 ACTION_TYPE_PUT_XYZ = 6 # 预设动作：XYZ放下动作~%uint8 ACTION_TYPE_PUT_XYZ_RPY = 7 # 预设动作：XYZ+RPY放下动作~%~%uint8 grasp_type  # 末端初始化状态~%uint8 action_type  # 动作类型~%~%# 目标点位置~%float64 pos_x~%float64 pos_y~%float64 pos_z~%float64 pos_roll~%float64 pos_pitch~%float64 pos_yaw~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SGRCtrlGoal)))
  "Returns full string definition for message of type 'SGRCtrlGoal"
  (cl:format cl:nil "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======~%# Define the goal~%~%# grasp_type 参数的定义项~%# 设置当前夹爪状态，在动作执行之前设置~%uint8 GRASP_NONE = 0 # 自定义动作下使用，夹爪不做处理~%uint8 GRASP_OPEN = 1 # 打开夹爪, 放下动作~%uint8 GRASP_CLOSE = 2 # 闭合夹爪, 抓取动作~%~%# action_type 参数的定义项~%# 需要执行动作的类型，可以指定末端姿态或者自动计算~%# 自定义姿态：是让机械臂到某个目标点~%# 预设动作：是执行某个预设的一系列动作~%uint8 ACTION_TYPE_XYZ = 0 # 自定义姿态：末端姿态使用动态计算~%uint8 ACTION_TYPE_XYZ_RPY = 1 # 自定义姿态：末端姿态使用给定姿态~%uint8 ACTION_TYPE_DEFINE_STAY = 2 # 预设动作：待机状态~%uint8 ACTION_TYPE_DEFINE_SAVE = 3 # 预设动作：安全位置状态~%uint8 ACTION_TYPE_PICK_XYZ = 4 # 预设动作：XYZ拾取动作~%uint8 ACTION_TYPE_PICK_XYZ_RPY = 5 # 预设动作：XYZ+RPY拾取动作~%uint8 ACTION_TYPE_PUT_XYZ = 6 # 预设动作：XYZ放下动作~%uint8 ACTION_TYPE_PUT_XYZ_RPY = 7 # 预设动作：XYZ+RPY放下动作~%~%uint8 grasp_type  # 末端初始化状态~%uint8 action_type  # 动作类型~%~%# 目标点位置~%float64 pos_x~%float64 pos_y~%float64 pos_z~%float64 pos_roll~%float64 pos_pitch~%float64 pos_yaw~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SGRCtrlGoal>))
  (cl:+ 0
     1
     1
     8
     8
     8
     8
     8
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SGRCtrlGoal>))
  "Converts a ROS message object to a list"
  (cl:list 'SGRCtrlGoal
    (cl:cons ':grasp_type (grasp_type msg))
    (cl:cons ':action_type (action_type msg))
    (cl:cons ':pos_x (pos_x msg))
    (cl:cons ':pos_y (pos_y msg))
    (cl:cons ':pos_z (pos_z msg))
    (cl:cons ':pos_roll (pos_roll msg))
    (cl:cons ':pos_pitch (pos_pitch msg))
    (cl:cons ':pos_yaw (pos_yaw msg))
))
