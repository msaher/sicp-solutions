#!/bin/guile -l
!#

(define nil '())

(define (accumulate op initial sequnece)
  (if (null? sequnece)
      initial
      (op (car sequnece)
          (accumulate op initial (cdr sequnece)))))

(define (map p sequnece)
  (accumulate (lambda (x y) (cons (p x) y))
                 nil sequnece))

;; testing
(map (lambda (x) (+ 10 x)) (list 1 2 3))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

;; testing
(append (list 1 2 3) (list 4 5 6))

(define (length sequnece)
  (accumulate (lambda (x y) (+ 1 y)) 0 sequnece))

;; testing
(length (list 1 2 3))
