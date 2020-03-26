;;;; srfi-51.asd

(cl:in-package :asdf)


(defsystem :srfi-51
  :version "20200327"
  :description "SRFI 51 for CL: Handling rest list"
  :long-description "SRFI 51 for CL: Handling rest list
https://srfi.schemers.org/srfi-51"
  :author "Joo ChurlSoo"
  :maintainer "CHIBA Masaomi"
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


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-51))))
  (let ((name "https://github.com/g000001/srfi-51")
        (nickname :srfi-51))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-51))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-51#internals")
         #|(find-package :srfi-51.internal)|#))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-51)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
