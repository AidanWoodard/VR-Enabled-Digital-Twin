;; Auto-generated. Do not edit!


(when (boundp 'sdk_sagittarius_arm::ArmRadControl)
  (if (not (find-package "SDK_SAGITTARIUS_ARM"))
    (make-package "SDK_SAGITTARIUS_ARM"))
  (shadow 'ArmRadControl (find-package "SDK_SAGITTARIUS_ARM")))
(unless (find-package "SDK_SAGITTARIUS_ARM::ARMRADCONTROL")
  (make-package "SDK_SAGITTARIUS_ARM::ARMRADCONTROL"))

(in-package "ROS")
;;//! \htmlinclude ArmRadControl.msg.html


(defclass sdk_sagittarius_arm::ArmRadControl
  :super ros::object
  :slots (_rad ))

(defmethod sdk_sagittarius_arm::ArmRadControl
  (:init
   (&key
    ((:rad __rad) (make-array 0 :initial-element 0.0 :element-type :float))
    )
   (send-super :init)
   (setq _rad __rad)
   self)
  (:rad
   (&optional __rad)
   (if __rad (setq _rad __rad)) _rad)
  (:serialization-length
   ()
   (+
    ;; float64[] _rad
    (* 8    (length _rad)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64[] _rad
     (write-long (length _rad) s)
     (dotimes (i (length _rad))
       (sys::poke (elt _rad i) (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64[] _rad
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rad (instantiate float-vector n))
     (dotimes (i n)
     (setf (elt _rad i) (sys::peek buf ptr- :double)) (incf ptr- 8)
     ))
   ;;
   self)
  )

(setf (get sdk_sagittarius_arm::ArmRadControl :md5sum-) "11133516b4bf16d55157ff6eccb0ffe0")
(setf (get sdk_sagittarius_arm::ArmRadControl :datatype-) "sdk_sagittarius_arm/ArmRadControl")
(setf (get sdk_sagittarius_arm::ArmRadControl :definition-)
      "# 目标位置的数组

float64[] rad

")



(provide :sdk_sagittarius_arm/ArmRadControl "11133516b4bf16d55157ff6eccb0ffe0")


