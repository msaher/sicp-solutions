#!/bin/guile -l
!#

(define nil '())
(define square (lambda (x) (* x x)))

(define (map proc items)
  (if (null? items)
      nil
      (cons (proc (car items))
            (map proc (cdr items)))))

(define (tree-map proc tree)
  (map (lambda (sub-tree)
         (cond ((null? sub-tree) '())
               ((not (pair? sub-tree)) (proc sub-tree))
               (else
                 (tree-map proc sub-tree))))))

(define (square-tee trees)
  (tree-map sqaure tree))

(square-tree
  (list 1
        (list 2 (list 3 4) 5)
        (list 6 7 '())))

