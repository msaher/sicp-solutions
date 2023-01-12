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
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; attempt 3

(define empty-board nil)

(define (make-pos row col)
  (list row col))

(define (find-row pos)
  (car pos))

(define (find-col pos)
  (cadr pos))

(define (adjoin-position row col sol)
  (cons (make-pos row col) sol))

(define (safe-pos? p q)
   (let ((sum-row-col (lambda (sompos) (accumulate + 0 sompos)))
         (sub-row-col (lambda (sompos) (accumulate - 0 sompos))))
     (not (or
            (= (find-row p) (find-row q)) ; same row?
            (= (find-col p) (find-col q)) ; same col?
            (= (sum-row-col p) (sum-row-col q)) ; same upright diagonal?
            (= (sub-row-col p) (sub-row-col q)))))) ; same downleft diagonal?

(define (danger-pos? p q)
  (not (safe-pos? p q)))

 (define (safe? col sol)
   (let ((my-pos (car (filter (lambda (each-pos)
                           (= (find-col each-pos) col)) sol)))
         (others (filter (lambda (each-pos)
                                (not (= (find-col each-pos) col))) sol)))
     (null? (filter (lambda (each-pos)
                      (danger-pos? my-pos each-pos)) others))))

;; testing area, be careful

(safe? 8 mybsol)

(define p1 (make-pos 3 1))
(define p2 (make-pos 7 2))
(define p3 (make-pos 2 3))
(define p4 (make-pos 8 4))
(define p5 (make-pos 5 5))
(define p6 (make-pos 1 6))
(define p7 (make-pos 4 7))
(define p8 (make-pos 6 8))
(define p8b (make-pos 1 8))

(define mysol (list p1 p2 p3 p4 p5 p6 p7 p8))
(define mybsol (list p1 p2 p3 p4 p5 p6 p7 p8b))

(adjoin-position 2 2 mysol)

(define (queens board-size)
  (define (queen-cols k)
    (if (= k 0)
        (list empty-board)
        (filter
          (lambda (positions) (safe? k positions))
          (flatmap
            (lambda (rest-of-queens)
              (map (lambda (new-row)
                     (adjoin-position
                       new-row k rest-of-queens))
                   (enumerate-interval 1 board-size)))
            (queen-cols (- k 1))))))
  (queen-cols board-size))

(define empty-board nil)

(queens 5)
