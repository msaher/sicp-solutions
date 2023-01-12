#lang racket

(require "3.70.scm")
(require "streams.scm")

(define (cubed x)
  (* x x x))

(define (cubed-weight pair)
  (let ((i (car pair))
        (j (cadr pair)))
    (+ (cubed i) (cubed j))))

(define pairs-ordered-by-cubes
  (weighted-pairs integers integers cubed-weight))

(define (helper pairs)
  (if (or (stream-null? pairs)
          (stream-null? (stream-cdr pairs)))
    the-empty-stream
    (let ((p1 (stream-car pairs))
          (p2 (stream-car (stream-cdr pairs))))
      (let ((wp1 (cubed-weight p1))
            (wp2 (cubed-weight p2)))
        (if (= wp1 wp2)
          (cons-stream (list p1 p2 wp1) (helper (stream-cdr pairs)))
          (helper (stream-cdr pairs)))))))

(define ramanujan-numbers
  (helper pairs-ordered-by-cubes))

(stream-ref ramanujan-numbers 0)
(stream-ref ramanujan-numbers 1)
(stream-ref ramanujan-numbers 2)
(stream-ref ramanujan-numbers 3)
(stream-ref ramanujan-numbers 4)
(stream-ref ramanujan-numbers 5)

; '((1 12) (9 10) 1729)
; '((2 16) (9 15) 4104)
; '((2 24) (18 20) 13832)
; '((10 27) (19 24) 20683)
; '((4 32) (18 30) 32832)
; '((2 34) (15 33) 39312)
