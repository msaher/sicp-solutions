#!/bin/guile -l 
!#

;; List the term, and find the order
(define (first-term term-list)
  (list 
    (car term-list) ; first term
    (- 1 (length term-list)))) ; order is length-1 (we index polynomials from 0)

;; Slightly modified to cons the coeff instead of the actual term
(define (adjoin-term term term-list)
  (let ((coeff-of-term (coeff term)))
    (if (=zero? coeff-of-term)
      term-list
      (cons coeff-of-term term-list))))

;; Thanks to abstraction, we don't have to change anything else.
