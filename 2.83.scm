#!/bin/guile -l
!#

(define (rise x)
  (apply-generic 'rise x))

;; in the rational package
(define (scheme->rational num)
  (make-rational num 1))

(put 'rise 'scheme scheme->rational)
;; in the real package?
(define (rational->real rat)
  (/ (numer rat)
     (denom rar)))

(put 'rise 'rational rational->real) 
;; in the complex package
(define (real->cmplx r)
  (make-from-real-img r 0))

(put 'rise 'real real->cmplx)
