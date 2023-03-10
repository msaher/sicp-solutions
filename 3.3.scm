#!/bin/guil -l
!#

;; old program
; (define (make-account balance)
; (define (withdraw amount)
;   (if (>= balance amount)
;     (begin (set! balance (- balance amount))
;            balance)
;     "Insufficient funds"))
; (define (deposit amount)
;   (set! balance (+ balance amount))
;   balance)

; (define (dispatch m)
;   (cond ((eq? m 'withdraw) withdraw)
;         ((eq? m 'deposit) deposit)
;         (else (error "Unknown request: MAKE-ACCOUNT"
;                      m))))
; dispatch)

(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
             balance)
      "Insufficient funds"))
  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)
  (define (dispatch given-password m)
    (if (eq? given-password password)
      (cond ((eq? m 'withdraw) withdraw)
            ((eq? m 'deposit) deposit)
            (else (error "Unknown request: MAKE-ACCOUNT"
                         m)))
      (error "Incorrect password")))
    dispatch)

(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'withdraw) 50)


