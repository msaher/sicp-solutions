(define (half-adder a b s c)
  (let ((d (make-wire)) (e (make-wire)))
    (or-gate a b d)
    (and-gate a b c)
    (inverter c e)
    (and-gate d e s)
    'ok))

(define (full-adder a b c-in sum c-out)
  (let ((s (make-wire)) (c1 (make-wire)) (c2 (make-wire)))
    (half-adder b c-in s c1)
    (half-adder a s sum c2)
    (or-gate c1 c2 c-out)
    'ok))

(define (ripple-carry-adder a-list b-list s-list c)
  (if (null? a-list) 'ok
    (let ((c-out (make-wire)))
      (full-adder (car a-list) (car b-list) (car s-list) c c-out)
      (ripple-carry-adder (cdr a-list) (cdr b-list) (cdr s-list) c-out)))
