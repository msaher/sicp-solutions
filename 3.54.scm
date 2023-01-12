(define (mul-streams s1 s2)
  (stream-map * s1 s2))

;; we know that n! = n * (n-1)! so we have to multiply by n each time to get n!
(define factorials
  (cons-stream 1 (mul-streams
                   (cdr-stream integers)
                   factorials)))
