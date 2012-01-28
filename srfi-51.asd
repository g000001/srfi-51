;;;; srfi-51.asd

(cl:in-package :asdf)

(defsystem :srfi-51
  :serial t
  :depends-on (:fiveam
               :mbe
               :srfi-1
               :srfi-5
               :srfi-23)
  :components ((:file "package")
               (:file "util")
               (:file "srfi-51")
               (:file "test")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-51))))
  (load-system :srfi-51)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-51.internal :srfi-51))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))
