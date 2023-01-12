#!/bin/guile -l
!#

(define (cont-frac n d k)
  (define (iter n d k result)
    (if (= k 0) result
	(iter n d (- k 1)
	      (/ (n k) (+ (d k) result)))))
  (iter n d k 0))

(define (tan-cf x k) (cont-frac (lambda (i) (if (= i 1) x
						(- (* x x))))
				  (lambda (i) (+ i (- i 1)))
				  k))
