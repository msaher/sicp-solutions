#!/bin/guile -l
!#

; (define (intersection-set set1 set2)
;   (if (or (null? set1) (null? set2))
;       '()
;       (let ((x1 (car set1)) (x2 (car set2)))
;         (cond ((= x1 x2)
;                (cons x1 (intersection-set (cdr set1)
;                                           (cdr set2))))
;               ((< x1 x2)
;                (intersection-set (cdr set1) set2))
;               ((< x2 x1)
;                (intersection-set set1 (cdr set2)))))))


(define (union-set s1 s2)
  (cond ((null? s1) s2)
        ((null? s2) s1)
        (else
          (let ((x1 (car s1))
                (x2 (car s2)))
            (cond ((= x1 x2)
                   (cons x1 (union-set (cdr s1) (cdr s2))))
                  ((< x1 x2)
                   (cons x1 (union-set (cdr s1) s2)))
                  (else
                    (cons x2 (cons x1 (union-set (cdr s1) (cdr s2))))))))))

;; testing
; (union-set (list 1 2 4 6) (list 5))
; (union-set (list 0 4 6) (list 0 4 5 8))
; (union-set (list 1 2 3) (list 5))


;; really elgent solution found http://community.schemewiki.org/?sicp-ex-2.62
;; here.

 ; (define (union-set-2 set1 set2) 
 ;   (cond ((null? set1) set2) 
 ;         ((null? set2) set1) 
 ;         (else 
 ;           (let ((x1 (car set1)) 
 ;                 (x2 (car set2))) 
 ;             (cons (min x1 x2) 
 ;                   (union-set-2 (if (> x1 x2) 
 ;                                  set1 
 ;                                  (cdr set1)) 
 ;                                (if (> x2 x1) 
 ;                                  set2 
 ;                                  (cdr set2)))))))) 
