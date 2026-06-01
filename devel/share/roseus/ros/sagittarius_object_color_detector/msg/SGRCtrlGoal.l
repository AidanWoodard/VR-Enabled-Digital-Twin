;; Auto-generated. Do not edit!


(when (boundp 'sagittarius_object_color_detector::SGRCtrlGoal)
  (if (not (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR"))
    (make-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR"))
  (shadow 'SGRCtrlGoal (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR")))
(unless (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL")
  (make-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))

(in-package "ROS")
;;//! \htmlinclude SGRCtrlGoal.msg.html


(intern "*GRASP_NONE*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*GRASP_NONE* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*GRASP_NONE* 0)
(intern "*GRASP_OPEN*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*GRASP_OPEN* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*GRASP_OPEN* 1)
(intern "*GRASP_CLOSE*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*GRASP_CLOSE* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*GRASP_CLOSE* 2)
(intern "*ACTION_TYPE_XYZ*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_XYZ* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_XYZ* 0)
(intern "*ACTION_TYPE_XYZ_RPY*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_XYZ_RPY* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_XYZ_RPY* 1)
(intern "*ACTION_TYPE_DEFINE_STAY*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_DEFINE_STAY* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_DEFINE_STAY* 2)
(intern "*ACTION_TYPE_DEFINE_SAVE*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_DEFINE_SAVE* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_DEFINE_SAVE* 3)
(intern "*ACTION_TYPE_PICK_XYZ*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_PICK_XYZ* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PICK_XYZ* 4)
(intern "*ACTION_TYPE_PICK_XYZ_RPY*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_PICK_XYZ_RPY* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PICK_XYZ_RPY* 5)
(intern "*ACTION_TYPE_PUT_XYZ*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_PUT_XYZ* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PUT_XYZ* 6)
(intern "*ACTION_TYPE_PUT_XYZ_RPY*" (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(shadow '*ACTION_TYPE_PUT_XYZ_RPY* (find-package "SAGITTARIUS_OBJECT_COLOR_DETECTOR::SGRCTRLGOAL"))
(defconstant sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PUT_XYZ_RPY* 7)

(defun sagittarius_object_color_detector::SGRCtrlGoal-to-symbol (const)
  (cond
        ((= const 0) 'sagittarius_object_color_detector::SGRCtrlGoal::*GRASP_NONE*)
        ((= const 1) 'sagittarius_object_color_detector::SGRCtrlGoal::*GRASP_OPEN*)
        ((= const 2) 'sagittarius_object_color_detector::SGRCtrlGoal::*GRASP_CLOSE*)
        ((= const 0) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_XYZ*)
        ((= const 1) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_XYZ_RPY*)
        ((= const 2) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_DEFINE_STAY*)
        ((= const 3) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_DEFINE_SAVE*)
        ((= const 4) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PICK_XYZ*)
        ((= const 5) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PICK_XYZ_RPY*)
        ((= const 6) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PUT_XYZ*)
        ((= const 7) 'sagittarius_object_color_detector::SGRCtrlGoal::*ACTION_TYPE_PUT_XYZ_RPY*)
        (t nil)))

(defclass sagittarius_object_color_detector::SGRCtrlGoal
  :super ros::object
  :slots (_grasp_type _action_type _pos_x _pos_y _pos_z _pos_roll _pos_pitch _pos_yaw ))

(defmethod sagittarius_object_color_detector::SGRCtrlGoal
  (:init
   (&key
    ((:grasp_type __grasp_type) 0)
    ((:action_type __action_type) 0)
    ((:pos_x __pos_x) 0.0)
    ((:pos_y __pos_y) 0.0)
    ((:pos_z __pos_z) 0.0)
    ((:pos_roll __pos_roll) 0.0)
    ((:pos_pitch __pos_pitch) 0.0)
    ((:pos_yaw __pos_yaw) 0.0)
    )
   (send-super :init)
   (setq _grasp_type (round __grasp_type))
   (setq _action_type (round __action_type))
   (setq _pos_x (float __pos_x))
   (setq _pos_y (float __pos_y))
   (setq _pos_z (float __pos_z))
   (setq _pos_roll (float __pos_roll))
   (setq _pos_pitch (float __pos_pitch))
   (setq _pos_yaw (float __pos_yaw))
   self)
  (:grasp_type
   (&optional __grasp_type)
   (if __grasp_type (setq _grasp_type __grasp_type)) _grasp_type)
  (:action_type
   (&optional __action_type)
   (if __action_type (setq _action_type __action_type)) _action_type)
  (:pos_x
   (&optional __pos_x)
   (if __pos_x (setq _pos_x __pos_x)) _pos_x)
  (:pos_y
   (&optional __pos_y)
   (if __pos_y (setq _pos_y __pos_y)) _pos_y)
  (:pos_z
   (&optional __pos_z)
   (if __pos_z (setq _pos_z __pos_z)) _pos_z)
  (:pos_roll
   (&optional __pos_roll)
   (if __pos_roll (setq _pos_roll __pos_roll)) _pos_roll)
  (:pos_pitch
   (&optional __pos_pitch)
   (if __pos_pitch (setq _pos_pitch __pos_pitch)) _pos_pitch)
  (:pos_yaw
   (&optional __pos_yaw)
   (if __pos_yaw (setq _pos_yaw __pos_yaw)) _pos_yaw)
  (:serialization-length
   ()
   (+
    ;; uint8 _grasp_type
    1
    ;; uint8 _action_type
    1
    ;; float64 _pos_x
    8
    ;; float64 _pos_y
    8
    ;; float64 _pos_z
    8
    ;; float64 _pos_roll
    8
    ;; float64 _pos_pitch
    8
    ;; float64 _pos_yaw
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; uint8 _grasp_type
       (write-byte _grasp_type s)
     ;; uint8 _action_type
       (write-byte _action_type s)
     ;; float64 _pos_x
       (sys::poke _pos_x (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_y
       (sys::poke _pos_y (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_z
       (sys::poke _pos_z (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_roll
       (sys::poke _pos_roll (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_pitch
       (sys::poke _pos_pitch (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _pos_yaw
       (sys::poke _pos_yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; uint8 _grasp_type
     (setq _grasp_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _action_type
     (setq _action_type (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float64 _pos_x
     (setq _pos_x (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_y
     (setq _pos_y (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_z
     (setq _pos_z (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_roll
     (setq _pos_roll (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_pitch
     (setq _pos_pitch (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _pos_yaw
     (setq _pos_yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get sagittarius_object_color_detector::SGRCtrlGoal :md5sum-) "50de9136543629965d564bc3ef4187c9")
(setf (get sagittarius_object_color_detector::SGRCtrlGoal :datatype-) "sagittarius_object_color_detector/SGRCtrlGoal")
(setf (get sagittarius_object_color_detector::SGRCtrlGoal :definition-)
      "# ====== DO NOT MODIFY! AUTOGENERATED FROM AN ACTION DEFINITION ======
# Define the goal

# grasp_type 参数的定义项
# 设置当前夹爪状态，在动作执行之前设置
uint8 GRASP_NONE = 0 # 自定义动作下使用，夹爪不做处理
uint8 GRASP_OPEN = 1 # 打开夹爪, 放下动作
uint8 GRASP_CLOSE = 2 # 闭合夹爪, 抓取动作

# action_type 参数的定义项
# 需要执行动作的类型，可以指定末端姿态或者自动计算
# 自定义姿态：是让机械臂到某个目标点
# 预设动作：是执行某个预设的一系列动作
uint8 ACTION_TYPE_XYZ = 0 # 自定义姿态：末端姿态使用动态计算
uint8 ACTION_TYPE_XYZ_RPY = 1 # 自定义姿态：末端姿态使用给定姿态
uint8 ACTION_TYPE_DEFINE_STAY = 2 # 预设动作：待机状态
uint8 ACTION_TYPE_DEFINE_SAVE = 3 # 预设动作：安全位置状态
uint8 ACTION_TYPE_PICK_XYZ = 4 # 预设动作：XYZ拾取动作
uint8 ACTION_TYPE_PICK_XYZ_RPY = 5 # 预设动作：XYZ+RPY拾取动作
uint8 ACTION_TYPE_PUT_XYZ = 6 # 预设动作：XYZ放下动作
uint8 ACTION_TYPE_PUT_XYZ_RPY = 7 # 预设动作：XYZ+RPY放下动作

uint8 grasp_type  # 末端初始化状态
uint8 action_type  # 动作类型

# 目标点位置
float64 pos_x
float64 pos_y
float64 pos_z
float64 pos_roll
float64 pos_pitch
float64 pos_yaw


")



(provide :sagittarius_object_color_detector/SGRCtrlGoal "50de9136543629965d564bc3ef4187c9")


