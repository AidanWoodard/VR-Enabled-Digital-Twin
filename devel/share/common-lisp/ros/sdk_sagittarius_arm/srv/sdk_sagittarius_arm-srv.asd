
(cl:in-package :asdf)

(defsystem "sdk_sagittarius_arm-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ArmInfo" :depends-on ("_package_ArmInfo"))
    (:file "_package_ArmInfo" :depends-on ("_package"))
    (:file "ServoRtInfo" :depends-on ("_package_ServoRtInfo"))
    (:file "_package_ServoRtInfo" :depends-on ("_package"))
  ))