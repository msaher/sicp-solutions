; Exercise 2.80: Deﬁne a generic predicate =zero? that tests
; if its argument is zero, and install it in the generic arith-
; metic package. is operation should work for ordinary
; numbers, rational numbers, and complex numbers.

;; add this to scheme number package
;...
(put '=zero? '(scheme-number) (lambda (x) (= x 0)))
;...

;; add this to rational numbers
;...
(put '=zero? '(rational) (lambda (x) (=zero? (numer x))))
;...
; notice that I used =zero? instead of =. This is becauset the former allows to
; deal with numbers whose numerator is not a scheme-number

(put '=zero? '(ractangular) (lambda (x) (and (=zero? (real-part x))
                                             (=zero? (imag-part x)))))

(put '=zero? '(polar) (lambda (x) (=zero? (magnitude x))))

(put '=zero? '(complex) =zero?) ;; see ex 2.77. apply generic twice.
