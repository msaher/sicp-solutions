#!/bin/guil -l
!#

(define (reverse x)
  (define (iter x result)
    (if (null? x) result
        (iter (cdr x) (cons (car x) result))))
  (iter x '()))

(define (deep-reverse x)
  (define (iter L result)
      (if (null? L) result
          (let ((carL (car L)))
            (iter (cdr L)
                  (cons (if (pair? carL)
                              (deep-reverse carL)
                              carL)
                          result)))))
  (iter x '()))

;; recursive
(define (deep-reverse x)
  (if (null? x) x
      (let ((carx (car x)))
        (reverse (cons (if (pair? carx)
                           (deep-reverse carx)
                           carx) 
                       (deep-reverse (cdr x)))))))

;; elegent solution
(define (deep-reverse x)
  (reverse (map (lambda (k)
         (if (pair? k)
             (deep-reverse k)
             k))
       x)))

;; testing.
(define x (list (list 1 2) (list 3 4)))
(reverse x)
(deep-reverse x)
