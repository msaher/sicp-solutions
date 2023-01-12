#!/bin/guile -l
!#

;; one of my favorite practice problems

(define nil '())

(define (accumulate op initial sequnece)
  (if (null? sequnece)
      initial
      (op (car sequnece)
          (accumulate op initial (cdr sequnece)))))

(define (accumulate-n op init seqs)
  (if (null? (car seqs))
      nil
      (cons (accumulate op init (map car seqs))
            (accumulate-n op init (map cdr seqs)))))

;; dot procut
(define (dot-product v w)
  (accumulate + 0 (map * v w)))

;; accumulate-n can be used to avoid using `map` that we have not defined
;; ourselves

(define (dot-prodcut u v)
  (accumulate + 0 
              (accumulate-n * 1 (list v u))))


;; matrix times a vector. Here we take each row, and multiply each row
;; of the matrix with the vector, then we add the result. 
(define (matrix-*-vector m v)
  (map 
    (lambda (row)
      (accumulate + 0
                  (map * row v)))
    m))

;; This can be refactored furthur

  (define (matrix-*-vector m v)
    (map 
      (lambda (row)
        (dot-prodcut row v)) m)) ; it feels weird to dot-product row but it computationally works out

;; transposing.
(define (transpose mat)
  (accumulate-n cons 
                nil
                mat))

;;; matrix times a matrix

(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (accumulate cons
                       nil
                       (matrix-*-vector cols row))) m)))

;; refactoring.  
(define (matrix-*-matrix m n)
  (let ((cols (transpose n)))
    (map (lambda (row)
           (matrix-*-vector cols row)) m)))



;; testing
(define v (list 1 2))
(define m (list (list 1 2)
                (list 3 4)))

(define M (list (list 1 2)
                (list 3 4)
                (list 5 6)))

(define n (list (list 5 6)
                (list 7 8)))

(matrix-*-vector m v)
(transpose m)
(transpose M)
(matrix-*-matrix m n)
