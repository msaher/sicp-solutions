#!/bin/guile -l
!#

(define (fixed-point f first-guess)
  (define tolerance 0.00001)
  (define (close-enough? v1 v2)
    (< (abs (- v1 v2))
       tolerance))
  (define (try guess)
    (let ((next (f guess)))
      (cond ( (close-enough? guess next) next )
	    (else (newline) (display next) (try next)))))
  (try first-guess))

(define (log10 x) (/ (log x) (log 10)))

(fixed-point (lambda (x) (/ (log10 1000) (log10 x))) 2)
