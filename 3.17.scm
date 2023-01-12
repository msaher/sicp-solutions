; (define (count-pairs x)
;   (if (not (pair? x))
;     0
;     (+ (count-pairs (car x))
;        (count-pairs (cdr x))
;        1)))

(define (count-pairs x)
  (let ((counted '()))

    (define (counted? x)
      (memq x counted))

    (define (successive-count x)
      (if (or (not (pair? x))
              (counted? x))
        0
        (begin
          (set! counted (cons x counted))
          (+ (successive-count (car x))
             (successive-count (cdr x))
             1))))

    (successive-count x)))


;; testing

(define x (list 'a 'b 'c))
(count-pairs x)

(define x (list 'a 'b 'c))
(set-car! x (cdr (cdr x)))
(count-pairs x)

(define x (list 'a 'b 'c))
(set-car! x (cdr x))
(set-car! (cdr x) (cdr (cdr x)))
(count-pairs x)

;; here the result will be 1, because this is a pair whose cdr is the pair
;; itself. Quite elegant :)
(define x (list 'a 'b 'c))
(set-cdr! x x))
(count-pairs x)
