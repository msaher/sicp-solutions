#!/bin/guile -l
!#

;; This solutions only deals with converting polynomials in y, into polynomials
;; in x.

;; How can we convert (x + 1)y = yx + y
;; (y (1 (x (1 1) (0 1))))
;; (x (1 (y (1 1))) (0 (y (1 1))))

; ;; (x + 1)y
; (define (convert-term t1 old new)
;   (define (convert-coeff)
;     (if (poly? (coeff t1))
;       t1
;       (let ((t1-with-term-list
;               (make-term (order t1)
;                          (term-list (coeff t1)))))

;; If we have a polynomial in y whose some of it's cofficients are polynomials
;; in x, then we can convert the whole polynomial so that it is in x, by
;; creating a new polynomial in x such that each cofficient in old polynomial is
;; a term with the same order, and has a polynomial in y with the old order, and
;; with the old cofficient

; (define (convert-term t1)
;   (let ((terms (term-list (coeff t1)))
;     (make-term
;       (order (first terms))
;       (make-polynomial 'y
;                        (list (order t1) (coeff t1)))))))

(define (make-term-list list))

(define (convert-poly p)
  (make-poly 'x
             (convert-terms (term-list p))))

; (define (convert-term t)
;   (if (not (poly? (coeff t))) t
;     (let (terms (term-list (coeff t)))
;     (define (iter x-terms)
;       (if (empty-term-list? x-terms) (the-empty-term-list)
;         (let ((first-x (first-term x-terms)))
;           (make-term (order first-x)
;                      (make-polynomial
;                        'y
;                        (make-term-list
;                          (make-term (order t)
;                                     (coeff first-x))))))))
;     (iter terms)

; (define (convert-term t1)
;   (let (t1-coeff (coeff t1))
;     (if (poly? t1-coeff) t1-coeff
;       (let ((terms (term-list t1-coeff)))
;         (define (successive-conversion x-term-list result)
;           (if (empty-term-list? x-term-list) (reverse result)
;           (let ((first-term (first x-term-list)))
;           (successive-conversion
;             (adjoin-term
;               (make-term (order (first-term))
;                          (make-polynomial 'y
;                                           (order t1)
;                                           (coeff first-term))))))))
;         (make-polynomial 'x
;                          (successive-conversion 
;                            terms
;                            (the-empty-term-list)))))))

(define (expand-term t1)
    ; (if (not (poly? t1-coeff)) t1 ;; do we really have to check? Might be bloat
    (let ((terms (term-list (coeff t1)))
          (order-t1 (order t1))))

    (define (successive-conversion x-term-list)
      (if (empty-term-list? x-term-list) (the-empty-term-list)
        (let ((first-term (first x-term-list)))
          (adjoin-term
            (make-term (order first-term)
                       (make-polynomial 'y
                                        (make-term
                                          order-t1
                                          (coeff first-term))))
            (successive-conversion (rest-terms x-term-list))))))

    (successive-conversion terms))

(define (expand-term-list L)
  (if (empty-term-list? L) (the-empty-term-list)
    (let ((t1 (first-term L)))
        (if (poly? (coeff t1))
          (add-terms (expand-terms (coeff t1)) ;; expansion is a term list
                     (expand-term-list (rest-terms L)))
          (expand-term-list (rest-terms L))))))

;; If we expand each term in a term list, then there might be multiple terms of
;; the same order, that's why we ues add-terms instead of adjoin.

(define (convert-poly p)
  (make-poly 'x
             (expand-term-list (term-list p))))

;; Indeed, that was not easy, and I didn't even do it properly. Now I have a
;; better understanding of the hard work that algebra systems have.
