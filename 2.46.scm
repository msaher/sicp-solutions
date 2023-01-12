#!/bin/guile -l
!#

(define make-vect cons)

(define xcor-vect car)
(define ycor-vect cdr)

;; nah
; (define (add-vect v u)
;   (make-vect
;     (+ (xcor-vect v)
;        (xcor-vect u))
;     (+ (ycor-vect v)
;        (ycor-vect u))))

(define (art-vect op)
  (lambda (v u)
    (make-vect
    (op (xcor-vect v)
       (xcor-vect u))
    (op (ycor-vect v)
       (ycor-vect u)))))

(define add-vect (art-vect +))  
(define sub-vect (art-vect -))  

(define (scale-vect k v)
  (make-vect
    (* k (xcor-vect v))
    (* k (ycor-vect v))
    ))
