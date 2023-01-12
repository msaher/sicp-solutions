#!/bin/guile -l
!#

(define (filtered-accumulate combiner null-value term a next b predicate)
  (define (iter a result)
    (cond ( (> a b) result )
	  ( (predicate a) (iter (next a) (combiner a result)))
	  (else (iter (next a) result))))
  (iter a null-value))

;;; For testing purposes
; (define (even-sum a b)
;   (filtered-accumulate + 0 (lambda (x) x) a (lambda (x) (+ x 1)) b even?))



(define (prime? n)
  (define (square x) (* x x))
  (define (smallest-divisor n)
    (define (iter n test-divisor)
      (cond ( (> (square test-divisor) n) n )
	    ( (= (remainder n test-divisor) 0) test-divisor )
	    (else (iter n (+ test-divisor 1)))))
    (iter n 2))
  (and (not (= (smallest-divisor n) 1)) (= (smallest-divisor n) n)))

(define (sum-sq-primes a b)
  (filtered-accumulate + 0 (lambda (x) (* x x)) a (lambda (x) (+ x 1)) b prime?))

(define (product-co-prime-n n)
  (define (co-prime? i n)
    (define (gcd a b)
      (if (= b 0) a
	  (gcd b (remainder a b))))
    (= (gcd i n) 1))
  ; (define (co-prime-with-n? x) (co-prime? x n )) ; no need use lambda expression
  (filtered-accumulate * 1 (lambda (x) x) 1 (lambda (x) (+ x 1)) n (lambda (x) (co-prime? x n ))))

(product-co-prime-n 10)

