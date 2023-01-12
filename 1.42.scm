#!/bin/guil -ll
!#

(define compose
  (lambda (f g)
    (lambda (x) (f (g x)))))
(define inc
  (lambda (x) (+ x 1)))
(define (square x) (* x x))

((compose square inc) 6)
