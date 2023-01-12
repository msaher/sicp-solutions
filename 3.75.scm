#lang racket

(require "streams.scm")


;; Louises implementation:
;; input-stream last-value
;; (make-zero-crossings (1 2 3 4 5 6) 0)
    ;; avpt = 0.5
    ;; (sign-change-detector 1/2 0)
    ;; (make-zero-crossings (2 3 4 5 6) 1.25;;
        ;; avpt = 1.25

;; Fixed implementation:
;; input-stream last-value last-avpt
;; (make-zero-crossings (1 2 3 4 5 6) 0 0)
    ;; avpt = 0.5
    ;; (sign-change-detector 0.5 0)
    ;; (make-zero-crossings (2 3 4 5 6) 1 0.5)
        ;; avpt = 1.5

;; I had to look this one up. I didn't really understand what exactly Lem E
;; Tweakit meant by averageing the values. I recognized that Louis
;; averaged recursively, but I thought that was the desired behaviour.

(define (make-zero-crossings input-stream last-value last-avpt)
  (let ((avpt (/ (+ (stream-car input-stream)
                    last-value)
                 2)))
    (cons-stream
      (sign-change-detector avpt last-value)
      (make-zero-crossings
        (stream-cdr input-stream) (stream-car input-stream) avpt))))
