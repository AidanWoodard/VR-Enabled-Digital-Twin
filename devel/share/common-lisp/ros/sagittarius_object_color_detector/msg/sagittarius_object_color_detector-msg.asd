
(cl:in-package :asdf)

(defsystem "sagittarius_object_color_detector-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :actionlib_msgs-msg
               :std_msgs-msg
)
  :components ((:file "_package")
    (:file "SGRCtrlAction" :depends-on ("_package_SGRCtrlAction"))
    (:file "_package_SGRCtrlAction" :depends-on ("_package"))
    (:file "SGRCtrlActionFeedback" :depends-on ("_package_SGRCtrlActionFeedback"))
    (:file "_package_SGRCtrlActionFeedback" :depends-on ("_package"))
    (:file "SGRCtrlActionGoal" :depends-on ("_package_SGRCtrlActionGoal"))
    (:file "_package_SGRCtrlActionGoal" :depends-on ("_package"))
    (:file "SGRCtrlActionResult" :depends-on ("_package_SGRCtrlActionResult"))
    (:file "_package_SGRCtrlActionResult" :depends-on ("_package"))
    (:file "SGRCtrlFeedback" :depends-on ("_package_SGRCtrlFeedback"))
    (:file "_package_SGRCtrlFeedback" :depends-on ("_package"))
    (:file "SGRCtrlGoal" :depends-on ("_package_SGRCtrlGoal"))
    (:file "_package_SGRCtrlGoal" :depends-on ("_package"))
    (:file "SGRCtrlResult" :depends-on ("_package_SGRCtrlResult"))
    (:file "_package_SGRCtrlResult" :depends-on ("_package"))
  ))