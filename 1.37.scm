#!/bin/guile -l
!#

;;; Recursive
; (define (cont-frac n d k)
;     (if (= k 0) 0
; 	(/ (n k)
; 	   (+ (d k) (cont-frac n d (- k 1))))))

;;; iterative

(define (cont-frac n d k)
  (define (iter n d k result)
    (if (= k 0) result
	(iter n d (- k 1)
	      (/ (n k) (+ (d k) result)))))
  (iter n d k 0))

;;; Test

(cont-frac (lambda (i) 1.0)
	   (lambda (i) 1.0)
	   9)
