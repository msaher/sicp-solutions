#lang racket

(require "streams.scm")

;; we can replace the lambda expression with any smoothing algorithim
(define (smooth input-stream)
  (stream-map (lambda (xi xi+1)
                (/ (+ xi xi+1) 2.0))
              input-stream
              (stream-cdr input-stream)))

(define zero-crossings
  (let ((smoothed-input (smooth sense-data)))
    (stream-map sign-change-detector
                sense-data
                (stream-cdr sense-data))))
