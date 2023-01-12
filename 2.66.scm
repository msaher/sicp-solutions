#!/bin/guile -l
!#

; (define (lookup given-key set-of-records)
;   (cond ((null? set-of-records) false)
;         ((equal? given-key (key (car set-of-records)))
;          (car set-of-records))
;         (else (lookup given-key (cdr set-of-records)))))

(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
(define (make-tree entry left right)
  (list entry left right))

(define (lookup given-key set-of-records)
  (cond ((null? set-of-records) false)
        ((= given-key (key (entry set-of-records)))
         (entry set-of-records))
        ((< given-key (key (entry set-of-records)))
         (lookup given-key left-branch))
        (else
          (lookup given-key right-branch))))
