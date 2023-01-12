#!/bin/guile -l
!#

;; See 1.19-proof.tex for derivation, It's a bit tedious 

(define (fib n)
  (fib-iter 1 0 0 1 n))
(define (fib-iter a b p q count)
  (cond ((= count 0) b)
	((even? count)
	 (fib-iter a
		   b
		   (+ (* p p) (* q q))   ; compute p′
		   (+ (* 2 p q) (* q q)) ; compute q′
		   (/ count 2)))
	(else (fib-iter (+ (* b q) (* a q) (* a p))
			(+ (* b p) (* a q))
			p
			q
			(- count 1)))))

;; I find it rather intersting that a seemingly difficult optimization problem
;; could become trivial by the introduction of seeminlgy arbirtary and abstract
;; transformations. 
