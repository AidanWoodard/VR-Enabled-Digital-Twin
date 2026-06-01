; Auto-generated. Do not edit!


(cl:in-package sdk_sagittarius_arm-msg)


;//! \htmlinclude SingleRadControl.msg.html

(cl:defclass <SingleRadControl> (roslisp-msg-protocol:ros-message)
  ((joint_name
    :reader joint_name
    :initarg :joint_name
    :type cl:string
    :initform "")
   (rad
    :reader rad
    :initarg :rad
    :type cl:float
    :initform 0.0))
)

(cl:defclass SingleRadControl (<SingleRadControl>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SingleRadControl>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SingleRadControl)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sdk_sagittarius_arm-msg:<SingleRadControl> is deprecated: use sdk_sagittarius_arm-msg:SingleRadControl instead.")))

(cl:ensure-generic-function 'joint_name-val :lambda-list '(m))
(cl:defmethod joint_name-val ((m <SingleRadControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-msg:joint_name-val is deprecated.  Use sdk_sagittarius_arm-msg:joint_name instead.")
  (joint_name m))

(cl:ensure-generic-function 'rad-val :lambda-list '(m))
(cl:defmethod rad-val ((m <SingleRadControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-msg:rad-val is deprecated.  Use sdk_sagittarius_arm-msg:rad instead.")
  (rad m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SingleRadControl>) ostream)
  "Serializes a message object of type '<SingleRadControl>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'joint_name))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'joint_name))
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'rad))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SingleRadControl>) istream)
  "Deserializes a message object of type '<SingleRadControl>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'joint_name) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'joint_name) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'rad) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SingleRadControl>)))
  "Returns string type for a message object of type '<SingleRadControl>"
  "sdk_sagittarius_arm/SingleRadControl")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SingleRadControl)))
  "Returns string type for a message object of type 'SingleRadControl"
  "sdk_sagittarius_arm/SingleRadControl")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SingleRadControl>)))
  "Returns md5sum for a message object of type '<SingleRadControl>"
  "22b26ccad5f2f7c78e2804a1f134b947")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SingleRadControl)))
  "Returns md5sum for a message object of type 'SingleRadControl"
  "22b26ccad5f2f7c78e2804a1f134b947")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SingleRadControl>)))
  "Returns full string definition for message of type '<SingleRadControl>"
  (cl:format cl:nil "# 单个舵机控制~%~%string joint_name~%float64 rad~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SingleRadControl)))
  "Returns full string definition for message of type 'SingleRadControl"
  (cl:format cl:nil "# 单个舵机控制~%~%string joint_name~%float64 rad~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SingleRadControl>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'joint_name))
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SingleRadControl>))
  "Converts a ROS message object to a list"
  (cl:list 'SingleRadControl
    (cl:cons ':joint_name (joint_name msg))
    (cl:cons ':rad (rad msg))
))
