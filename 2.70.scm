#!/bin/guil -l
!#

(load "2.69.scm")
(load "2.68.scm")

(define song (generate-huffman-tree '((a 2) (Get 2) (Sha 3) (Wah 1) (boom 1)
                                            (job 2) (na 16) (yip 9))))

(define message
  '(
    Get a job
    Sha na na na na na na na na
    Wah yip yip yip yip yip yip yip yip yip
    Sha boom))

(encode message song)

;; variable length code 58
(define bits-required (length (encode message song)))
bits-required 

;; for fixed length it would be:
;; 3*(length message)
(define least-for-fixed (* 3.0 (length message)))
least-for-fixed

;; ratio is a little over 80%. Nice
(* 100 (/ bits-required least-for-fixed))
