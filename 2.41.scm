#!/bin/guile -l
!#

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define nil (list))

(define (enumerate-interval low high)
  (if (> low high)
      nil
      (cons low (enumerate-interval (+ low 1) high))))

(define (accumulate op initial sequnece)
  (if (null? sequnece)
      initial
      (op (car sequnece)
          (accumulate op initial (cdr sequnece)))))

(define (filter predicate sequence)
  (cond ((null? sequence) nil)
        ((predicate (car sequence))
         (cons (car sequence)
               (filter predicate (cdr sequence))))
        (else (filter predicate (cdr sequence)))))

(define (map p sequence)
  (accumulate (lambda (x y)
                (cons (p x) y)) nil sequence))

(define (append seq1 seq2)
  (accumulate cons seq2 seq1))

(define (flatmap p seq)
  (accumulate append nil (map p seq)))

(define (prime? n)
  (define (square x) (* x x))
  (define (smallest-divisor n)
    (define (iter n test-divisor)
      (cond ( (> (square test-divisor) n) n )
	    ( (= (remainder n test-divisor) 0) test-divisor )
	    (else (iter n (+ test-divisor 1)))))
    (iter n 2))
  (and (not (= (smallest-divisor n) 1)) (= (smallest-divisor n) n)))

(define (uniqe-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j)
                    (list i j)) (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))


(define (prime-sum-pairs n)
  (define (make-pair-sum pair)
    (list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
  (define (prime-sum? pair)
    (prime? (+ (car pair)
               (cadr pair))))
  (map make-pair-sum
       (filter prime-sum? (uniqe-pairs n))))
  
(prime-sum-pairs 6)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (uniqe-triple n)
  (flatmap (lambda (i)
             (flatmap (lambda (j)
                (map (lambda (k) (list i j k)) (enumerate-interval 1 (- j 1))))
                     (enumerate-interval 1 (- i 1))))
         (enumerate-interval 1 n)))

(uniqe-triple 5)

(define (uniqe-pairs n)
  (flatmap (lambda (i)
             (map (lambda (j)
                    (list i j)) (enumerate-interval 1 (- i 1))))
             (enumerate-interval 1 n)))


(define (sum-less-than n s)
  (filter (lambda (triple)
            (< (+ (car triple)
                  (cadr triple)
                  (caddr triple))
               s))
          (uniqe-triple n)))

(sum-less-than 10 12)

;; Harder queston: what If I want to find x distinct integers less than n? I
;; don't know yet

; (define (uniqe-integers n x)
;   (if (= x 0) (list nil)
;   (flatmap 
;     (flatmap (lambda (i) (cons i (uniqe-integers n (- x 1))))
;          (enumerate-interval 1 (- n 1)))
;     (enumerate-interval 1 n))))
         
; (uniqe-integers 6 5)


;  (define (uniqe-integers n k) 
;      (cond ((< n k) nil) 
;            ((= k 0) (list nil)) 
;            (else (append (uniqe-integers (- n 1) k) 
;                          (map (lambda (tuple) (cons n tuple)) 
;                               (uniqe-integers (- n 1) (- k 1))))))) 
