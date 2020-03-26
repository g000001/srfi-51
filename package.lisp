;;;; package.lisp

(cl:in-package :cl-user)


(cl:defpackage "https://github.com/g000001/srfi-51"
  (:use)
  (:export 
   rest-values
   arg-and
   arg-ands
   err-and
   err-ands
   arg-or
   arg-ors
   err-or
   err-ors ))


(cl:defpackage "https://github.com/g000001/srfi-51#internals"
  (:use 
   "https://github.com/g000001/srfi-51"
   "https://github.com/g000001/srfi-1"
   "https://github.com/g000001/srfi-23"
   "https://github.com/g000001/srfi-5"
   fiveam
   mbe) 
  (:shadowing-import-from cl
   defun defmacro cond every reverse cons funcall setq setf not and
   abs + - < > <= >= = append fdefinition eval-when progn declaim values
   list if car cdr inline let* or &rest &optional &aux &body t nil length
   apply *** ))


;;; *EOF*
