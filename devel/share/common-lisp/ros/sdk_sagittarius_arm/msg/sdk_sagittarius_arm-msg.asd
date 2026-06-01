
(cl:in-package :asdf)

(defsystem "sdk_sagittarius_arm-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "ArmRadControl" :depends-on ("_package_ArmRadControl"))
    (:file "_package_ArmRadControl" :depends-on ("_package"))
    (:file "SingleRadControl" :depends-on ("_package_SingleRadControl"))
    (:file "_package_SingleRadControl" :depends-on ("_package"))
  ))