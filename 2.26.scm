#!/bin/guile -l

(define x (list 1 2 3))
(define y (list 4 5 6))

;; a
(append x y) ; (1 2 3 4 5 6)

;; b
(cons x y) ; '( (1 2 3) 4 5 6)

;; This is because a list is pairs in the form of: 

;[a][∫]
;   [b][∫]
;      [c][∫]
;           .
;           .
;           .
;           .
;           .

; Thus, (cons X some-list) will be '( X e1 e2 ....) where ei are the
; elements of some-list. It does not matter what X is. 


; c
(list x y) ; '((1 2 3) (4 5 6))
