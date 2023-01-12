#!/bin/guile -l
!#

(define (add a b)
  (define (even? x) (= 0 (remainder x 2)))
  (define (double x) (+ x x))
  (define (half x) (/ x 2))
  (define (add-iter a b result)
    (cond ( (= b 0) result )
	  ( (even? b) (add-iter (double a) (half b) result))
	  (else (add-iter a (- b 1) (+ result a)))))
  (add-iter a b 0))

