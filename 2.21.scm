#!/bin/guile -l
!#

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))


(define square (lambda (x) (* x x)))

(define (square-list items)
  (if (null? items)
      '()
      (cons (square (car items)) (square-list (cdr items)))))

(define (sqaure-list items)
  (map (lambda (x) (* x x) items)))
