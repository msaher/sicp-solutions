;; easier to understand solution
(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-stream (stream-scale ones (stream-car s))
                           (partial-sums (stream-cdr s)))))

;; better solution from wiki: each time we shift by one element.
;; (s0 s1 s2 ...) + (0 partial-sums)
;; but this gives us (s0 s1 s2 ...) + (0 s0 s1 s2 ... + partial-sums)
; (define (partial-sums s) 
;   (add-streams s (cons-stream 0 (partial-sums s))))

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s) (partial-sums s)))
