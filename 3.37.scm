(define (c+ x y)
  (let ((z (make-connector)))
    (adder x y z)
  z))

(define (c- x y)
  (c+ x (- y)))

(define (c* x y)
  (let ((z (make-connector)))
    (multiplier x y z)
  z))

(define (c/ x y)
    (c* x (/ 1 y)))

(define (cv k)
  (let ((z (make-connector)))
    (constant k z)
    z))
