;; Auto-generated. Do not edit!


(when (boundp 'sdk_sagittarius_arm::ServoRtInfo)
  (if (not (find-package "SDK_SAGITTARIUS_ARM"))
    (make-package "SDK_SAGITTARIUS_ARM"))
  (shadow 'ServoRtInfo (find-package "SDK_SAGITTARIUS_ARM")))
(unless (find-package "SDK_SAGITTARIUS_ARM::SERVORTINFO")
  (make-package "SDK_SAGITTARIUS_ARM::SERVORTINFO"))
(unless (find-package "SDK_SAGITTARIUS_ARM::SERVORTINFOREQUEST")
  (make-package "SDK_SAGITTARIUS_ARM::SERVORTINFOREQUEST"))
(unless (find-package "SDK_SAGITTARIUS_ARM::SERVORTINFORESPONSE")
  (make-package "SDK_SAGITTARIUS_ARM::SERVORTINFORESPONSE"))

(in-package "ROS")





(defclass sdk_sagittarius_arm::ServoRtInfoRequest
  :super ros::object
  :slots (_servo_id ))

(defmethod sdk_sagittarius_arm::ServoRtInfoRequest
  (:init
   (&key
    ((:servo_id __servo_id) 0)
    )
   (send-super :init)
   (setq _servo_id (round __servo_id))
   self)
  (:servo_id
   (&optional __servo_id)
   (if __servo_id (setq _servo_id __servo_id)) _servo_id)
  (:serialization-length
   ()
   (+
    ;; uint8 _servo_id
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _servo_id
       (write-byte _servo_id s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _servo_id
     (setq _servo_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;;
   self)
  )

(defclass sdk_sagittarius_arm::ServoRtInfoResponse
  :super ros::object
  :slots (_speed _payload _voltage _current ))

(defmethod sdk_sagittarius_arm::ServoRtInfoResponse
  (:init
   (&key
    ((:speed __speed) 0)
    ((:payload __payload) 0)
    ((:voltage __voltage) 0)
    ((:current __current) 0)
    )
   (send-super :init)
   (setq _speed (round __speed))
   (setq _payload (round __payload))
   (setq _voltage (round __voltage))
   (setq _current (round __current))
   self)
  (:speed
   (&optional __speed)
   (if __speed (setq _speed __speed)) _speed)
  (:payload
   (&optional __payload)
   (if __payload (setq _payload __payload)) _payload)
  (:voltage
   (&optional __voltage)
   (if __voltage (setq _voltage __voltage)) _voltage)
  (:current
   (&optional __current)
   (if __current (setq _current __current)) _current)
  (:serialization-length
   ()
   (+
    ;; int16 _speed
    2
    ;; int16 _payload
    2
    ;; uint8 _voltage
    1
    ;; uint16 _current
    2
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int16 _speed
       (write-word _speed s)
     ;; int16 _payload
       (write-word _payload s)
     ;; uint8 _voltage
       (write-byte _voltage s)
     ;; uint16 _current
       (write-word _current s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int16 _speed
     (setq _speed (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; int16 _payload
     (setq _payload (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;; uint8 _voltage
     (setq _voltage (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint16 _current
     (setq _current (sys::peek buf ptr- :short)) (incf ptr- 2)
   ;;
   self)
  )

(defclass sdk_sagittarius_arm::ServoRtInfo
  :super ros::object
  :slots ())

(setf (get sdk_sagittarius_arm::ServoRtInfo :md5sum-) "d3106e0c44e7c7adcad01214d53da198")
(setf (get sdk_sagittarius_arm::ServoRtInfo :datatype-) "sdk_sagittarius_arm/ServoRtInfo")
(setf (get sdk_sagittarius_arm::ServoRtInfo :request) sdk_sagittarius_arm::ServoRtInfoRequest)
(setf (get sdk_sagittarius_arm::ServoRtInfo :response) sdk_sagittarius_arm::ServoRtInfoResponse)

(defmethod sdk_sagittarius_arm::ServoRtInfoRequest
  (:response () (instance sdk_sagittarius_arm::ServoRtInfoResponse :init)))

(setf (get sdk_sagittarius_arm::ServoRtInfoRequest :md5sum-) "d3106e0c44e7c7adcad01214d53da198")
(setf (get sdk_sagittarius_arm::ServoRtInfoRequest :datatype-) "sdk_sagittarius_arm/ServoRtInfoRequest")
(setf (get sdk_sagittarius_arm::ServoRtInfoRequest :definition-)
      "# Get servo realtime state
# servo_id : 1~7

uint8 servo_id

---

# return the realtime state
# speed(50step/s)
# payload(0.1%)
# voltage(0.1V)
# current(1mA)
int16 speed
int16 payload
uint8 voltage
uint16 current


")

(setf (get sdk_sagittarius_arm::ServoRtInfoResponse :md5sum-) "d3106e0c44e7c7adcad01214d53da198")
(setf (get sdk_sagittarius_arm::ServoRtInfoResponse :datatype-) "sdk_sagittarius_arm/ServoRtInfoResponse")
(setf (get sdk_sagittarius_arm::ServoRtInfoResponse :definition-)
      "# Get servo realtime state
# servo_id : 1~7

uint8 servo_id

---

# return the realtime state
# speed(50step/s)
# payload(0.1%)
# voltage(0.1V)
# current(1mA)
int16 speed
int16 payload
uint8 voltage
uint16 current


")



(provide :sdk_sagittarius_arm/ServoRtInfo "d3106e0c44e7c7adcad01214d53da198")


