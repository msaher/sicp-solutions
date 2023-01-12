#!/bin/guile -l
!#

;; adjoin-term makes sure we don't have end up with zero coefficients, so we can
;; just do

(define (=zero-polynomial? poly)
  (the-empty-term-list? (term-list poly)))

;; If we didn't have a smart adjoin-term, we we'll have to make sure the output
;; of (filter =zero? (map coeff poly)) is not null
