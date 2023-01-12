#!/bin/guile -l
!#

(define dx 0.00001)
(define sqaure (lambda (x) (* x x)))
(define deriv
  (lambda (f)
    (lambda (x) (/ (- (f (+ x dx)) (f x)) dx))))

(define (fixed-point f first-guess)
(define tolerance 0.00001)
(define (close-enough? a b)
  (< (abs (- a b)) tolerance))
(define (try guess)
  (let ( (next (f guess)) )
    (if (close-enough? guess next)
	next
	(try next))))
(try first-guess))

(define (newton-method g guess)
  (define newton-transform
    (lambda (g) (lambda (x) (- x (/ (g x) ((deriv g) x))))))
  (fixed-point (newton-transform g) guess))

;; Solution
(define (cubic a b c)
  (lambda (x) (+ (* x x x) (* a x x) (* b x) c)))

;;; Test
(newton-method (cubic 1 1 1) 1)
