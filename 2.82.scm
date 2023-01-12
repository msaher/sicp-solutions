#!/bin/guile -l
!#

; Exercise 2.82: Show how to generalize apply-generic to
; handle coercion in the general case of multiple arguments.
; One strategy is to aempt to coerce all the arguments to
; the type of the ﬁrst argument, then to the type of the sec-
; ond argument, and so on. Give an example of a situation
; where this strategy (and likewise the two-argument ver-
; sion given above) is not suﬃciently general. (Hint: Con-
; sider the case where there are some suitable mixed-type
; operations present in the table that will not be tried.)

;; any null in the list?
(define (has-null? seq)
  (memq '() seq))

;; Generate a list of coercion procedures, and the apply each one to the
;; corresponding arguement.
(define (coerce args-list)
  (define (coerce-helper remaining)
    (cond (((null? remaining) (error "Not possible to coerce"))
           (else
             (let ((master-arg (car remaining)))
               (let ((master-type (type-tag master-arg)))
                 (let ((procedure-list
                         (map (lambda (somearg)
                                (let ((sometype (type-tag somearg)))
                                  (if (eq? sometype master-type) (lambda (x) x) ; if they have the same type, then subsitute with the idenitity
                                    (get-coercion sometype master-type))))
                                args-list)))
                       (if (has-null? procedure-list) ; is the coersion procedures list valid?
                         (coerce-helper (cdr remaining)) ; try the next master-type
                         (map apply procedure-list args-list))))))))) ; apply the nth coercion to the nth argument
    (coerce-helper args-list))

;; This startegy won't work unless we explecity define coercions of the form
;; t1->t3, we can't for instance use t1->t2 and then t2->t3 without defining
;; them first

;; does the list have any #f?
(define (has-false? seq)
  (memq #f seq)) 

;; are all elements of the list the same?
(define (all-same? seq)
  (cond ((null? seq) true)
        (else
          (let ((first (car seq)))
            (has-false?
              (map (lambda (somearg)
                     (eq? somearg first))))))))

;; if `proc` does not exist, and the arguments are NOT of the same type, then
;; try apply-generic with the coerced arguements 
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (cond (proc (apply proc (map contents args)))
            ((all-same? type-tags)
             (error "No method for these types" (list op type-tags)))
            (else
              (apply-generic op (contents (coerce args))))))))
