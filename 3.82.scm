#lang racket

(require "streams.scm")

(define (randoms-in-range low high)
  (define range (- high low))
  (stream-map (lambda (one)
                (+ low (* (random) range)))
              ones))

(define (monte-carlo experiment-stream passed failed)
  (define (next passed failed)
    (cons-stream
      (/ passed (+ passed failed))
      (monte-carlo
        (stream-cdr experiment-stream) passed failed)))
  (if (stream-car experiment-stream)
    (next (+ passed 1.0) failed)
    (next passed (+ failed 1.0))))

(define (estimate-integral P x1 x2 y1 y2)
  (define exp-stream
      (stream-map
        P
        (randoms-in-range x1 x2)
        (randoms-in-range y1 y2)))
  (let ((area (* (abs (- x2 x1)) (abs (- y2 y1)))))
    (stream-scale (monte-carlo exp-stream 0 0) area))) ;; that's the integral

(define square (lambda (x) (* x x)))

(define pi
  (estimate-integral (lambda (x y)
                       (<= (+ (square x) (square y)) 1))
                     -1 1 -1 1))

(stream-ref pi 1000000.0)

;; I have noticed that this implementation is slower than 3.5.scm
;; Could it be that streams are less efficient? Perhaps chapter 4 will
;; clarify.
