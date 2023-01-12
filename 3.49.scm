;; The id techinque will not work when the procedure does not know which mutexes
;; it has to acquire beforehand

;; lets say each bank account has a local state firend, which is the bank
;; account of a friend, and there's a procedure deposit-friend that deposits
;; money to our friend. If A had B as a friend, and B also had A as a friend,
;; then running the procedure concurrently can result in a deadlock. 

;; add to make-account
(define (deposit-friend amount)
  ((deposit amount) friend))

;; if we run ((a 'deposit-friend) 10) and ((b 'deposit-friend) 10) concurrnetly
;; then we'll run into a deadlock as A will acquire B mutex, and then B will try
;; to acquire A's mutex, (assume deposit and deposit-friend are protected
;; procedures)
