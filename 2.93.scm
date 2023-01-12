#!/bin/guile -l
!#

;; I have already done that.

;; It might be possible to make the make-rat simplify  procedure generic.

(define (make-rat n d)
  (if (=zero? d) (error "bad value" d)
    (let ((gcd (get-coercion (tag-type n) (tag-type d))))
      (if gcd
        (let ((g (gcd n d)))
          (cons (div n g) (div d g)))
        (cons n d)))))
