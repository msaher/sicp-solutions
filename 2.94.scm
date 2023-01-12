#!/bin/guile -l
!#

;; returns a list with car as the result, cadr as the reamainder
(define (div-terms L1 L2)
  (if (empty-termlist? L1)
    (list (the-empty-termlist) (the-empty-termlist))
    (let ((t1 (first-term L1))
          (t2 (first-term L2)))
      (if (> (order t2) (order t1))
        (list (the-empty-termlist) L1)
        (let ((new-c (div (coeff t1) (coeff t2)))
              (new-o (- (order t1) (order t2))))
          (let ((rest-of-result
                  (div-terms L1
                             (sub-terms L2  (mul-term-by-all-terms
                                              (make-term new-c new-o) L1)))))
            (list (adjoin-term (make-term new-c new-o)
                         (car rest-of-result)) (cadr rest-of-result))))))))

(define (div-poly p1 p2)
  (let (var1 (variable p1))
    (if (same-variable var1 (variable p2))
      (let ((result (div-term (term-list p1) (term-list p2))))
        (let ((quotient (car result))
              (remainder (cadr result)))
          (list
            (make-poly var1 quotient)
            (make-poly var1 remainder)))))))

(define (remainder-terms L1 L2)
  (cadr (div-terms L1 L2)))

(define (gcd-terms L1 L2)
  (if (empter-termlist? L2)
    L1
    (gcd-terms L2 (remainder-terms L1 L2))))

(define (gcd-poly p1 p2)
  (if (same-varible? p1 p2)
    (make-poly (variable p1)
               (gcd-terms (term-list p1)
                          (term-list p2))))
  (error "Polynomials not in same varialbe"
         (list (variable p1) (variable p2))))

(put 'gcd '(polynomial polynomial) 
     (lambda (x y) (tag (gcd-poly x y))))

(put 'gcd '(scheme-number scheme-number) gcd)

(define (gcd a b)
  (apply-generic 'gcd a b))
