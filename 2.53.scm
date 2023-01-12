#!/bin/guile -l
!#

(list 'a 'b 'c)
;; '(a b c)

(list (list 'george))
;; (list (geroge))
;; '((geroge))

(cdr '((x1 x2) (y1 y2)))
;; '((y1 y2))

(cadr '((x1 x2) (y1 y2)))
;; (car '((y1 y2))
;; '(y1 y2)

(pair? (car '(a short list)))
;; (pair? a)
;; f

(memq 'red '((red shoes) (blue socks)))
;; false

(memq 'red '(red shoes blue socks))
;; '(red shoes) (blue socks))
