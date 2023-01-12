(define (invert-unit-series s)
  (cons-stream 1 (stream-map (lambda (e) (- 1 e))
                             (mul-series (stream-cdr s)
                                         (invert-unit-series s)))))
