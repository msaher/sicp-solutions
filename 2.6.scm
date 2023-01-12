#!/bin/guile -l
!#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define zero (lambda (f) (lambda (x) x))) 

(define add-1 (lambda (n) (lambda (f) (lambda (x) (f ((n f) x)))))) 

;; Substituation
; (add-1 zero)

; ((lambda (n) (lambda (f) (lambda (x) (f ((n f) x))))) (lambda (f) (lambda (x) x)))

; (lambda (f) (lambda (x) (f ((n f) x))))

; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) x)) f) x))))

; (lambda (f) (lambda (x) (f ((lambda (x) x) x))))

; (lambda (f) (lambda (x) (f x)))

(define one (lambda (f) (lambda (x) (f x))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Substituation
; (add-1 one)

; (add-1 (lambda (f) (lambda (x) (f x))))

; ((lambda (n) (lambda (f) (lambda (x) (f ((n f) x))))) (lambda (f) (lambda (x) (f x))))

; (lambda (f) (lambda (x) (f (((lambda (f) (lambda (x) (f x))) f) x))))

; (lambda (f) (lambda (x) (f ((lambda (x) (f x)) x))))

(define two (lambda (f) (lambda (x) (f (f x)))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (+ n m)
  (lambda (f) (lambda (x) ((m f) ((n f) x)))))

;;;;;;;;;;;;;;;;;;The rest of this file is scratch;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;As well as testing the + precedure;;;;;;;;;;;;;;;;;;;;
;(+ zero zero)

;(+ (lambda (f) (lambda (x) x)) (lambda (f) (lambda (x) x)))

;(lambda (f) (lambda (x) (((lambda (f) (lambda (x) x)) f) (((lambda (f) (lambda (x) x)) f) x))))

;(lambda (f) (lambda (x) (((lambda (f) (lambda (x) x)) f) (((lambda (f) (lambda (x) x)) f) x))))

;(lambda (f) (lambda (x) ((lambda (x) x) ((lambda (x) x) x))))

;(lambda (f) (lambda (x) ((lambda (x) x) x)))

;(lambda (f) (lambda (x) x)) = zero
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(+ one one)

;(+ (lambda (f) (lambda (x) (f x))) (lambda (f) (lambda (x) (f x))))

;(lambda (f) (lambda (x) (((lambda (f) (lambda (x) (f x))) f) (((lambda (f) (lambda (x) (f x))) f) x))))

;(lambda (f) (lambda (x) ((lambda (x) (f x)) ((lambda (x) (f x)) x))))

;(lambda (f) (lambda (x) ((lambda (x) (f x)) (f x))))

;(lambda (f) (lambda (x) (f (f x)))) = two
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;(define two
;  (lambda (f) (lambda (x) (f (f x)))))

;(define three
;  (lambda (f) (lambda (x) (f (f (f x))))))

;(+ two three)

;(lambda (f) (lambda (x) ((m f) ((n f) x))))

;(lambda (f) (lambda (x) (((lambda (f) (lambda (x) (f (f (f x))))) f) (((lambda (f) (lambda (x) (f (f x)))) f) x))))

;(lambda (f) (lambda (x) ((lambda (x) (f (f (f x)))) ((lambda (x) (f (f x))) x))))

;(lambda (f) (lambda (x) ((lambda (x) (f (f (f x)))) (f (f x)))))

;(lambda (f) (lambda (x) ((f (f (f (f (f x))))))))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
