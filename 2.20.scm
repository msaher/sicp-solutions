#!/bin/guile -l
!#

(define nil (list))

;; UPDATE: I predicted the filter procedure.
(define (sub-list predicate? x)
  (define (sub-list-iter items result)
    (if (null? items) (reverse result)
        (let ((caritems (car items)))
          (cond 
            ((predicate? caritems)
             (sub-list-iter (cdr items)
                            (cons caritems result)))
            (else
              (sub-list-iter (cdr items) result))))))
  (sub-list-iter x nil))


(define (same-parity x . A)
  (if (even? x) 
      (sub-list even? A)
      (sub-list odd? A)))
