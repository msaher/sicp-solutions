#lang racket

(require "streams.scm")
(require "3.70.scm")

(define (square x)
  (* x x))

(define (sum-of-sqaures p)
  (let ((x (car p))
        (y (cadr p)))
    (+ (square x) (square y))))

(define pairs-ordered-by-squares
  (weighted-pairs integers integers sum-of-sqaures))

(define (helper pairs)
    (if (or (stream-null? pairs)
            (stream-null? (stream-cdr pairs))
            (stream-null? (stream-cdr pairs)))
      the-empty-stream
      (let ((p1 (stream-car pairs))
            (p2 (stream-car (stream-cdr pairs)))
            (p3 (stream-car (stream-cdr (stream-cdr pairs)))))
        (let ((w1 (sum-of-sqaures p1))
              (w2 (sum-of-sqaures p2))
              (w3 (sum-of-sqaures p3)))
          (if (= w1 w2 w3)
            (cons-stream (list p1 p2 p3 w3)
                         (helper (stream-cdr pairs)))
            (helper (stream-cdr pairs)))))))

(define sum-of-sqaures-in-three-ways
  (helper pairs-ordered-by-squares))

(stream-ref sum-of-sqaures-in-three-ways 0)
(stream-ref sum-of-sqaures-in-three-ways 1)
(stream-ref sum-of-sqaures-in-three-ways 2)
(stream-ref sum-of-sqaures-in-three-ways 3)
(stream-ref sum-of-sqaures-in-three-ways 4)
