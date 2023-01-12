#!/bin/guile -l
!#

(define (for-each procedure items)
  (cond ((null? items) '())
        (else
          (procedure (car items))
          (for-each procedure (cdr items)))))

;; test
(for-each (lambda (x)
            (newline)
            (display x))
          (list 1 2 3))
