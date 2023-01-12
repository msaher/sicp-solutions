#!/bin/guile -l

; (define make-f 
;   (let ((inital 1))
;     (define (f x)
;       (set! initial (- inital x))
;       initial)
;     f))

(define (make-f master)
  (define (f x)
    (if (= master -1)
      (begin (set! master x) x)
      0))
  f)

(define f (make-f -1))

(+ (f 0) (f 1))
;; mit-scheme and racket + guile give different results. mit-scheme: right to
;; left, racket + guile: left to right

;; elegant approach found in the wiki. If you put 0 once, the result will
;; peremently be 0

; (define (make-f master)
;   (define (f x)
;     (set! master (* master x))
;     master)
;   f)
; (define f (make-f 1))
