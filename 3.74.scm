#lang racket

(require "streams.scm")

(define (sign-change-detector new old)
      (cond ((or (positive? old) (zero? old))
             (if (negative? new) -1 0))
            ((negative? old)
             (if (negative? new) 0 1))))

(define (make-zero-crossings input-stream last-value)
  (cons-stream
    (sign-change-detector
      (stream-car input-stream)
      last-value)
    (make-zero-crossings
      (stream-cdr input-stream)
      (stream-car input-stream))))

(define (random-in-range low high) 
   (let ((range (- high low))) 
     (+ low (* (random) range)))) 

(define (random-stream low high)
  (cons-stream (random-in-range low high)
               (random-stream low high)))

(define sense-data (random-stream -10 10))

(define zero-crossings-alysa
  (make-zero-crossings sense-data 0))

(define zero-crossings-eva
  (stream-map sign-change-detector
              sense-data
              (stream-cdr sense-data)))

(display "eva:")
(newline)
(stream-ref zero-crossings-eva 0)
(stream-ref zero-crossings-eva 1)
(stream-ref zero-crossings-eva 2)
(stream-ref zero-crossings-eva 3)
(stream-ref zero-crossings-eva 4)
(stream-ref zero-crossings-eva 5)
(stream-ref zero-crossings-eva 6)
(stream-ref zero-crossings-eva 7)
(stream-ref zero-crossings-eva 8)
(stream-ref zero-crossings-eva 9)
(stream-ref zero-crossings-eva 10)

(display "alyssa:")
(newline)
(stream-ref zero-crossings-eva 0)
(stream-ref zero-crossings-eva 1)
(stream-ref zero-crossings-eva 2)
(stream-ref zero-crossings-eva 3)
(stream-ref zero-crossings-eva 4)
(stream-ref zero-crossings-eva 5)
(stream-ref zero-crossings-eva 6)
(stream-ref zero-crossings-eva 7)
(stream-ref zero-crossings-eva 8)
(stream-ref zero-crossings-eva 9)
(stream-ref zero-crossings-eva 10)


; ; || eva:   || alyssa:
; ; || 1      || 1
; ; || 0      || 0
; ; || 0      || 0
; ; || -1     || -1
; ; || 1      || 1
; ; || 0      || 0
; ; || 0      || 0
; ; || -1     || -1
; ; || 1      || 1
; ; || 0      || 0
; ; || -1     || -1
