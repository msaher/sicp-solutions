#!/bin/guile -l
!#

(define (last-pair list)
  (let ((list-1 (cdr list)))
    (if (null? list-1) list
        (last-pair list-1))))
