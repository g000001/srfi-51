;;;; package.lisp

(cl:in-package :cl-user)

(cl:defpackage :srfi-51
  (:use)
  (:export :rest-values
           :arg-and
           :arg-ands
           :err-and
           :err-ands
           :arg-or
           :arg-ors
           :err-or
           :err-ors ))

(cl:defpackage :srfi-51.internal
  (:use :srfi-51 :fiveam :srfi-1 :srfi-23 :srfi-5 :mbe)
  (:shadowing-import-from :cl
                          :defun
                          :defmacro
                          :cond
                          :every
                          :reverse
                          :cons
                          :funcall
                          :setq
                          :setf
                          :not
                          :and
                          :abs
                          :+
                          :-
                          :<
                          :>
                          :<=
                          :>=
                          :=
                          :append
                          :fdefinition
                          :eval-when
                          :progn
                          :declaim
                          :values
                          :list
                          :if
                          :car
                          :cdr
                          :inline
                          :let*
                          :or
                          :&rest :&optional :&aux :&body
                          :t
                          :nil
                          :length
                          :apply
                          :*** ))
