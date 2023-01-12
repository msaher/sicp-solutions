#!/bin/guile -l

;; It's importnat to note that:
(let ((<var> <exp>)) <body>)

; is syntactic sugar for:
((lambda (<var> <body>) <exp>))

;; Now let's say we evaluate the following:
(define (make-withdraw initial-amount)
  ((lambda (balance)
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))) initial-amount))


1. create a procedure object with parameter initial-amount, and pointer to
   global, and the body:

((lambda (balance)
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))) initial-amount)

Finally, bind it to make-withdraw

(define W1 (make-withdraw 100))

2. Apply (make-withdraw 100), which creates a new frame e1 and binds
   initial-amount to 100, and evalutes the body:

((lambda (balance)
    (lambda (amount)
      (if (>= balance amount)
        (begin (set! balance (- balance amount))
               balance)
        "Insufficient funds"))) initial-amount)

We have to define the first lambda first, and we create the procedure object
with parameter balance, and pointer to E1, because it was created there. and the
we apply it to initial-amount. To apply it, we create a new frame E2 with
balance set to 100, and it has a body of another lambda expression, which is
procedure that has a parameter of amount and points to E2. E2 points to E1
itself. 

It's interesting to see that the redundent lambda expression created a redundent
frame. The W1 procedure will only interact with the second created frame that
has the value of balance, and it will be able to modify it.

(W1 50)

This creates a new frame, EW1 with amount being set to 50. which sets balance to
