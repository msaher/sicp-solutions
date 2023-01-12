#!/bin/guile -l

(define nil '())

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

;; Directly
(define (square-tree tree)
  (cond ((null? tree) '())
        ((not (pair? tree)) (square tree))
        (else
          (cons (square-tree (car tree))
                (square-tree (cdr tree))))))

;; Using map
(define (square-tree tree)
  (map (lambda (sub-tree)
         (cond ((null? sub-tree) '())
               ((not (pair? sub-tree)) (square sub-tree))
               (else
                 (square-tree sub-tree))))
                 
       tree))

;; testing
(square-tree
  (mathsym 1
        (amssymb 2 (list 3 4) 5)
        (list 6 7 '())))

