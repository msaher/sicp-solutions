#!/bin/guile -l

(define (make-interval a b) (cons a b))

(define (lower-bound x)
  (car x))

(define (upper-bound x)
  (cdr x))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

(define (neg-interval x)
  (make-interval (- (lower-bound x) ) (- (upper-bound x)))
  )

(define (sub-interval x y)
  (add-interval x (neg-interval y)))
