(define (expand num den radix)
  (cons-stream
    (quotient (* num radix) den)
    (expand (remainder (* num radix) den) den radix)))

;; apparently, this is the result of divigin num by den in radius radix, but I
;; couldn't figure this out on my own

(expand 5 4 3)
(3 (expand 3 4 3))
(3 2 (expand 1 4 3))
(3 2 0 (expand 1 4 3))
(3 2 0 0 (expand 1 4 3))
(3 2 0 0 0 (expand 1 4 3))
(3 2 0 0 0 0 (expand 1 4 3))
(3 2 0 0 0 0 0 (expand 1 4 3))

(expand 20 4 6)
(30 (expand 0 4 6))
(30 0 (expand 0 4 6))
(30 0 (expand 0 4 6))
(30 0 0 (expand 0 4 6))
(30 0 0 0 (expand 0 4 6))
(30 0 0 0 0 (expand 0 4 6))
(30 0 0 0 0 0 (expand 0 4 6))

(expand 2 4 6)
(3 (expand 0 4 6))
(3 (expand 0 4 6))
(3 0 (expand 0 4 6))
(3 0 0 (expand 0 4 6))

(expand 5 7 11)
(7 (expand 6 7 11))
(7 9 (expand 3 7 11))
(7 9 4 (expand 5 7 11)) ;; repeat!

