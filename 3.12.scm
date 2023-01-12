(load "mutators.scm")

; Consider the interaction:

(define x (list 'a 'b))
(define y (list 'c 'd))
(define z (append x y))
z

(cdr x)
(b) ; answer

(define w (append! x y))
w
(a b c d)
(cdr x)
(b c d) ; answer
