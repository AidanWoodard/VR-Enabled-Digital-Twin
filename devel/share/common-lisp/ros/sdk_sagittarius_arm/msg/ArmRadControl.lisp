; Auto-generated. Do not edit!


(cl:in-package sdk_sagittarius_arm-msg)


;//! \htmlinclude ArmRadControl.msg.html

(cl:defclass <ArmRadControl> (roslisp-msg-protocol:ros-message)
  ((rad
    :reader rad
    :initarg :rad
    :type (cl:vector cl:float)
   :initform (cl:make-array 0 :element-type 'cl:float :initial-element 0.0)))
)

(cl:defclass ArmRadControl (<ArmRadControl>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ArmRadControl>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ArmRadControl)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sdk_sagittarius_arm-msg:<ArmRadControl> is deprecated: use sdk_sagittarius_arm-msg:ArmRadControl instead.")))

(cl:ensure-generic-function 'rad-val :lambda-list '(m))
(cl:defmethod rad-val ((m <ArmRadControl>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-msg:rad-val is deprecated.  Use sdk_sagittarius_arm-msg:rad instead.")
  (rad m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ArmRadControl>) ostream)
  "Serializes a message object of type '<ArmRadControl>"
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'rad))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (cl:let ((bits (roslisp-utils:encode-double-float-bits ele)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream)))
   (cl:slot-value msg 'rad))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ArmRadControl>) istream)
  "Deserializes a message object of type '<ArmRadControl>"
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'rad) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'rad)))
    (cl:dotimes (i __ros_arr_len)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:aref vals i) (roslisp-utils:decode-double-float-bits bits))))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ArmRadControl>)))
  "Returns string type for a message object of type '<ArmRadControl>"
  "sdk_sagittarius_arm/ArmRadControl")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ArmRadControl)))
  "Returns string type for a message object of type 'ArmRadControl"
  "sdk_sagittarius_arm/ArmRadControl")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ArmRadControl>)))
  "Returns md5sum for a message object of type '<ArmRadControl>"
  "11133516b4bf16d55157ff6eccb0ffe0")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ArmRadControl)))
  "Returns md5sum for a message object of type 'ArmRadControl"
  "11133516b4bf16d55157ff6eccb0ffe0")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ArmRadControl>)))
  "Returns full string definition for message of type '<ArmRadControl>"
  (cl:format cl:nil "# 目标位置的数组~%~%float64[] rad~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ArmRadControl)))
  "Returns full string definition for message of type 'ArmRadControl"
  (cl:format cl:nil "# 目标位置的数组~%~%float64[] rad~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ArmRadControl>))
  (cl:+ 0
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'rad) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ 8)))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ArmRadControl>))
  "Converts a ROS message object to a list"
  (cl:list 'ArmRadControl
    (cl:cons ':rad (rad msg))
))
