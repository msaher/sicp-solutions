#!/bin/guile -l
!#

(define (make-mobile left right)
  (list left right))

(define (make-branch len structure)
  (list len structure))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; A

(define (left-branch mobile)
  (car mobile))

(define (right-branch mobile)
  (car (cdr mobile)))

(define (branch-length branch)
  (car branch))

(define (branch-structure branch)
  (car (cdr branch)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; 2B
(define (total-weight mobile)
  (let ((lbs (branch-structure (left-branch mobile)))
        (rbs (branch-structure (right-branch mobile))))
    (+ (if (number? rbs) rbs (total-weight rbs))
       (if (number? lbs) lbs (total-weight lbs)))))

;; testing
(define c (make-branch 0 3))
(define mb (make-mobile ba bb))
(define b (make-branch 0 mb))
(define ba (make-branch 0 1))
(define bb (make-branch 0 2))
(define a (make-mobile b c))

(total-weight a)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; c

(define (branch-torque branch)
  (let ((bs (branch-structure branch)))
  (* (branch-length branch)
     (if (number? bs) bs
         (total-weight bs)))))

; ;; testing
; (define x (make-branch 5 10))
; (define y (make-branch 5 a))

(define (mobile-balanced? mobile)
  (let ((lbs (branch-structure (left-branch mobile)))
        (rbs (branch-structure (right-branch mobile))))
    (and 
      (= (branch-torque (left-branch mobile))
         (branch-torque (right-branch mobile)))
      (if (number? lbs) true (mobile-balanced? lbs))
      (if (number? rbs) true (mobile-balanced? rbs)))))

; ;; testing
; (define p (make-branch 5 2))
; (define q (make-branch 2 5))
; (define r (make-mobile p q))
; (define br (make-branch 3 r))
; (mobile-balanced? r)
; (total-weight r)

; (define m (make-branch 2 7.5))
; (define n (make-branch 3 5))
; (define o (make-mobile m n))
; (define bo (make-branch 2 o))
; (mobile-balanced? o)
; (total-weight o)

; (define h (make-mobile br bo))

; (mobile-balanced? h)

;; more testing
;(define x (make-mobile by bz))
;(define by (make-mobile 1 y))
;(define bz (make-mobile 1 z))
;;;;
;(define y (make-mobile ba bb))
;(define ba (make-branch 4 5))
;(define bb (make-branch 10 2))
;;;;
;(define z (make-mobile bc bd))
;(define bc (make-branch 20 1))
;(define bd (make-branch 4 5))
;(mobile-balanced? x)

;(define k (make-branch by by))
;(mobile-balanced? k)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; (define (make-mobile left right)
;   (list left right))

(define (make-mobile left right)
  (cons left right))

; (define (make-branch len structure)
;   (list len structure))

(define (make-branch len structure)
  (cons len structure))

; (define (left-branch mobile)
;     (car mobile))

;; same
(define (left-branch mobile)
  (car mobile))

; (define (right-branch mobile)
;     (car (cdr mobile)))

;; almost same
(define (right-branch mobile)
    (cdr mobile))

; (define (branch-length branch)
;     (car branch))

;; same
(define (branch-length branch)
    (car branch))

;; almost same
(define (branch-structure branch)
    (cdr branch))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

