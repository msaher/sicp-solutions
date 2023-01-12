#!/bin/guile -l
!#

(define (reverse sequence)
  (fold-right (lambda (x y)
                (append y (list x))) nil sequence))

(reverse (list 1 2 3))
(reverse (list 1 2 (list 60 20)))


(define (reverse sequence)
  (fold-left (lambda (x y)
               (cons y x)) nil sequence))
