#!/bin/guile -l
!#

; (define (make-rat n d)
;   (let ((g (gcd n d)))
;     (cons (/ n g) (/ d g))))

(define (gcd a b)
  (if (= b 0)
      a
      (gcd b (remainder a b))))

(define (numer x)
  (car x))

(define (denom x)
  (cdr x))

; (define (make-rat n d)
;   (cond ( (= d 0) (error "bad value" d) )
; 	(else
; 	  (let ((g (gcd n d))
; 		(n-positive? (positive? n))
; 		(d-positive? (positive? d)))
; 	    (cond ( (or (and n-positive? d-positive?)
; 			(and (not n-positive?) (not d-positive?)))
; 		   (cons (abs (/ n g)) (abs (/ d g))))
; 		  (else (cons (- (abs (/ n g))) (abs (/ d g)))))))))

; ;;; Using multiplication
; (define (make-rat n d)
;   (cond ( (= d 0) (error "bad value" d) )
; 	(else 
; 	  (let ((g (gcd n d))
; 		(nd (* n d)))
; 	    (cond ( (positive? nd) (cons (abs (/ n g)) (abs (/ d g))) )
; 		  (else (cons (- (abs (/ n g))) (abs (/ d g)))))))))

;;; Elegent solution
(define (make-rat n d)
  (if (= d 0) (error "bad value" d)
      (let ((g (gcd n d))
	    (sign-d (if (positive? d) + -)))
	(cons (sign-d (/ n g)) (abs (/ d g)))))

