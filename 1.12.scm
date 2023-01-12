#!/bin/guile -l
!#

;; Recursive tree procedure. Assumes that you're not stupid and use good input. 

(define (pas row col)
  (if (or (= row 1) (= col 1) (= col (+ row 1))) 1
     (+ (pas (- row 1) col) (pas (- row 1) (- col 1)))))
