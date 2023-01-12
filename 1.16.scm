#!/bin/guile -l
!#

; (define (tp b n) 
;   (define (tp-iter base expo result)
;     (cond ( (= expo 0) result )
; 	  (else (tp-iter base (- expo 1) (* result base)))))
;   (tp-iter b n 1))

(define (tp b n) 
    (define (even? x) (= 0 (remainder x 2)))
    (define (squared x) (* x x))
    (define (half x) (/ x 2))
    (define (tp-iter base expo result)
      (cond ( (= expo 0) result )
	    ( (even? expo) (tp-iter (squared base) (half expo) result) )
	    (else (tp-iter base (- expo 1) (* result base)))))
    (tp-iter b n 1))

