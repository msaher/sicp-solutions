#!/bin/racket -l
!#

#lang racket
(require sicp-pict)

(define (up-split p n)
  (if (= n 0)
      p
      (let ((smaller (up-split p (- n 1))))
        (below p (beside smaller smaller)))))

(define (right-split painter n)
  (if (= n 0)
      painter
      (let ((smaller (right-split painter (- n 1))))
        (beside painter (below smaller smaller)))))

;; notice the patteren, and use abstraction
(define (split dir loc)
  (lambda (painter n)
    (if (= n 0)
        painter
        (let ((smaller ((split dir loc) painter (- n 1))))
          (dir painter (loc smaller smaller))))))

(define right-split (split beside below))
(define up-split (split below beside))

;; check by substituting
; (split beside below)
; (lambda (painter n)
;   (if (= n 0)
;       painter
;       (let ((smaller ((split beside below) (- n 1))))
;         (loc painter (dir samaller smaller)))))

