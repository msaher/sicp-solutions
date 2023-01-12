#!/bin/guile -l !#

;; generic negation
(define (negate x)
  (apply-generic 'negate x))

;; in scheme number package
(put 'negate 'scheme-number (lambda (x) (tag (- x))))

;; rat package
(put 'negate 'rational (lambda (x) (tag (make-rat (- (numer x)) (denom x)))))

;; into rectangular
(put 'negate 'rectangular (lambda (x)
                            (tag (make-from-real-imag 
                                   (- (real-part x)) (- (imag-part x))))))

;; into polar
(put 'negate 'polar (lambda (x) (tag (make-from-mag-ang
                                       (mag x) (+ (ang x) 180)))))

;; into complex
(put 'negate 'complex negate) ; double tag system

;; into poly
;; Usses map, which assumes a list in the underlying data structure. Not the
;; best method.
(define (negate-terms L)
  (if (empty-termlist? L) (the-empty-term-list)
    (map 
      (lambda (someterm)
        (make-term (order someterm)
                   (negate (coeff someterm))))
      L)))

;; use adjoin from maximum abstraction! Elegant.
(define (negate-terms L)
  (if (empty-termlist? L) the-empty-term-list
    (let ((t1 (first-term L)))
      (let ((negated-t1 
              (make-term (order t1) (negate (coeff t1)))))
        (adjoin-term negated-t1
                     (negate-terms (rest L)))))))

;; Silly, but fun alternative. I'm assuming we can always multiply by minus-one
(define (negate-terms poly)
  (let ((minus-one (make-term 0 -1)))
  (make-polynomial (var poly)
                   (mul-term-by-all-terms minus-one (terms poly)))))


(define (negate-poly poly)
  (make-poly (var poly)
             (negat-terms (terms poly))))

(put 'negate 'polynomial (lambda (x) (tag (negate-poly x))))


;; generic sub in terms of negate
(define (sub x y)
  (apply-generic 'add x (negate y))) 

;; We can subtract polynomials now :D
