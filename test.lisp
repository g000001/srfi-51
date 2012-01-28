(cl:in-package :srfi-51.internal)

(def-suite srfi-51)

(in-suite srfi-51)

(defmacro => (&body body)
  (cl:loop
     :for (test => . results) :in body
     :collect `(is (equal? (cl:multiple-value-list ,test) ',results)) :into tests
     :finally (cl:return
                `(begin
                   ,@tests))))

(cl:defvar rest-list '(x 1))
(cl:defvar caller #'values)


(test rest-values
  (=>
    ((rest-values rest-list)	         => x 1)
    ((rest-values rest-list 2)	         => x 1)
    ((rest-values caller rest-list)        => x 1)
    ((rest-values caller rest-list -3)     => x 1))
  ;; Error: too many defaults (Y 3 1) DEFAULT-LIST (<= (LENGTH DEFAULT-LIST) 2)
  (signals (cl:error)
    (rest-values rest-list -2 'y 3 1))
  ;; Error: too many arguments (X 1) REST-LIST (<= (LENGTH REST-LIST) 1) CALLER
  (signals (cl:error)
    (rest-values 'caller rest-list 1 '(x y z)))
  (signals (cl:error)
    (rest-values caller rest-list 2 (list 'x 'y 'z) (cons "str" #'string?)))
  (signals (cl:error)
    (rest-values rest-list 2 '(y z) `(100 . ,#'number?)))
  (signals (cl:error)
    (rest-values "caller: bad argument" rest-list 2 '(y z) `(100 . ,#'number?)))
  (signals (cl:error)
    (rest-values 'caller rest-list (list 'x 'y) (cons 1 #'number?)))
  (=>
    ((rest-values rest-list :- 'y 100 "str")
     => x 1 "str")
    ((rest-values rest-list :+ `(x y z) `(100 . ,#'number?) `("str" . ,#'string?))
     => x 1 "str")
    ((rest-values rest-list T `(x y z) `(100 . ,#'number?) `("str" . ,#'string?))
     => x 1 "str")
    ((rest-values rest-list T `(100 . ,#'number?) `("str" . ,#'string?) `(x y z))
     => 1 "str" x ))
  (signals (cl:error)
    (rest-values rest-list T `(100 . ,#'number?) `("str" . ,#'string?) `(y z)))
  (=>
    ((rest-values rest-list nil `(100 . ,#'number?) `("str" . ,#'string?) `(y z))
     => 1 "str" y x))
  )


(cl:defvar recaller #'values )
(cl:defvar *str* "string")
(cl:defvar *num* 2)

(test arg-and-etc
  (signals (cl:error)
    (arg-and *num* (number? *num*) (< *num* 2)) )
  (signals (cl:error)
    (arg-and caller *num* (number? *num*) (< *num* 2)) )
  (signals (cl:error)
    (arg-and 'caller *num* (number? *num*) (< *num* 2)) )
  (signals (cl:error)
    (arg-and "caller: bad argument" *num* (number? *num*) (< *num* 2)) )
  (signals (cl:error)
    (arg-ands (*str* (string? *str*) (< (string-length *str*) 7))
              ("caller: bad argument" *num* (number? *num*) (< *num* 2)) ))
  (signals (cl:error)
    (arg-ands (*str* (string? *str*) (< (string-length *str*) 7))
              ("caller: bad argument" *num* (number? *num*) (< *num* 2)) ))
  (signals (cl:error)
    (arg-ands ("caller: bad argument" *str* (string? *str*) (< (string-length *str*) 7))
              (*num* (number? *num*) (< *num* 2)) ))
  (signals (cl:error)
    (arg-ands common 'caller
              (*str* (string? *str*) (< (string-length *str*) 7))
              (*num* (number? *num*) (< *num* 2)) ))
  (signals (cl:error)
    (arg-ands common "caller: bad argument"
              (*str* (string? *str*) (< (string-length *str*) 7))
              ("caller: incorrect argument" *num* (number? *num*) (< *num* 2)) ))
  (signals (cl:error)
    (err-and 'caller
             (string? *str*) (< (string-length *str*) 7) (number? *num*) (< *num* 2)))
  (signals (cl:error)
    (err-ands (caller (string? *str*) (< (string-length *str*) 7))
              ("*num* failed test in caller" (number? *num*) (< *num* 2)) )))

;;; eof
