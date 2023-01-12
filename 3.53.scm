(define s (cons-stream 1 (add-streams s s)))

;; this is the same as
(define s (cons-stream 1 (stream-scale 2 s)))

;; which is the same as
(define s (cons-stream 1 (stream-scale 2 (cons-stream 1 (stream-scale 2 s)))))

;; we're scaling by 2 repeatedly. its the powers of 2
