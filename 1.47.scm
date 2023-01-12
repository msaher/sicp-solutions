#!/bin/guile -l
!#

(define (iterative-improve good-enuf-func? improve-func)
  (lambda (guess)
    (cond ( (good-enuf-func? guess) guess )
	  (else 
	    ((iterative-improve good-enuf-func? improve-func) (improve-func guess))))))

;;; Part A

(define (root2 x)
  ((iterative-improve (lambda (y)
			(< (abs (- (* y y) x)) 0.00001))
		      (lambda (y)
			(/ (+ (/ x y) y) 2)))
   1.0))

;;; Part B
(define (fixed-point f)
  ((iterative-improve
     (lambda (x) (< (abs (- x (f x))) 0.00001))
     (lambda (x) (f x)))
   1.0))
