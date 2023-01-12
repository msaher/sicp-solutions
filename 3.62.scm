(define (div-series s1 s2)
  (mul-series s1 (invert-series-unit s2)))

(define tangent-series
  (div-series sin-series cosine-series))
