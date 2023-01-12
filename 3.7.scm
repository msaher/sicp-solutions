#!/bin/guile -l
!#

(define (make-account balance . password)
  (let ((incorrect-counter 0)
        (limit 7)
        (acceptable-passwords password))

    (define (withdraw amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))

    (define (deposit amount)
      (set! balance (+ balance amount))
      balance)

    (define (dispatch given-password m)

      (define (correct-password? pas)
        (memq pas acceptable-passwords))

      (define (call-the-cops)
        (set! incorrect-counter 0)
        (error "Calling the cops..."))

      (define (incorrect-password)
        (set! incorrect-counter (+ incorrect-counter 1))
        (if (= incorrect-counter limit)
          (call-the-cops)
          (error "Incorrect passowrd" incorrect-counter)))

      (define (adjoin-pass new-password)
        (set! acceptable-passwords (cons new-password acceptable-passwords))
        "done")

      (define (pick-procedure m)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              ((eq? m 'adjoin-password) adjoin-pass)
              ((eq? m 'correct-password? correct-password?))
              (else (error "Unknown request: MAKE-ACCOUNT" m))))

      (if (correct-password? given-password)
        (begin (set! incorrect-counter 0)
               (pick-procedure m))
        (incorrect-password)))
    dispatch))

(define (make-joint account existing-password adjoined-password)
  ((account existing-password 'adjoin-password) adjoined-password))

;; testing
(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'withdraw) 50)

(make-joint acc 'secret-password 'some-other-password)

((acc 'some-other-password 'withdraw) 50)
