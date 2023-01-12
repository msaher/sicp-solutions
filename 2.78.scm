; Exercise 2.78: internal procedures in the scheme-number package are
; essentially nothing more than calls to the primitive procedures +, -, etc.  It
; was not possible to use the primitives of the language directly because our
; type-tag system requires that each data object have a type aached to it.  In
; fact, however, all Lisp implementations do have a type system, which they use
; internally. Primitive predicates such as symbol? and number? determine whether
; data objects have particular types. Modify the deﬁnitions of type-tag
; contents, and attach-tag from Section 2.4.2 so that our generic system takes
; advantage of Scheme’s internal type system. at is to say, the system should
; work as before except that ordinary numbers should be represented simply as
; Scheme numbers rather than as pairs whose car is the symbol scheme-number

; (define (type-tag datum)
;   (if (pair? datum)
;       (car datum)
;       (error "Bad tagged datum: TYPE-TAG" datum)))

; (define (contents datum)
;   (if (pair? datum)
;       (cdr datum)
;       (error "Bad tagged datum: CONTENTS" datum)))

; (define (attach-tag type-tag contents)
;   (cons type-tag contents))

;; too lazy to use cond
(define (type-tag datum)
  (if (pair? datum)
      (car datum)
      (if (number? datum) 'scheme-number
          (error "Bad tagged datum: TYPE-TAG" datum))))

;; too lazy to use cond
(define (contents datum)
  (if (pair? datum)
      (cdr datum)
      (if (number? datum) datum
          (error "Bad tagged datum: CONTENTS" datum))))

;; too lazy to use cond
(define (attach-tag type-tag contents)
  (if (eq? type-tag 'scheme-number) contents
      (cons type-tag contents)))

(define (install-scheme-number-package)

  (define (tag x) (attach-tag 'scheme-number x)) ;; tag ain't gonna do a thing.

  (put 'add '(scheme-number scheme-number)
       (lambda (x y) (tag (+ x y))))

  (put 'sub '(scheme-number scheme-number)
       (lambda (x y) (tag (- x y))))

  (put 'mul '(scheme-number scheme-number)
       (lambda (x y) (tag (* x y))))

  (put 'div '(scheme-number scheme-number)
       (lambda (x y) (tag (/ x y))))

  (put 'make 'scheme-number (lambda (x) (tag x))))
