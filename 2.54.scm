#!/bin/guile -l
!#

;; clever to use myequal on cdr 
(define (equal? a b)
  (cond ((eq? a b) true)
        ((or (null? a) (null? b)) false)
        ((and 
           (equal? (cdr a) (cdr b))
           (equal? (car a) (car b))) true)
        (else false)))

;; better solution:
(define (equal? a b)
  (or
    (eq? a b)
    (and
      (pair? a) ; use pair instead of list, because nil is not pair, but a list
      (pair? b)
      (equal? (car a) (car b))
      (equal? (cdr a) (cdr b)))))



;; testing
(equal? 'a 'a)
;; t

(equal? '(this is a list) '(this is a list))
;; t

(equal? '(this is a list) '(this (is a) list))
;; f

(equal? '(1 2 3) '(1 2 3))


(equal? '(this is a list) '(this (is a) list))

