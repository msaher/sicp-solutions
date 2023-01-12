#!/bin/guile -l
!#

(define (last-pair list)
  (let ((smallerlist (cdr list)))
    (if (null? (cdr smallerlist)) smallerlist
        (last-pair smallerlist))))
