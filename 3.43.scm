;; Each individual exchange procedure is ran under a combination of two
;; serializes, this means that it's not possible for any withdraw or deposit
;; transaction to interrupt the exchange procedure. Therefore, the three bank
;; accounts must have 10, 20 and 30 dollars in some order.


;; If we use the old exchange programs, then the exchange procedure might
;; not run s intended because someone might run a transaction between the time
;; that the exchange procedure is computing the difference and the time it
;; deposits/withdraws the money.

;; However, this does not mean that the total amount of money in the three banks
;; is not conserved. This is because of the fact that each individual
;; transaction is serialized, and that addition and subtraction are associative.
;; If the actual withdraw/deposit procedures were not serialized, then the money
;; is not conserved as one transaction might ignore another, depending on the
;; time tat the procedures change the balance variable. 
