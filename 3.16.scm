(define (count-pairs x)
  (if (not (pair? x))
    0
    (+ (count-pairs (car x))
       (count-pairs (cdr x))
       1)))

;; return 3
(define x (list 'a 'b 'c))
(count-pairs x)

; return 4
(define x (list 'a 'b 'c))
(set-car! x (cdr (cdr x)))
(count-pairs x)

;; return 7
(define x (list 'a 'b 'c))
(set-car! x (cdr x))
(set-car! (cdr x) (cdr (cdr x)))
(count-pairs x)

;; forever (loop)
(define x (list 'a 'b 'c))
(set-cdr! x x))
(count-pairs x)
