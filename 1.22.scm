#lang racket


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
  (if (prime? n) ;; change it to when
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
;; Seriously? Computers are too fast nowadays


; (search-for-primes 100000000 100000100)
; 100000007 *** 0.079833984375
; 100000037 *** 0.053955078125
; 100000039 *** 0.05419921875
; 100000049 *** 0.053955078125
; 100000073 *** 0.053955078125
; 100000081 *** 0.054931640625


;(search-for-primes 1000000000000 1000000001000)
; 1000000000039 *** 6.278076171875
; 1000000000061 *** 6.26611328125
; 1000000000063 *** 6.26806640625
; 1000000000091 *** 6.26611328125
; 1000000000121 *** 6.268798828125
; 1000000000163 *** 6.266845703125
; 1000000000169 *** 6.267822265625
; 1000000000177 *** 6.264892578125
; 1000000000189 *** 6.266845703125
; 1000000000193 *** 6.264892578125
; 1000000000211 *** 6.266845703125
; 1000000000271 *** 6.265869140625
; 1000000000303 *** 6.263916015625
; 1000000000331 *** 6.27783203125
; 1000000000333 *** 6.267822265625
; 1000000000339 *** 6.266845703125
; 1000000000459 *** 6.279052734375
; 1000000000471 *** 6.26708984375
; 1000000000537 *** 6.27099609375
; 1000000000543 *** 6.26904296875
; 1000000000547 *** 6.26806640625
; 1000000000561 *** 6.26904296875
; 1000000000609 *** 6.26806640625
; 1000000000661 *** 6.266845703125
; 1000000000669 *** 6.27587890625
; 1000000000721 *** 6.302978515625
; 1000000000751 *** 6.291015625
; 1000000000787 *** 6.27490234375
; 1000000000789 *** 6.27001953125
; 1000000000799 *** 6.26806640625
; 1000000000841 *** 6.265869140625
; 1000000000903 *** 6.26611328125
; 1000000000921 *** 6.26708984375
; 1000000000931 *** 6.265869140625
; 1000000000933 *** 6.26904296875
; 1000000000949 *** 6.266845703125
; 1000000000997 *** 6.26611328125

;; Notice that since 1000000000000/100000000 = 100, the time is
;; sqrt(100)=10 times as much time as it takes to find the primes
;; second data set. This confirms that the prime tester is O(sqrt(n))
