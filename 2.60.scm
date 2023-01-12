#!/bin/guile -l
!#

(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else
          (element-of-set? x (cdr set)))))

;; So much faster than the one in 2.59
(define (adjoin-set x set)
  (cons x set))

;; oh no, we used the slow element-of-set? with the representatons that has
;; duplicates
(define (intersection-set set1 set2)
  (cond ((or (null? set1) (null? set2)) '())
        ((element-of-set? (car set1) set2) 
         (cons (car set1) (intersection-set (cdr set1) set2)))
        (else (intersection-set (cdr set1) set2))))

;; much faster!
(define (union-set set1 set2)
  (append set1 set2))
