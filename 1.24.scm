#lang racket

(define (fermat-test n)
  (define (try-it a)
    (= (expmod a n n) a))
  (try-it (+ 1 (random (- n 1)))))

(define (expmod base exp m)
  (cond ((= exp 0) 1)
        ((even? exp)
         (remainder
           (square (expmod base (/ exp 2) m))
           m))
        (else
          (remainder
            (* base (expmod base (- exp 1) m))
            m))))

(define (fast-prime? n times)
(cond ((= times 0) true)
((fermat-test n) (fast-prime? n (- times 1)))
(else false)))

(define (square x) (* x x))

(define (find-divisor n test-divisor)
  (cond ((> (square test-divisor) n) n)
        ((divides? test-divisor n) test-divisor)
        (else (find-divisor n (+ test-divisor 1)))))
(define (divides? a b) (= (remainder b a) 0))

(define (smallest-divisor n) (find-divisor n 2))

(define (prime? n)
(= n (smallest-divisor n)))

(define runtime current-inexact-milliseconds) 

;;; 

(define (timed-prime-test n)
  (newline)
  (display n)
  (start-prime-test n (runtime)))

(define (start-prime-test n start-time)
  (if (fast-prime? n 20)
    (report-prime (- (runtime) start-time)) null))

(define (report-prime elapsed-time)
  (display " *** ")
  (display elapsed-time))

(define (search-for-primes a b)
  (define (iter a b)
  (when (< a b)
    (timed-prime-test a)
    (search-for-primes (+ a 2) b)))
  (iter (if (even? a) (+ a 1) a) b))

; (search-for-primes 1000 1500)

; 1001
; 1003
; 1005
; 1007
; 1009 *** 0.0
; 1011
; 1013 *** 0.0
; 1015
; 1017
; 1019 *** 0.0
; .
; .
; .
;; Again, Computers are fast


; (search-for-primes 100000000 100000100)
;; results
; 100000007 *** 0.06005859375
; 100000037 *** 0.015869140625
; 100000039 *** 0.015869140625
; 100000049 *** 0.01611328125
; 100000073 *** 0.01513671875
; 100000081 *** 0.01513671875

;; original results
; 100000007 *** 0.079833984375
; 100000037 *** 0.053955078125
; 100000039 *** 0.05419921875
; 100000049 *** 0.053955078125
; 100000073 *** 0.053955078125
; 100000081 *** 0.054931640625

;; racket does not support really large random numbers :(
;; In anycase, it's clear that the fast-prime procedure is
;; logarithmic
