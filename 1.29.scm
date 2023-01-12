#!/bin/guile -l
!#

(define (sum term a next b)
  (if (> a b) 0
      (+ (term a)
	 (sum term (next a) next b))))

(define (sum-int a b)
  (sum (lambda (x) x) a (lambda (x) (+ x 1)) b ))

(define (cube x) (* x x x))

(define (simp f a b n)
  (define h (/ (- b a) n))
  (define (new-f x) (f (+ a (* x h))))
  (* (/ h 3)
     (+ (new-f 0) (new-f n) 
	(* 2 (sum new-f  2 (lambda (x) (+ x 2)) (- n 2)))
	(* 4 (sum new-f  1 (lambda (x) (+ x 2)) (- n 1))))))
