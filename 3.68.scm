#lang racket

;; interleave is not a special form. It will try to evaluate pair. You
;; may only construct streams using cons-stream. I actually noticed
;; this when I tried to implement my own pairs procedure. I was pretty
;; confused
