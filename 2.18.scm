#!/bin/guile -l
!#

;; iterative
(define (reverse x)
  (define (iter y result)
    (let ((nil (list)))
      (if (null? y) result
          (iter (cdr y) (append (cons (car y) nil) result)))))
      (iter x (list)))

;; recursive
; (define (reverse x)
;   (let ((nil (list)))
;     (if (null? (cdr x)) x
;         (append (reverse (cdr x))
;                 (cons (car x) (list))))))
