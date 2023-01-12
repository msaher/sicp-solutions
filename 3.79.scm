#lang racket

(require "streams.scm")

;; y' = f(y)
; (define (solve f y0 dt)
;   (define y (integral (delay dy) y0 dt))
;   (define dy (stream-map f y))
;   y)


; (define (solve-2nd a b dt y0 dy0)
;   (define y (integral (delay dy) y0 dt))
;   (define dy (integral (delay ddy) dy0 dt))
;   (define ddy
;     (add-streams (scale-stream dy a)
;                  (scale-stream  y b)))
;   y)


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


;; y'' = f(y',y)
(define (solve-2nd f dy0 y0 dt)
  (define y
    (integral (delay dy) y0 dt))
  (define dy
    (integral (delay ddy) dy0 dt))
  (define ddy
    (stream-map f dy y))
  y)

(define e (solve-2nd (lambda (y dy) dy)
                     1
                     1
                     0.001))

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

