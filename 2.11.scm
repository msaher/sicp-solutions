#!/bin/guile -l
!#

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


;;; type1 ++
;;; type2 --
;;; type3 -+

(define (mul2-interval x y)
  (define (interval-type x)
    (cond ( (>= (lower-bound x) 0) 1 )
	  ( (<= (upper-bound x) 0) 2 )
	  (else 3)))
  (let ((lx (lower-bound x))
	(ux (upper-bound x))
	(ly (lower-bound y))
	(uy (upper-bound y))
	(typex (interval-type x))
	(typey (interval-type y)))
    (cond ( (= typex 1) 
	   (cond ((= typey 1) 
		  (make-interval (* lx ly) (* ux uy)))
		 ((= typey 2) 
		  (make-interval (* ux ly) (* lx uy)))
		 ((= typey 3) 
		  (make-interval (* ux ly) (* ux uy)))))
	  ((= typex 2)
	   (cond ((= typey 1) 
		  (make-interval (* lx uy) (* ux ly)))
                 ((= typey 2) 
		  (make-interval (* ux uy) (* lx ly)))
	         ((= typey 3) 
		  (make-interval (* lx uy) (* lx ly)))))
	  ((= typex 3)
	   (cond ((= typey 1) 
		  (make-interval (* lx uy) (* ux uy)))
                 ((= typey 2) 
		  (make-interval (* ux ly) (* lx ly)) )
                 ((= typey 3) 
		  (let ((lxux (* lx ux))
			(uxly (* ux ly))
			(lxly (* lx ly))
			(uxuy (* ux uy)))
		    (make-interval (if (< lxux uxly) lxux uxly)
				   (if (> lxly uxuy) lxly uxuy)))))))))





;; Tests

; (mul-interval  (cons 0 3) (cons 3 5))
; (mul2-interval  (cons 0 3) (cons 3 5))

; (mul-interval  (cons 0 3) (cons -4 0))
; (mul2-interval  (cons 0 3) (cons -4 0))

; (mul-interval  (cons 0 3) (cons -3 6))
; (mul2-interval  (cons 0 3) (cons -3 6))

; (mul-interval  (cons -5 -2) (cons 3 6))
; (mul2-interval  (cons -5 -2) (cons 3 6))

; (mul-interval  (cons -5 -2) (cons -5 -2))
; (mul2-interval  (cons -5 -2) (cons -5 -2))

; (mul-interval  (cons -5 -2) (cons -10 11))
; (mul2-interval  (cons -5 -2) (cons -10 11))


; (mul-interval  (cons -3 6) (cons 2 4))
; (mul2-interval  (cons -3 6) (cons 2 4))

; (mul-interval  (cons -3 6) (cons -3 -2))
; (mul2-interval  (cons -3 6) (cons -3 -2))

; (mul-interval  (cons -3 6) (cons -8 7))
; (mul2-interval  (cons -3 6) (cons -8 7))
