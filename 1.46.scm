#!/bin/guile -l
!#

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? a b)
    (< (abs (- a b)) tolerance))
  (define (try guess)
    (let ( (next (f guess)) )
      (cond ( (close-enough? guess next) (newline) next )
	    (else (newline) (display guess) (try next)))))
  (try first-guess))

(define (repeated f n)
  (define compose
    (lambda (f g)
      (lambda (x) (f (g x)))))
  (define (iter newf n)
    (if (= n 0) newf
	(iter (compose f newf) (- n 1))))
  (iter (lambda (x) x) n))

(define average-damp
  (lambda (f)
    (lambda (x) (/ (+ (f x) x) 2))))

(define (tp b n) 
    (define (even? x) (= 0 (remainder x 2)))
    (define (squared x) (* x x))
    (define (half x) (/ x 2))
    (define (tp-iter base expo result)
      (cond ( (= expo 0) result )
	    ( (even? expo) (tp-iter (squared base) (half expo) result) )
	    (else (tp-iter base (- expo 1) (* result base)))))
    (tp-iter b n 1))

(define (tp b n) 
  (define (even? x) (= 0 (remainder x 2)))
  (define (squared x) (* x x))
  (define (half x) (/ x 2))
  (define (tp-iter base expo result)
    (cond ( (= expo 0) result )
	  ( (even? expo) (tp-iter (squared base) (half expo) result) )
	  (else (tp-iter base (- expo 1) (* result base)))))
  (tp-iter b n 1))

(define (rootnk x n k)
  (fixed-point ((repeated average-damp k) (lambda (y) (/ x (tp y (- n 1))))) 1.0))

;;; There's a difference between (repeated (average-damp f) k) and ((repeated average-damp k) f) see
;;; https://stackoverflow.com/questions/53925944/sicp-1-45-why-are-these-two-higher-order-functions-not-equivalent
 

; n = 2  ; k = 1
; n = 3  ; k = 1
; n = 4  ; k = 2
; n = 5  ; k = 2
; n = 6  ; k = 2
; n = 7  ; k = 2
; n = 8  ; k = 3
; n = 9  ; k = 3
; n = 10 ; k = 3
; n = 11 ; k = 3
; n = 12 ; k = 3
; n = 13 ; k = 3
; n = 14 ; k = 3
; n = 15 ; k = 3
; n = 15 ; k = 3
; n = 16 ; k = 4
; .
; .
; .
; n = 64 ; k = 6 but it seems that k = 1 works too and is more accurate
; n = 128 ; k = 6 but it seems that k = 1 works too and is more accurate

;; k = floor(log2 (n))

(define (rootn x n)
  (fixed-point ((repeated average-damp (floor (/ (log n) (log 2)))) (lambda (y) (/ x (tp y (- n 1))))) 1.0))
