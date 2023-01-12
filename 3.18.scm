; (define (has-cycle? x)
;   (let ((counted '()))

;     (define (counted? x)
;       (memq x counted))

;     (define (examine-cdrs x)
;       (cond ((null? x) #f)
;             ((counted? x) #t)
;             (else
;               (set! counted (cons x counted))
;               (examine-cdrs (cdr x)))))
;     (examine-cdrs x)))

;; no assignemnt 
(define (has-cycle? x)
  (define counted? memq)

  (define (examine-cdrs x counted)
    (cond ((null? x) #f)
          ((counted? x counted) #t)
          (else
            (examine-cdrs (cdr x) (cons x counted)))))
  (examine-cdrs x '()))



;; true
(define x (list 'a 'b 'c))
(set-cdr! x x))
(has-cycle? x)

;; false
(define x (list 'a 'b 'c))
(has-cycle? x)
