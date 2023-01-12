#!/bin/guil -l
!#

(define (make-accumulator initial-value)
  (define (add extra)
    (set! initial-value (+ initial-value extra))
    initial-value)
  add)

;; using lambadas
; (define (make-accumulator initial-value)
;   (lambda (new)
;     (set! initial-value (+ initial-value extra))
;     initial-value)

(define A (make-accumulator 5))

;; adds 10
(A 10)

;; adds another 10
(A 10)
