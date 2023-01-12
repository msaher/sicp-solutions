#!/bin/guile -l
!#

; Exercise 2.44: Deﬁne the procedure up-split used by corner- split . It is
; similar to right-split , except that it switches the roles of below and beside

(define (up-split p n)
  (let ((smaller (up-split (- n 1))))
    (if (= n 0)
        p
        (below p (beside smaller smaller)))
