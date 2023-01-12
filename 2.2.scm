(define (make-point x y)
  (cons x y))

(define (x-point point)
  (car point))

(define (y-point point)
  (cdr point))

(define (make-segment p1 p2)
  (cons p1 p2))

(define (start-segment line)
  (car line))

(define (end-segment line)
  (cdr line))

(define (average x y)
  (/ (+ x y) 2))

(define (midpoint-segment line)
  (make-point
    (average (x-point (start-segment line))
	     (x-point (end-segment line)))
    (average (y-point (start-segment line))
	     (y-point (end-segment line)))))

(define (print-point p)
  (newline)
  (display "(")
  (display (x-point p))
  (display ",")
  (display (y-point p))
  (display ")"))

