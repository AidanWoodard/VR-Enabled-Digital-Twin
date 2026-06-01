;; Auto-generated. Do not edit!


(when (boundp 'sagittarius_joy::arm_joy)
  (if (not (find-package "SAGITTARIUS_JOY"))
    (make-package "SAGITTARIUS_JOY"))
  (shadow 'arm_joy (find-package "SAGITTARIUS_JOY")))
(unless (find-package "SAGITTARIUS_JOY::ARM_JOY")
  (make-package "SAGITTARIUS_JOY::ARM_JOY"))

(in-package "ROS")
;;//! \htmlinclude arm_joy.msg.html


(intern "*EE_X_INC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_X_INC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_X_INC* 1)
(intern "*EE_X_DEC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_X_DEC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_X_DEC* 2)
(intern "*EE_Y_INC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_Y_INC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_Y_INC* 3)
(intern "*EE_Y_DEC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_Y_DEC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_Y_DEC* 4)
(intern "*EE_Z_INC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_Z_INC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_Z_INC* 5)
(intern "*EE_Z_DEC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_Z_DEC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_Z_DEC* 6)
(intern "*EE_ROLL_CCW*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_ROLL_CCW* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_ROLL_CCW* 7)
(intern "*EE_ROLL_CW*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_ROLL_CW* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_ROLL_CW* 8)
(intern "*EE_PITCH_UP*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_PITCH_UP* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_PITCH_UP* 9)
(intern "*EE_PITCH_DOWN*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_PITCH_DOWN* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_PITCH_DOWN* 10)
(intern "*EE_YAW_LEFT*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_YAW_LEFT* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_YAW_LEFT* 11)
(intern "*EE_YAW_RIGHT*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*EE_YAW_RIGHT* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*EE_YAW_RIGHT* 12)
(intern "*UP_POSE*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*UP_POSE* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*UP_POSE* 13)
(intern "*HOME_POSE*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*HOME_POSE* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*HOME_POSE* 14)
(intern "*SLEEP_POSE*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*SLEEP_POSE* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*SLEEP_POSE* 15)
(intern "*POSITION_RESET*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*POSITION_RESET* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*POSITION_RESET* 16)
(intern "*ORIENTATION_RESET*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*ORIENTATION_RESET* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*ORIENTATION_RESET* 17)
(intern "*SPEED_INC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*SPEED_INC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*SPEED_INC* 18)
(intern "*SPEED_DEC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*SPEED_DEC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*SPEED_DEC* 19)
(intern "*GRIPPER_SPACING_INC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*GRIPPER_SPACING_INC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*GRIPPER_SPACING_INC* 20)
(intern "*GRIPPER_SPACING_DEC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*GRIPPER_SPACING_DEC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*GRIPPER_SPACING_DEC* 21)
(intern "*TORQUE_ON*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*TORQUE_ON* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*TORQUE_ON* 22)
(intern "*TORQUE_OFF*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*TORQUE_OFF* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*TORQUE_OFF* 23)
(intern "*TORQUE_INC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*TORQUE_INC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*TORQUE_INC* 24)
(intern "*TORQUE_DEC*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*TORQUE_DEC* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*TORQUE_DEC* 25)
(intern "*SUPER_KEY*" (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(shadow '*SUPER_KEY* (find-package "SAGITTARIUS_JOY::ARM_JOY"))
(defconstant sagittarius_joy::arm_joy::*SUPER_KEY* 26)

(defun sagittarius_joy::arm_joy-to-symbol (const)
  (cond
        ((= const 1) 'sagittarius_joy::arm_joy::*EE_X_INC*)
        ((= const 2) 'sagittarius_joy::arm_joy::*EE_X_DEC*)
        ((= const 3) 'sagittarius_joy::arm_joy::*EE_Y_INC*)
        ((= const 4) 'sagittarius_joy::arm_joy::*EE_Y_DEC*)
        ((= const 5) 'sagittarius_joy::arm_joy::*EE_Z_INC*)
        ((= const 6) 'sagittarius_joy::arm_joy::*EE_Z_DEC*)
        ((= const 7) 'sagittarius_joy::arm_joy::*EE_ROLL_CCW*)
        ((= const 8) 'sagittarius_joy::arm_joy::*EE_ROLL_CW*)
        ((= const 9) 'sagittarius_joy::arm_joy::*EE_PITCH_UP*)
        ((= const 10) 'sagittarius_joy::arm_joy::*EE_PITCH_DOWN*)
        ((= const 11) 'sagittarius_joy::arm_joy::*EE_YAW_LEFT*)
        ((= const 12) 'sagittarius_joy::arm_joy::*EE_YAW_RIGHT*)
        ((= const 13) 'sagittarius_joy::arm_joy::*UP_POSE*)
        ((= const 14) 'sagittarius_joy::arm_joy::*HOME_POSE*)
        ((= const 15) 'sagittarius_joy::arm_joy::*SLEEP_POSE*)
        ((= const 16) 'sagittarius_joy::arm_joy::*POSITION_RESET*)
        ((= const 17) 'sagittarius_joy::arm_joy::*ORIENTATION_RESET*)
        ((= const 18) 'sagittarius_joy::arm_joy::*SPEED_INC*)
        ((= const 19) 'sagittarius_joy::arm_joy::*SPEED_DEC*)
        ((= const 20) 'sagittarius_joy::arm_joy::*GRIPPER_SPACING_INC*)
        ((= const 21) 'sagittarius_joy::arm_joy::*GRIPPER_SPACING_DEC*)
        ((= const 22) 'sagittarius_joy::arm_joy::*TORQUE_ON*)
        ((= const 23) 'sagittarius_joy::arm_joy::*TORQUE_OFF*)
        ((= const 24) 'sagittarius_joy::arm_joy::*TORQUE_INC*)
        ((= const 25) 'sagittarius_joy::arm_joy::*TORQUE_DEC*)
        ((= const 26) 'sagittarius_joy::arm_joy::*SUPER_KEY*)
        (t nil)))

(defclass sagittarius_joy::arm_joy
  :super ros::object
  :slots (_ee_x_cmd _ee_y_cmd _ee_z_cmd _ee_roll_cmd _ee_pitch_cmd _ee_yaw_cmd _pose_cmd _reset_cmd _speed_cmd _gripper_spacing_cmd _torque_cmd _torque_lev_cmd _super_cmd ))

(defmethod sagittarius_joy::arm_joy
  (:init
   (&key
    ((:ee_x_cmd __ee_x_cmd) 0)
    ((:ee_y_cmd __ee_y_cmd) 0)
    ((:ee_z_cmd __ee_z_cmd) 0)
    ((:ee_roll_cmd __ee_roll_cmd) 0)
    ((:ee_pitch_cmd __ee_pitch_cmd) 0)
    ((:ee_yaw_cmd __ee_yaw_cmd) 0)
    ((:pose_cmd __pose_cmd) 0)
    ((:reset_cmd __reset_cmd) 0)
    ((:speed_cmd __speed_cmd) 0)
    ((:gripper_spacing_cmd __gripper_spacing_cmd) 0)
    ((:torque_cmd __torque_cmd) 0)
    ((:torque_lev_cmd __torque_lev_cmd) 0)
    ((:super_cmd __super_cmd) 0)
    )
   (send-super :init)
   (setq _ee_x_cmd (round __ee_x_cmd))
   (setq _ee_y_cmd (round __ee_y_cmd))
   (setq _ee_z_cmd (round __ee_z_cmd))
   (setq _ee_roll_cmd (round __ee_roll_cmd))
   (setq _ee_pitch_cmd (round __ee_pitch_cmd))
   (setq _ee_yaw_cmd (round __ee_yaw_cmd))
   (setq _pose_cmd (round __pose_cmd))
   (setq _reset_cmd (round __reset_cmd))
   (setq _speed_cmd (round __speed_cmd))
   (setq _gripper_spacing_cmd (round __gripper_spacing_cmd))
   (setq _torque_cmd (round __torque_cmd))
   (setq _torque_lev_cmd (round __torque_lev_cmd))
   (setq _super_cmd (round __super_cmd))
   self)
  (:ee_x_cmd
   (&optional __ee_x_cmd)
   (if __ee_x_cmd (setq _ee_x_cmd __ee_x_cmd)) _ee_x_cmd)
  (:ee_y_cmd
   (&optional __ee_y_cmd)
   (if __ee_y_cmd (setq _ee_y_cmd __ee_y_cmd)) _ee_y_cmd)
  (:ee_z_cmd
   (&optional __ee_z_cmd)
   (if __ee_z_cmd (setq _ee_z_cmd __ee_z_cmd)) _ee_z_cmd)
  (:ee_roll_cmd
   (&optional __ee_roll_cmd)
   (if __ee_roll_cmd (setq _ee_roll_cmd __ee_roll_cmd)) _ee_roll_cmd)
  (:ee_pitch_cmd
   (&optional __ee_pitch_cmd)
   (if __ee_pitch_cmd (setq _ee_pitch_cmd __ee_pitch_cmd)) _ee_pitch_cmd)
  (:ee_yaw_cmd
   (&optional __ee_yaw_cmd)
   (if __ee_yaw_cmd (setq _ee_yaw_cmd __ee_yaw_cmd)) _ee_yaw_cmd)
  (:pose_cmd
   (&optional __pose_cmd)
   (if __pose_cmd (setq _pose_cmd __pose_cmd)) _pose_cmd)
  (:reset_cmd
   (&optional __reset_cmd)
   (if __reset_cmd (setq _reset_cmd __reset_cmd)) _reset_cmd)
  (:speed_cmd
   (&optional __speed_cmd)
   (if __speed_cmd (setq _speed_cmd __speed_cmd)) _speed_cmd)
  (:gripper_spacing_cmd
   (&optional __gripper_spacing_cmd)
   (if __gripper_spacing_cmd (setq _gripper_spacing_cmd __gripper_spacing_cmd)) _gripper_spacing_cmd)
  (:torque_cmd
   (&optional __torque_cmd)
   (if __torque_cmd (setq _torque_cmd __torque_cmd)) _torque_cmd)
  (:torque_lev_cmd
   (&optional __torque_lev_cmd)
   (if __torque_lev_cmd (setq _torque_lev_cmd __torque_lev_cmd)) _torque_lev_cmd)
  (:super_cmd
   (&optional __super_cmd)
   (if __super_cmd (setq _super_cmd __super_cmd)) _super_cmd)
  (:serialization-length
   ()
   (+
    ;; int8 _ee_x_cmd
    1
    ;; int8 _ee_y_cmd
    1
    ;; int8 _ee_z_cmd
    1
    ;; int8 _ee_roll_cmd
    1
    ;; int8 _ee_pitch_cmd
    1
    ;; int8 _ee_yaw_cmd
    1
    ;; int8 _pose_cmd
    1
    ;; int8 _reset_cmd
    1
    ;; int8 _speed_cmd
    1
    ;; int8 _gripper_spacing_cmd
    1
    ;; int8 _torque_cmd
    1
    ;; int8 _torque_lev_cmd
    1
    ;; int8 _super_cmd
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int8 _ee_x_cmd
       (write-byte _ee_x_cmd s)
     ;; int8 _ee_y_cmd
       (write-byte _ee_y_cmd s)
     ;; int8 _ee_z_cmd
       (write-byte _ee_z_cmd s)
     ;; int8 _ee_roll_cmd
       (write-byte _ee_roll_cmd s)
     ;; int8 _ee_pitch_cmd
       (write-byte _ee_pitch_cmd s)
     ;; int8 _ee_yaw_cmd
       (write-byte _ee_yaw_cmd s)
     ;; int8 _pose_cmd
       (write-byte _pose_cmd s)
     ;; int8 _reset_cmd
       (write-byte _reset_cmd s)
     ;; int8 _speed_cmd
       (write-byte _speed_cmd s)
     ;; int8 _gripper_spacing_cmd
       (write-byte _gripper_spacing_cmd s)
     ;; int8 _torque_cmd
       (write-byte _torque_cmd s)
     ;; int8 _torque_lev_cmd
       (write-byte _torque_lev_cmd s)
     ;; int8 _super_cmd
       (write-byte _super_cmd s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int8 _ee_x_cmd
     (setq _ee_x_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ee_x_cmd 127) (setq _ee_x_cmd (- _ee_x_cmd 256)))
   ;; int8 _ee_y_cmd
     (setq _ee_y_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ee_y_cmd 127) (setq _ee_y_cmd (- _ee_y_cmd 256)))
   ;; int8 _ee_z_cmd
     (setq _ee_z_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ee_z_cmd 127) (setq _ee_z_cmd (- _ee_z_cmd 256)))
   ;; int8 _ee_roll_cmd
     (setq _ee_roll_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ee_roll_cmd 127) (setq _ee_roll_cmd (- _ee_roll_cmd 256)))
   ;; int8 _ee_pitch_cmd
     (setq _ee_pitch_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ee_pitch_cmd 127) (setq _ee_pitch_cmd (- _ee_pitch_cmd 256)))
   ;; int8 _ee_yaw_cmd
     (setq _ee_yaw_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _ee_yaw_cmd 127) (setq _ee_yaw_cmd (- _ee_yaw_cmd 256)))
   ;; int8 _pose_cmd
     (setq _pose_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _pose_cmd 127) (setq _pose_cmd (- _pose_cmd 256)))
   ;; int8 _reset_cmd
     (setq _reset_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _reset_cmd 127) (setq _reset_cmd (- _reset_cmd 256)))
   ;; int8 _speed_cmd
     (setq _speed_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _speed_cmd 127) (setq _speed_cmd (- _speed_cmd 256)))
   ;; int8 _gripper_spacing_cmd
     (setq _gripper_spacing_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _gripper_spacing_cmd 127) (setq _gripper_spacing_cmd (- _gripper_spacing_cmd 256)))
   ;; int8 _torque_cmd
     (setq _torque_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _torque_cmd 127) (setq _torque_cmd (- _torque_cmd 256)))
   ;; int8 _torque_lev_cmd
     (setq _torque_lev_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _torque_lev_cmd 127) (setq _torque_lev_cmd (- _torque_lev_cmd 256)))
   ;; int8 _super_cmd
     (setq _super_cmd (sys::peek buf ptr- :char)) (incf ptr- 1)
     (if (> _super_cmd 127) (setq _super_cmd (- _super_cmd 256)))
   ;;
   self)
  )

(setf (get sagittarius_joy::arm_joy :md5sum-) "aee021bfef1da6cac98533007e49228c")
(setf (get sagittarius_joy::arm_joy :datatype-) "sagittarius_joy/arm_joy")
(setf (get sagittarius_joy::arm_joy :definition-)
      "
# This message is used specifically in the sagittarius_joy package
#
# Maps raw 'joy' commands to more specific ones to control an sagittarius

# enum values that define the joystick controls for the robot

#########################################################################################################

# Control the motion of the virtual 'ee_gripper_link' or end effector using the modern_robotics_ik engine
# Position Control
int8 EE_X_INC = 1
int8 EE_X_DEC = 2
int8 EE_Y_INC = 3
int8 EE_Y_DEC = 4
int8 EE_Z_INC = 5
int8 EE_Z_DEC = 6

# Orientation Control
int8 EE_ROLL_CCW = 7
int8 EE_ROLL_CW = 8
int8 EE_PITCH_UP = 9
int8 EE_PITCH_DOWN = 10
int8 EE_YAW_LEFT = 11
int8 EE_YAW_RIGHT = 12

#########################################################################################################

# Control the motion of independent joints on the Arm or send predefined robot poses
# Pose Control
int8 UP_POSE = 13
int8 HOME_POSE = 14
int8 SLEEP_POSE = 15

# Position and Orientation reset
int8 POSITION_RESET = 16
int8 ORIENTATION_RESET = 17

#########################################################################################################

# Customize configurations for the Sagittarius Arm
# Inc/Dec Joint speed
int8 SPEED_INC = 18
int8 SPEED_DEC = 19

# Inc/Dec Gripper spacing
int8 GRIPPER_SPACING_INC = 20
int8 GRIPPER_SPACING_DEC = 21

# Torque On/Off all servos
int8 TORQUE_ON = 22
int8 TORQUE_OFF = 23

# Torque Inc/Dec all servos
int8 TORQUE_INC = 24
int8 TORQUE_DEC = 25

#########################################################################################################

# Other function for the Sagittarius Arm
# Super Key
int8 SUPER_KEY = 26

#########################################################################################################

# Control the motion of the Sagittarius Arm
int8 ee_x_cmd
int8 ee_y_cmd
int8 ee_z_cmd
int8 ee_roll_cmd
int8 ee_pitch_cmd
int8 ee_yaw_cmd

# Independent Joint/Pose Control
int8 pose_cmd
int8 reset_cmd

# Misc. Configs
int8 speed_cmd
int8 gripper_spacing_cmd
int8 torque_cmd
int8 torque_lev_cmd

# Super key
int8 super_cmd

")



(provide :sagittarius_joy/arm_joy "aee021bfef1da6cac98533007e49228c")


