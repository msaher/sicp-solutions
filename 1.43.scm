#!/bin/guile -l
!#

(define (repeated f n)
  (define compose
    (lambda (f g)
      (lambda (x) (f (g x)))))
  (define (iter newf n)
    (if (= n 0) newf
	(iter (compose f newf) (- n 1))))
  (iter (lambda (x) x) n))

((repeated (lambda (x) (* x x)) 2) 5)
