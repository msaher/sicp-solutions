#!/bin/guile -l
!#


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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (accumulate op initial sequnece)
  (if (null? sequnece)
      initial
      (op (car sequnece)
          (accumulate op initial (cdr sequnece)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

;; I understand that I can use abstraction to solve this in a more elegent
;; manner, but I'm honestly too lazy for that. This might be the reason why some
;; avoid abstraction.

;; Really not efficient, but It is Tue 04 Aug 2020 12:27:07 AM.

(define (make-sum a1 a2 . A)
  (define all (append (list a1 a2) A))
  (define numbers (filter number? all))
  (define not-numbers (filter 
                        (lambda (elements) (not (number? elements)))
                        all))
  (cons '+
        (if (null? numbers)
            all
            (cons
              (accumulate + 0 numbers)
              not-numbers))))

(define (addend s) (cadr s))
(define (augend s) (cddr s))

;; testing
(make-sum 'a 'b 1 2 3 5 'c 'd 43)
(make-sum 'a 'b)
(addend (make-sum 'a 'b 1 2 3 5 'c 'd 43))
(augend (make-sum 'a 'b 1 2 3 5 'c 'd 43))

