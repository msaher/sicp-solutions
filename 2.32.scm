#!/bin/guile -l
!#

(define nil '())

(define (subsets s)
  (if (null? s)
      (list nil)
      (let ((rest (subsets (cdr s))))
        (append rest (map (lambda (element)
                            (cons (car s) element))
                          rest)))))

;; testing.
(subsets (list 1 2 3))

;; Why it works?
;; The power set of some set {1} ∪ A. Is P(A) ∪ with P(A), but each
;; elemet in P(A) has {1} appended to it. 
