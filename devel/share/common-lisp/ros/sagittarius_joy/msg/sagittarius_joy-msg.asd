
(cl:in-package :asdf)

(defsystem "sagittarius_joy-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "arm_joy" :depends-on ("_package_arm_joy"))
    (:file "_package_arm_joy" :depends-on ("_package"))
  ))