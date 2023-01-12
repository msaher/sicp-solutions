#!/bin/guile -l
!#

(define dx 0.00001)

(define (repeated f n)
  (define compose
    (lambda (f g)
      (lambda (x) (f (g x)))))
  (define (iter newf n)
    (if (= n 0) newf
	(iter (compose f newf) (- n 1))))
  (iter (lambda (x) x) n))

(define smooth
  (lambda (f)
    (lambda (x) (/ (+ (f x) (f (+ x dx)) (f (- x dx))) 3))))

(define (repeated-smooth f n)
  (repeated (smooth f) n))
