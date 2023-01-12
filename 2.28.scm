#!/bin/guile -l
!#

(define (fringe x)
  (define (iter x result)
    (if (null? x) result
        (let ((carx (car x)))
          (if (pair? carx) (iter (cdr x) (iter carx result))
              (iter (cdr x) (cons (car x) result))))))
  (reverse (iter x '())))

(fringe x)

; (1 2 3 4)

(fringe (list x x)) 

; (1 2 3 4 1 2 3 4)
