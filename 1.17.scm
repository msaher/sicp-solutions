#!/bin/guile -l
!#


(define (times a b)
  (if (= b 0) 0
      (+ a (times a (- b 1)))))

(define (times a b)
  (define (double x) (+ x x))
  (define (even? x) (= 0 (remainder x 2)))
  (define (half x) (/ x 2))
  (cond ((= b 0) 0)
	((even? b) (+ (double a) (times (double a) (- (half b) 1))))
	(else (+ a (times a (- b 1))))))

