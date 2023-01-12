#lang racket

(define (stream-limit s)
  (if (empty-stream? s) the-empty-stream
    (let ((s1 (stream-car s))
          (s2 (stream-car (stream-cdr s))))
      (if (< (abs (- s1 s2)) tolerance)
        s2
        (stream-limit (stream-cdr s))))))
