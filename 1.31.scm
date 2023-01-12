#!/bin/guile -l
!#

(define (sum term a next b)
  (define (iter a result)
    (if (> a b) result
	(iter (next a) (+ a result))))
    (iter a 0))

;;; iterative
(define (product f a next b)
  (define (iter a result)
    (if (> a b) result
	(iter (next a) (* result (f a)))))
  (iter a 1))

;;; Recursive
; (define (product f a next b)
;   (if (> a b) 1
;       (* (f a) (product f (next a) next b))))

(define (fact b)
  (product (lambda (x) x) 1 (lambda (x) (+ x 1)) b))

(define (pi end)
  (define (sq x) (* x x))
  (define (f n) (/ (* 4 (sq n)) (- (* 4 (sq n)) 1)))
  (* 2.0 (product f 1.0 (lambda (x) (+ x 1)) end)))

