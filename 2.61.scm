#!/bin/guile -l

;; solutions
(define (adjoin-set x set)
  (cond ((null? set) (cons x set))
        ((= x (car set)) set)
        ((< x (car set)) (cons x set))
        (else ;; same as (> x (car set))
          (cons (car set) (adjoin-set x (cdr set))))))
