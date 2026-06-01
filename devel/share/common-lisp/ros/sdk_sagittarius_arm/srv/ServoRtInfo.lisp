; Auto-generated. Do not edit!


(cl:in-package sdk_sagittarius_arm-srv)


;//! \htmlinclude ServoRtInfo-request.msg.html

(cl:defclass <ServoRtInfo-request> (roslisp-msg-protocol:ros-message)
  ((servo_id
    :reader servo_id
    :initarg :servo_id
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ServoRtInfo-request (<ServoRtInfo-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ServoRtInfo-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ServoRtInfo-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sdk_sagittarius_arm-srv:<ServoRtInfo-request> is deprecated: use sdk_sagittarius_arm-srv:ServoRtInfo-request instead.")))

(cl:ensure-generic-function 'servo_id-val :lambda-list '(m))
(cl:defmethod servo_id-val ((m <ServoRtInfo-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-srv:servo_id-val is deprecated.  Use sdk_sagittarius_arm-srv:servo_id instead.")
  (servo_id m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ServoRtInfo-request>) ostream)
  "Serializes a message object of type '<ServoRtInfo-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'servo_id)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ServoRtInfo-request>) istream)
  "Deserializes a message object of type '<ServoRtInfo-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'servo_id)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ServoRtInfo-request>)))
  "Returns string type for a service object of type '<ServoRtInfo-request>"
  "sdk_sagittarius_arm/ServoRtInfoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoRtInfo-request)))
  "Returns string type for a service object of type 'ServoRtInfo-request"
  "sdk_sagittarius_arm/ServoRtInfoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ServoRtInfo-request>)))
  "Returns md5sum for a message object of type '<ServoRtInfo-request>"
  "d3106e0c44e7c7adcad01214d53da198")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ServoRtInfo-request)))
  "Returns md5sum for a message object of type 'ServoRtInfo-request"
  "d3106e0c44e7c7adcad01214d53da198")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ServoRtInfo-request>)))
  "Returns full string definition for message of type '<ServoRtInfo-request>"
  (cl:format cl:nil "# Get servo realtime state~%# servo_id : 1~~7~%~%uint8 servo_id~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ServoRtInfo-request)))
  "Returns full string definition for message of type 'ServoRtInfo-request"
  (cl:format cl:nil "# Get servo realtime state~%# servo_id : 1~~7~%~%uint8 servo_id~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ServoRtInfo-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ServoRtInfo-request>))
  "Converts a ROS message object to a list"
  (cl:list 'ServoRtInfo-request
    (cl:cons ':servo_id (servo_id msg))
))
;//! \htmlinclude ServoRtInfo-response.msg.html

(cl:defclass <ServoRtInfo-response> (roslisp-msg-protocol:ros-message)
  ((speed
    :reader speed
    :initarg :speed
    :type cl:fixnum
    :initform 0)
   (payload
    :reader payload
    :initarg :payload
    :type cl:fixnum
    :initform 0)
   (voltage
    :reader voltage
    :initarg :voltage
    :type cl:fixnum
    :initform 0)
   (current
    :reader current
    :initarg :current
    :type cl:fixnum
    :initform 0))
)

(cl:defclass ServoRtInfo-response (<ServoRtInfo-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ServoRtInfo-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ServoRtInfo-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name sdk_sagittarius_arm-srv:<ServoRtInfo-response> is deprecated: use sdk_sagittarius_arm-srv:ServoRtInfo-response instead.")))

(cl:ensure-generic-function 'speed-val :lambda-list '(m))
(cl:defmethod speed-val ((m <ServoRtInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-srv:speed-val is deprecated.  Use sdk_sagittarius_arm-srv:speed instead.")
  (speed m))

(cl:ensure-generic-function 'payload-val :lambda-list '(m))
(cl:defmethod payload-val ((m <ServoRtInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-srv:payload-val is deprecated.  Use sdk_sagittarius_arm-srv:payload instead.")
  (payload m))

(cl:ensure-generic-function 'voltage-val :lambda-list '(m))
(cl:defmethod voltage-val ((m <ServoRtInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-srv:voltage-val is deprecated.  Use sdk_sagittarius_arm-srv:voltage instead.")
  (voltage m))

(cl:ensure-generic-function 'current-val :lambda-list '(m))
(cl:defmethod current-val ((m <ServoRtInfo-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader sdk_sagittarius_arm-srv:current-val is deprecated.  Use sdk_sagittarius_arm-srv:current instead.")
  (current m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ServoRtInfo-response>) ostream)
  "Serializes a message object of type '<ServoRtInfo-response>"
  (cl:let* ((signed (cl:slot-value msg 'speed)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'payload)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 65536) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'voltage)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'current)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'current)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ServoRtInfo-response>) istream)
  "Deserializes a message object of type '<ServoRtInfo-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'speed) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'payload) (cl:if (cl:< unsigned 32768) unsigned (cl:- unsigned 65536))))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'voltage)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'current)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'current)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ServoRtInfo-response>)))
  "Returns string type for a service object of type '<ServoRtInfo-response>"
  "sdk_sagittarius_arm/ServoRtInfoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoRtInfo-response)))
  "Returns string type for a service object of type 'ServoRtInfo-response"
  "sdk_sagittarius_arm/ServoRtInfoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ServoRtInfo-response>)))
  "Returns md5sum for a message object of type '<ServoRtInfo-response>"
  "d3106e0c44e7c7adcad01214d53da198")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ServoRtInfo-response)))
  "Returns md5sum for a message object of type 'ServoRtInfo-response"
  "d3106e0c44e7c7adcad01214d53da198")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ServoRtInfo-response>)))
  "Returns full string definition for message of type '<ServoRtInfo-response>"
  (cl:format cl:nil "~%# return the realtime state~%# speed(50step/s)~%# payload(0.1%)~%# voltage(0.1V)~%# current(1mA)~%int16 speed~%int16 payload~%uint8 voltage~%uint16 current~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ServoRtInfo-response)))
  "Returns full string definition for message of type 'ServoRtInfo-response"
  (cl:format cl:nil "~%# return the realtime state~%# speed(50step/s)~%# payload(0.1%)~%# voltage(0.1V)~%# current(1mA)~%int16 speed~%int16 payload~%uint8 voltage~%uint16 current~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ServoRtInfo-response>))
  (cl:+ 0
     2
     2
     1
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ServoRtInfo-response>))
  "Converts a ROS message object to a list"
  (cl:list 'ServoRtInfo-response
    (cl:cons ':speed (speed msg))
    (cl:cons ':payload (payload msg))
    (cl:cons ':voltage (voltage msg))
    (cl:cons ':current (current msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'ServoRtInfo)))
  'ServoRtInfo-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'ServoRtInfo)))
  'ServoRtInfo-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ServoRtInfo)))
  "Returns string type for a service object of type '<ServoRtInfo>"
  "sdk_sagittarius_arm/ServoRtInfo")