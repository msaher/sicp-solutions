#lang racket

(require "streams.scm")

(define (integral delayed-integrand initial-value dt)
  (cons-stream
    initial-value
    (let ((integrand (force delayed-integrand)))
      (if (stream-null? integrand)
        the-empty-stream
        (integral (delay (stream-cdr integrand))
                  (+ (* dt (stream-car integrand))
                     initial-value)
                  dt)))))

(define (solve-2nd a b dt y0 dy0)
  (define y (integral (delay dy) y0 dt))
  (define dy (integral (delay ddy) dy0 dt))
  (define ddy
    (add-streams (scale-stream dy a)
                 (scale-stream  y b)))
  y)

(define e (solve-2nd 1 0 0.001 1 1))

(define z e)
; (define z (solve-2nd 1 1 0.001 0 0))

;; testing it out wiht e
(stream-ref e 0)
(stream-ref e 1)
(stream-ref e 2)
(stream-ref e 3)
(stream-ref e 4)
(stream-ref e 5)
(stream-ref e 6)
(stream-ref e 7)
(stream-ref e 8)
(stream-ref e 9)
(stream-ref e 10)
(stream-ref e 11)
(stream-ref e 12)
(stream-ref e 1000)

; (define (solve f y0 dt)
;   (define y (integral (delay dy) y0 dt))
;   (define dy (stream-map f y))
;   y)

; (stream-ref (solve (lambda (y) y)
;                    1
;                    0.001)
;             1000)
