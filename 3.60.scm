(define (mul-series s1 s2)
  (add-streams (stream-scale (stream-car s1) s2)
               (mul-series (stream-cdr s1) s2)))
