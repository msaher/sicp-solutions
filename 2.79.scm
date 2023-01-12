; Exercise 2.79: Deﬁne a generic equality predicate equ? that tests the equality
; of two numbers, and install it in the generic arithmetic package. is operation
; should work for ordi- nary numbers, rational numbers, and complex numbers.


(define (install-rational-package)

  ;; internal procedures
  (define (numer x) (car x))
  (define (denom x) (cdr x))
  (define (make-rat n d)
    (let ((g (gcd n d)))
      (cons (/ n g) (/ d g))))
  (define (add-rat x y)
    (make-rat (+ (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (sub-rat x y)
    (make-rat (- (* (numer x) (denom y))
                 (* (numer y) (denom x)))
              (* (denom x) (denom y))))
  (define (mul-rat x y)
    (make-rat (* (numer x) (numer y))
              (* (denom x) (denom y))))
  (define (div-rat x y)
    (make-rat (* (numer x) (denom y))
              (* (denom x) (numer y))))

  (define (equ-rat? x y)
    (= (* (numer x) (denom y))
       (* (numer y) (denom x))))

  ;; interface to rest of the system
  (define (tag x) (attach-tag 'rational x))
  (put 'add '(rational rational)
       (lambda (x y) (tag (add-rat x y))))
  (put 'sub '(rational rational)
       (lambda (x y) (tag (sub-rat x y))))
  (put 'mul '(rational rational)
       (lambda (x y) (tag (mul-rat x y))))
  (put 'div '(rational rational)
       (lambda (x y) (tag (div-rat x y))))
  (put 'equ? '(rational rational) equ-rat?))


;; add this to scheme-number package
  (put 'equ? '(scheme-number scheme-number) =)

(define (install-complex-package)
  ;; imported procedures from rectangular and polar packages
  (define (make-from-real-imag x y)
    ((get 'make-from-real-imag 'rectangular) x y))
  (define (make-from-mag-ang r a)
    ((get 'make-from-mag-ang 'polar) r a))
  ;; internal procedures
  (define (add-complex z1 z2)
    (make-from-real-imag (+ (real-part z1) (real-part z2))
                         (+ (imag-part z1) (imag-part z2))))
  (define (sub-complex z1 z2)
    (make-from-real-imag (- (real-part z1) (real-part z2))
                         (- (imag-part z1) (imag-part z2))))
  (define (mul-complex z1 z2)
    (make-from-mag-ang (* (magnitude z1) (magnitude z2))
                       (+ (angle z1) (angle z2))))
  (define (div-complex z1 z2)

;;; too lazy to copy everythign
;;; ...........................
;;; ...........................

;; add this to polar package
(define (equ-polar? a b)
  (and (equ? (magnitude a) (magnitude b))
             (equ? (angle a) (angle b))))

(put equ? '(polar polar) equ-polar?)

;; add this to rectangular package
(define (equ-rectangular? a b)
  (and (equ? (real-part a) (real-part b))
       (equ? (imag-part a) (imag-part b))))

(put equ? '(rectangular rectangular) equ-rectangular?)

;; add this to complex package
(define (equ-complex a b)
  (let ((polar? (lambda (x) (if (eq 'polar (type-tag x) #f))))) ; just to be faster
    (if (and (polar? a) (polar? b))
        ((get 'equ 'polar) a b) ; sure thing
        (and (equ? (real-part a) (real-part b))
             (equ? (imag-part a) (imag-part b))))))
                 
(put equ? '(compelx complex) equ-complex)
