(define (same-key? key1 key2)
  (or (equal? key1 key2)
      (and 
        (and (number? key1) (number? key2))
        (<= tolerance (abs (- key1 key2)))))
