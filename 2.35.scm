#!/bin/guile -l
!#

(define (accumulate op initial sequnece)
  (if (null? sequnece)
      initial
      (op (car sequnece)
          (accumulate op initial (cdr sequnece)))))

(define (count-leaves x)
  (cond ((null? x) 0)
        ((not (pair? x)) 1)
        (else (+ (count-leaves (car x))
                 (count-leaves (cdr x))))))

(define (enumerate-tree tree)
  (cond ((null? tree) nil)
        ((not (pair? tree)) (list tree))
        (else (append (enumerate-tree (car tree))
                      (enumerate-tree (cdr tree))))))

(define (count-leaves t)
  (accumulate (lambda (first acu-rest)
                (cond ((not (pair? first)) (+ 1 acu-rest))
                      (else
                        (+ 
                          (count-leaves first)
                          acu-rest))))
                 0 (map (lambda (x) x) t)))


; (define (count-leaves t) 
;   (accumulate +  0 (map (lambda(x) 1)  (enumerate-tree t)))) 


;; testing
(count-leaves (list 1 2 (list 3 4)))
