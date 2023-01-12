#lang racket

(define (f-recur n)
  (if (<= n 3)
    n
    (+ (f-recur (- n 1))
       (* 2 (f-recur (- n 2)))
       (* 3 (f-recur (- n 3))))))

; (f-recur 1) 1
; (f-recur 2) 2
; (f-recur 3) 3
; (f-recur 4) 10
; (f-recur 5) 22
; (f-recur 6) 51
; (f-recur 7) 125
; (f-recur 8) 293
; (f-recur 9) 696
; (f-recur 10) 1657

(define (f-iter n)
  (define (iter a b result count stop)
    (if (= count stop) result
      (iter b
            result
            (+ (* 3 a) (* 2 b) (* 1 result))
            (+ count 1) 
            stop)))
  (if (<= n 3) n ; notice the =
    (iter 1 2 3 0 (- n 3))))

(define test 10)
(f-iter test)
(f-recur test)

;; This function is quite simillar to the fib function in the
;; sense that they are both defined recurively. Its much more natural to
;; define them using tree recursion, but its not efficient at all.
;; Instead, its better to *generate* each element up to n starting with the
;; inital conditions and *store* them as parameters for the next
;; iteration.
