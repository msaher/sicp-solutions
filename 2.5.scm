#!/bin/guile -l
!#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Exponent procedure
(define (tp b n) 
    (define (even? x) (= 0 (remainder x 2)))
    (define (squared x) (* x x))
    (define (half x) (/ x 2))
    (define (tp-iter base expo result)
      (cond ( (= expo 0) result )
	    ( (even? expo) (tp-iter (squared base) (half expo) result) )
	    (else (tp-iter base (- expo 1) (* result base)))))
    (tp-iter b n 1))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (cons a b)
  (* (tp 2 a) (tp 3 b)))

(define (num-of-times-it-goes-into y x)
  (if (not (= (remainder y x) 0)) 0
      (+ 1 (num-of-times-it-goes-into (/ y x) x))))

(num-of-times-it-goes-into 100 10)

(define (car z)
  (num-of-times-it-goes-into z 2))

(define (cdr z)
  (num-of-times-it-goes-into z 3))

; (define (car-or-cdr num z)
;   (define (iter z result)
;     (if (not (= (remainder z num) 0)) result
; 	(iter (/ z num) (+ result 1))))
;   (iter z 0))

; (define (car z)
;   (car-or-cdr 2 z))

; (define (cdr z)
;   (car-or-cdr 3 z))

;; Above works, but is bad practice. car-or-cdr is a bad name for the
;; function. instead, use something like num-of-times-it-goes-into as a
;; name because it makes it more clear and applicable to other programs.
