(define fibs
  (cons-stream
    0
    (cons-stream 1 (add-streams (stream-cdr fibs) fibs))))

(stream-map + (stream-cdr fibs) fibs)

;; with memo
;; k = 0, no force
;; k = 1, no force
;; k = 2, 1 force
;; k = 3, 1 force
;; k = 4, 1 force
;; .
;; .
;; .
;; k = n, 1 force
;; total = (n-2) forces

;; no memo
;; for each force, we have to add up all the previous forces for fib and for
;; (stream-cdr fib), so we get fib(k-1) + fib(k-2), but thats exactly fib(k). 
;; k = 0, no force
;; k = 1, no force
;; k = 2, 1 force
;; k = 3, 2 force
;; k = 4, 3 force
;; k = 5, 5 force
;; k = 6, 8 force
;; .
;; .
;; .
;; k = n, fib(n) force
;; total = fib(n+2)-1-1, which is equal to the sum of the first n numbers with
;; fib(1) excluded, but thats equal to (phi^(n+2)-psi^(n+2))/sqrt(5) - 2
