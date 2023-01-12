#!/bin/guile -l
!#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (point-distance p1 p2)
  (let ((dx (- (x-point p1) (x-point p2)))
	(dy (- (y-point p1) (y-point p2))))
    (sqrt (+ (* dx dx)
	     (* dy dy)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; c4----------c3
;; |           |
;; |           |
;; |           |
;; |           |
;; c1----------c2

(define (make-rec c1 c3)
  (let ((c2 (make-point (x-point c3) (y-point c1)))
	(c4 (make-point (x-point c1) (y-point c3))))
    (cons (cons c1 c2) (cons c3 c4))))

(define (rec-point num rec)
  (cond ((= num 1) (car (car rec)))
	((= num 2) (cdr (car rec)))
	((= num 3) (car (cdr rec)))
	((= num 4) (cdr (cdr rec)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; Different implementation: Don't store all the 4 points at once.
;;; Instead derive those that are needed on the spot.

(define (make-rec p1 p3)
  (cons p1 p3))

(define (rec-point num rec)
  (let ((p1 (car rec))
	(p3 (cdr rec)))
    (cond ((= num 1) p1)
	  ((= num 2) (make-point (x-point p3) (y-point p1)))
	  ((= num 3) p3)
	  ((= num 4) (make-point (x-point p1) (y-point p3))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (rec-area rec)
  (* (point-distance (rec-point 1 rec) (rec-point 2 rec))
     (point-distance (rec-point 2 rec) (rec-point 3 rec))))

(define (rec-per rec)
  (let ((p1 (rec-point 1 rec)))
	(let (
	  (w (point-distance p1 (rec-point 2 rec)))
	  (h (point-distance p1 (rec-point 4 rec))))
	(* 2 (+ h w)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; New implementation with new feature: angles.

(define (make-rec initial-point h w angle)
  (cons (cons initial-point angle) (cons h w)))

(define pi 3.1415)

(define (rec-angle rec)
  (cdr (car rec)))

(define (rec-point point rec)
  (define h (car (cdr rec)))
  (define w (cdr (cdr rec)))
  (define initial-point (car (car rec)))
  (define (iter counter theta result)
    (define term (if (even? counter) h w))
    (if (= counter point) result
	(iter (+ 1 counter) (+ (/ pi 2) theta) (make-point (+ (x-point result)
							      (* term (cos theta)))
							   (+ (y-point result)
							      (* term (sin theta)))))))
  (iter 1 (rec-angle rec) initial-point))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (rec-area rec)
  (* (point-distance (rec-point 1 rec) (rec-point 2 rec))
     (point-distance (rec-point 2 rec) (rec-point 3 rec))))

(define (rec-per rec)
  (let ((p1 (rec-point 1 rec)))
    (let (
	  (w (point-distance p1 (rec-point 2 rec)))
	  (h (point-distance p1 (rec-point 4 rec))))
      (* 2 (+ h w)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; The three implementations work.
(define p1 (make-point 0 0 ))
(define p2 (make-point 3 5))
(define myrec (make-rec p1 p2))
(rec-area myrec)
(rec-per myrec)

