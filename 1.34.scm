#lang racket

(define (f g) (g 2))

(f f)

;; (f f)
;; (f 2)
;; (2 2)
;; but 2 is not a procedure (ignore , so we get an error
