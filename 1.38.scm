#!/bin/guile -l
!#

(define (cont-frac n d k)
  (define (iter n d k result)
    (if (= k 0) result
	(iter n d (- k 1)
	      (/ (n k) (+ (d k) result)))))
  (iter n d k 0))

;;; e

(+ 2 (cont-frac (lambda (x) 1.0)
	   (lambda (x) (if (= (remainder x 3) 2) (* 2 (+ 1 (/ (- x 2) 3))) 1.0))
	   512.0))
