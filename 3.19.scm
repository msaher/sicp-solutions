;; same solution :p

(define (has-cycle? x)
  (define counted? memq)

  (define (examine-cdrs x counted)
    (cond ((null? x) #f)
          ((counted? x counted) #t)
          (else
            (examine-cdrs (cdr x) (cons x counted)))))
  (examine-cdrs x '()))

