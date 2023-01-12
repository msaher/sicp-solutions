#lang racket

;;; A
;; Notice that we divide the input by 3 every time. This means that this is
;; really a problem of findings how many times we divide by three. In other
;; words, we have 12.5/3^n <= 0.1, so 3^n > 125 or n = 5. So the procedure p
;; will run 5 times.

(define (cube x) (* x x x))

(define (p x)
  (displayln "ran p")
  (- (* 3 x) (* 4 (cube x))))

(define (sine angle)
  (if (not (> (abs angle) 0.1))
    angle
    (p (sine (/ angle 3.0)))))

;; Running the procedure we get
(sine 12.5)

; ran p
; ran p
; ran p
; ran p
; ran p
; -0.060813768577286265

;;; B
;; Simillar to A, given an input a, we have to find an n such that 3^n > 10a we
;; find that n = log(10a). Therefore O(n) = log(n)

