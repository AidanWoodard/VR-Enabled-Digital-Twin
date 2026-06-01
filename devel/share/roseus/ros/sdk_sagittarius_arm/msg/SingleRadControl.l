;; Auto-generated. Do not edit!


(when (boundp 'sdk_sagittarius_arm::SingleRadControl)
  (if (not (find-package "SDK_SAGITTARIUS_ARM"))
    (make-package "SDK_SAGITTARIUS_ARM"))
  (shadow 'SingleRadControl (find-package "SDK_SAGITTARIUS_ARM")))
(unless (find-package "SDK_SAGITTARIUS_ARM::SINGLERADCONTROL")
  (make-package "SDK_SAGITTARIUS_ARM::SINGLERADCONTROL"))

(in-package "ROS")
;;//! \htmlinclude SingleRadControl.msg.html


(defclass sdk_sagittarius_arm::SingleRadControl
  :super ros::object
  :slots (_joint_name _rad ))

(defmethod sdk_sagittarius_arm::SingleRadControl
  (:init
   (&key
    ((:joint_name __joint_name) "")
    ((:rad __rad) 0.0)
    )
   (send-super :init)
   (setq _joint_name (string __joint_name))
   (setq _rad (float __rad))
   self)
  (:joint_name
   (&optional __joint_name)
   (if __joint_name (setq _joint_name __joint_name)) _joint_name)
  (:rad
   (&optional __rad)
   (if __rad (setq _rad __rad)) _rad)
  (:serialization-length
   ()
   (+
    ;; string _joint_name
    4 (length _joint_name)
    ;; float64 _rad
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _joint_name
       (write-long (length _joint_name) s) (princ _joint_name s)
     ;; float64 _rad
       (sys::poke _rad (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _joint_name
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _joint_name (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _rad
     (setq _rad (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get sdk_sagittarius_arm::SingleRadControl :md5sum-) "22b26ccad5f2f7c78e2804a1f134b947")
(setf (get sdk_sagittarius_arm::SingleRadControl :datatype-) "sdk_sagittarius_arm/SingleRadControl")
(setf (get sdk_sagittarius_arm::SingleRadControl :definition-)
      "# 单个舵机控制

string joint_name
float64 rad

")



(provide :sdk_sagittarius_arm/SingleRadControl "22b26ccad5f2f7c78e2804a1f134b947")


