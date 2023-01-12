(define global-counter (make-counter))

;; counter
(define (make-counter)
  (let ((val 0))
  (define (inc)
    (set! val (+ val 1)))
  (define (the-counter m)
    (cond ((eq? m 'inc) (inc))
          (else "Unknown request: MAKE-COUNTER" m)))))

;; new make-account dispatcher
(let ((balance-serializer (make-serializer))
      (id (global-counter 'inc))) ; new
  (define (dispatch m)
    (cond ((eq? m 'withdraw) withdraw)
          ((eq? m 'deposit) deposit)
          ((eq? m 'balance) balance)
          ((eq? m 'serializer) balance-serializer)
          ((eq? m 'id) id) ; new
          (else (error "Unknown request: MAKE-ACCOUNT" m))))
  dispatch)

;; old serialized-exchange procedure
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer)))
    ((serializer1 (serializer2 exchange))
     account1
     account2)))

;; new serialized-exchange procedure
(define (serialized-exchange account1 account2)
  (let ((serializer1 (account1 'serializer))
        (serializer2 (account2 'serializer))
        (id1 (account1 'id))
        (id2 (account2 'id)))
    (cond ((< id1 id2)
           ((serializer2 (serializer1 exchage))
            account1 account2))
          (else
            ((serializer1 (serializer2 exchange))
             account1 account2)))))

;;; explaination:

;; With the old serialized-exchange if A tries to exchange ac1, ac2 and B
;; concurrently tries to exchange ac2, ac1, then the following will happen: A
;; runs, and acquires the a1's mutex but before it acquires a2's mutex, B runs
;; and acquires a2's mutex first. Now A can not acquire a2's mutex, because it
;; is waiting for B to release it, but B can't acquire a1's mutex, because it is
;; watining for A to release it. They'll wait for each other forever!


;; With the old serialized-exchange if A tries to exchange ac1, ac2 and B
;; concurrently tries to exchange ac2, ac1, such that ac1's id is less than
;; ac2's id, then the following will happen: A runs, and acquires the a1's mutex
;; but before it acquires a2's mutex, B runs and tries to acquires a1's mutex
;; (since it has the smallest id), but a1's mutex is busy, so it waits for A. A
;; then goes to acquire a2's mutex, and the procedure runs normally. Once that's
;; done, then B will run, successfully avoiding deadlocks
