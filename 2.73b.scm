
; (load "data-dir.scm")

(define (operator exp) (car exp)) ;; implying that we have to use prefix notation
(define (operands exp) (cdr exp)) ;;

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (same-variable? v1 v2)
(and (variable? v1) (variable? v2) (eq? v1 v2)))

(define (deriv exp var)
  (cond ((number? exp) 0)
        ((variable? exp) (if (same-variable? exp var) 1 0))
        (else ((get 'deriv (operator exp)) ; means that notation is abstracted by this
               (operands exp) var))))


(define (variable? x) (symbol? x))

(define (same-variable? v1 v2)
  (and (variable? v1) (variable? v2) (eq? v1 v2)))


(define (multiplier p) (cadr p))

(define (multiplicand p) (caddr p))

(define (=number? exp num) (and (number? exp) (= exp num)))

(define (make-product m1 m2)
  (cond ((or (=number? m1 0) (=number? m2 0)) 0)
        ((=number? m1 1) m2)
        ((=number? m2 1) m1)
        ((and (number? m1) (number? m2)) (* m1 m2))
        (else
          (list '* m1 m2))))

(define (make-sum a1 a2)
  (cond ((=number? a1 0) a2)
        ((=number? a2 0) a1)
        ((and (number? a1) (number? a2))
         (+ a1 a2))
        (else (list '+ a1 a2))))

(define (addend s) (cadr s))

(define (augend s) (caddr s))



(define (product? x) (and (pair? x) (eq? (car x) '*)))

(define (make-exponentiation b n)
  (cond ((=number? n 0) 1)
        ((=number? n 1) b)
        ;; if both are number than simplify.
        (else
          (list '** b n))))

(define (exponentiation? x) (and (pair? x) (eq? (car x) '**)))
(define (base x) (cadr x))
(define (exponent x) (caddr x))

(put 'deriv '+ (lambda (exp var)
                 (make-sum (deriv (car exp) var)
                           (deriv (cdr exp) var))))

(put 'deriv '* (lambda (exp var)
                 (make-sum
                   (make-product
                     (deriv (car exp) var)
                     (cdr exp))
                   (make-product
                     (car exp)
                     (deriv (cdr exp) var)))))


(deriv (make-product  2 'x ) 'x)

(deriv (make-sum 1 2) 'x)

(define myterm (make-product (make-sum 'x 1) (make-sum 'x 2)))

(multiplier myterm)
(multiplicand myterm)
