(define (make-cycle x)
  (set-cdr! (last-pair x) x) x)

(set-cdr! (last-pair x) y)

(define x (list 'a 'b 'c))
(define y (list 'm 'n 'p))
x

(define y (make-cycle x))
y

(define z (make-cycle y))
