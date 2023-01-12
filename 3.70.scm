#lang racket

(provide (all-defined-out))

(require "streams.scm")

(define (merge-weighted s1 s2 weight)
  (cond ((stream-null? s1) s2)
        ((stream-null? s2) s1)
        (else
          (let ((s1car (stream-car s1))
                (s2car (stream-car s2)))
            (let 
              ((w1 (weight s1car))
               (w2 (weight s2car)))
              (cond ((< w1 w2)
                     (cons-stream
                       s1car
                       (merge-weighted (stream-cdr s1) s2 weight)))
                    ((> w1 w2)
                     (cons-stream
                       s2car
                       (merge-weighted s1 (stream-cdr s2) weight)))
                    (else
                      (cons-stream
                        s1car
                        (cons-stream
                          s2car
                          (merge-weighted (stream-cdr s1)
                                          (stream-cdr s2) weight))))))))))

;; a
(define (weighted-pairs s t weight)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (merge-weighted
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (weighted-pairs (stream-cdr s) (stream-cdr t) weight)
      weight)))

(define sum-pairs
  (weighted-pairs integers integers (lambda (pair)
                                      (+ (car pair) (cadr pair)))))

; (display-stream sum-pairs)

;; helpers for b
(define (divisible? a b)
  (= 0 (remainder a b)))

(define (divisible-by-list? a b)
  (not (null? (filter (lambda (bi) (divisible? a bi)) b))))

;; b: The ordering is weird, so I'm calling it weird-pairs
(define weird-pairs
  (stream-filter (lambda (pair)
                   (let ((i (car pair))
                         (j (cadr pair))
                         (nums (list 2 3 5)))
                     (and
                       (not (divisible-by-list? i nums))
                       (not (divisible-by-list? j nums)))))
                 (weighted-pairs integers integers
                                 (lambda (pair)
                                   (let ((i (car pair))
                                         (j (cadr pair)))
                                     (+ (* 2 i) (* 3 j) (* 5 i j)))))))

; (display-stream weird-pairs)
