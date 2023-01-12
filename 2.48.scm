#!/bin/guile -l
!#

;; vectors
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
    (* k (ycor-vect v))))

;;; Frames from 2.47 A
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
 
(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

;; segments
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)

