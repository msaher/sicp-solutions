#lang racket

(require "streams.scm")

(define (rlc r l c dt)
  (define (output vc0 il0)
    (define vc (integral (delay dvc) vc0 dt))
    (define il (integral (delay dil) il0 dt))
    (define dvc (stream-scale il (/ -1 c)))
    (define dil
      (add-streams
        (stream-scale vc (/ 1 l))
        (stream-scale il (/ (- r) l))))
    (cons vc il))
  output)

(define rlc-example ((rlc 1 1 0.2 0.1) 10 0))
(define vc (car rlc-example))
(define il (cdr rlc-example))

(display "vc")
(newline)
(stream-ref vc 0)
(stream-ref vc 1)
(stream-ref vc 2)
(stream-ref vc 3)
(stream-ref vc 4)
(stream-ref vc 5)
(stream-ref vc 6)
(stream-ref vc 7)
(stream-ref vc 8)
(stream-ref vc 9)
(stream-ref vc 10)

(display "il")
(newline)
(stream-ref il 0)
(stream-ref il 1)
(stream-ref il 2)
(stream-ref il 3)
(stream-ref il 4)
(stream-ref il 5)
(stream-ref il 6)
(stream-ref il 7)
(stream-ref il 8)
(stream-ref il 9)
(stream-ref il 10)

; vc
; 10
; 10
; 9.5
; 8.55
; 7.220000000000001
; 5.5955
; 3.77245
; 1.8519299999999999
; -0.0651605000000004
; -1.8831384500000004
; -3.5160605800000004
; il
; 0
; 1.0
; 1.9
; 2.66
; 3.249
; 3.6461
; 3.84104
; 3.834181
; 3.6359559
; 3.2658442599999997
; 2.750945989
