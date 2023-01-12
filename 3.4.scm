#!/bin/guile -l
!#

(define (make-account balance password)
  (let ((incorrect-counter 0))
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
        (begin 
          (set! incorrect-counter 0)
          (cond ((eq? m 'withdraw) withdraw)
                ((eq? m 'deposit) deposit)
                (else (error "Unknown request: MAKE-ACCOUNT" m))))
        (begin
          (set! incorrect-counter (+ incorrect-counter 1))
          (if (= incorrect-counter limit)
            (begin (set! incorrect-counter 0)
                   (call-the-cops))
            (error "Incorrect password")))))
      dispatch))

;; Dispatch is now too complex, needs abstraction via internal procedures :)

(define (make-account balance password)
  (let ((incorrect-counter 0) (limit 7))
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
        (eq? pas password))

      (define (call-the-cops)
        (set! incorrect-counter 0)
        (error "Calling the cops..."))

      (define (incorrect-password)
        (set! incorrect-counter (+ incorrect-counter 1))
        (if (= incorrect-counter limit)
          (call-the-cops)
          (error "Incorrect passowrd" incorrect-counter)))

      (define (pick-procedure m)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request: MAKE-ACCOUNT" m))))

      (if (correct-password? given-password)
        (begin (set! incorrect-counter 0)
               (pick-procedure m))
        (incorrect-password)))
    dispatch))

;; testing
(define acc (make-account 100 'secret-password))

((acc 'secret-password 'withdraw) 40)

((acc 'some-other-password 'withdraw) 50)


