#!/bin/guile -l

(define (make-interval a b) (cons a b))

(define (lower-bound x)
  (car x))

(define (upper-bound x)
  (cdr x))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

(define (int-recp x)
  (let ((l (lower-bound x))
	(h (upper-bound x)))
    (if (or (= l 0) (= h 0)) (error "can't divide by zero" l h)
	(make-interval (/ 1 l) (/ 1 h)))))

(define (div-interval x y)
  (mul-interval x (int-recp y)))
