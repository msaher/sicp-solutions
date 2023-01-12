#!/bin/guil -l
!#

(define (make-monitored f)
  (let ((counter 0))
    (define (mf arg)
      (cond ((eq? arg 'how-many-calls?) counter)
            ((eq? arg 'reset-count)
             (set! counter 0))
            (else
              (let ((f-arg (f arg))) ; (f arg) first so counter not increase incase (f arg) failes
              (set! counter (+ counter 1))
              f-arg))))
    mf))

(define s (make-monitored sqrt))

;; testing

(s 100)

(s 'how-many-calls?)

(s 4)

(s 'how-many-calls?)

(s -1)

(s 'how-many-calls?)
