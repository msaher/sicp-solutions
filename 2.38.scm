#!/bin/guile -l
!#

(define (fold-left op initial sequence)
  (define (iter result rest)
    (if (null? rest)
        result
        (iter (op result (car rest))
              (cdr rest))))
  (iter initial sequence))

(define (fold-right op initial sequnece) ; aka accumulate
  (if (null? sequnece)
      initial
      (op (car sequnece)
          (accumulate op initial (cdr sequnece)))))


(fold-right / 1 (list 1 2 3))
(/ 1 (/ 2 (/ 3 1))); 3/2

(fold-left / 1 (list 1 2 3))
(/ (/ (/ 1 1) 2) 3); 1/6


(fold-right list nil (list 1 2 3))
(list 1 (list 2 (list 3 '()))) ; (1 (2 (3 ())))

(fold-left list nil (list 1 2 3))
(list (list (list '() 1) 2) 3) ; '(((() 1) 2) 3)

;; for fold-left and fold-right to have the same value. Then op must be
;; associtiave and commutative. 
