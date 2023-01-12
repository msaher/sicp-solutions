#lang racket


;;;
(define (expt b n)
(if (= n 0)
1
(* b (expt b (- n 1)))))

(define the-empty-stream (list))

(define (stream-null? stream)
  (null? stream))

(define-syntax cons-stream
  (syntax-rules ()
    ((cons-stream head tail)
     (cons head (delay tail)))))

(define (stream-car stream)
  (car stream))

(define (stream-cdr stream)
  (force (cdr stream)))

(define (display-stream s)
  (stream-for-each display-line s))
(define (display-line x) (newline) (display x))


(define (stream-ref s n)
  (if (= n 0)
    (stream-car s)
    (stream-ref (stream-cdr s) (- n 1))))

(define (stream-map proc . argstreams)
  (if (stream-null? (car argstreams))
    the-empty-stream
    (cons-stream
      (apply proc (map stream-car argstreams))
      (apply stream-map
             (cons proc (map stream-cdr argstreams))))))

(define (stream-for-each proc s)
  (if (stream-null? s)
    'done
    (begin (proc (stream-car s))
           (stream-for-each proc (stream-cdr s)))))

(define (partial-sums s)
  (cons-stream (stream-car s)
               (add-streams (stream-cdr s) (partial-sums s))))

(define (add-streams s1 s2) (stream-map + s1 s2))

(define (stream-append s1 s2)
  (if (stream-null? s1)
    s2
    (cons-stream (stream-car s1)
                 (stream-append (stream-cdr s1) s2))))

(define (interleave s1 s2)
(if (stream-null? s1)
s2
(cons-stream (stream-car s1)
(interleave s2 (stream-cdr s1)))))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))
;;;



; (display-stream (pairs integers integers))

;; ( (1 1) (interleave <first element of t to the rest of s> ;; s = t = ints
;;                     (pairs (cdr ints) (cdr ints))

;; ( (1 1) (1 2) (interleave (pairs (cdr ints) (cdr ints))
;;                           (<first element of t to the rest of s>)

;; ( (1 1) (1 2) (interleave ((2 2) (interleave <second element of ints to rest of ints>)
;;                                              (pairs (cdr (cdr ints) (cdr cdr ints))))
;;               <first element of t to the rest of s>))

;; ( (1 1) (1 2) (2 2) (interleave <first element of t to the rest of s>
;;                                 (interleave <second elemnt of ints ot rest of ints
;;                                             (pairs (cdr (cdr ints) (cdr cdr ints))))

;; ( (1 1) (1 2) (2 2) (1 3) (interleave (interleave <second element of ints to rest of ints)
;;                                                   (pairs (cdr (cdr ints) (cdr (cdr ints))))
;;                                       <first element of t to the rest of s>

;; ( (1 1) (1 2) (2 3) (1 3) (2 3) (interleave <first element of to the rest of s>
;;                                             (interleave (pairs (cdr (cdr ints)) (cdr (cdr ints)))
;;                                                         <second element of to the rest of s>)
;;                                 

;; ( (1 1) (1 2) (2 3) (1 3) (2 3) (1 4)

;; Finding the first 6 elements with outputing the results to head -7
; (1 1)
; (1 2)
; (2 2)
; (1 3)
; (2 3)
; (1 4)

;; Exactly the same!

;; Supposed you have a triangle of pairs
;; r1 (1 1) (1 2) (1 3) (1 4) (1 5) (1 6) (1 7) (1 8) (1 9) (1 10) (1 11) (1 12) (1 13) (1 14)
;; r2       (2 2) (2 3) (2 4) (2 5) (2 6) (2 7) (2 8) (2 9) (2 10) (2 11) (2 12) (2 13) (2 14)
;; r3             (3 3) (3 4) (3 5) (3 6) (3 7) (3 8) (3 9) (3 10) (3 11) (3 12) (3 13) (3 14)
;; r4                   (4 4) (4 5) (4 6) (4 7) (4 8) (4 9) (4 10) (4 11) (4 12) (4 13) (4 14)
;; .
;; .
;; .


;; Then the next element will be constructed by taking:
; (r1 interleave (r2 interleave (r3 interleave r5 interleave r6 ... )

;; The sequence will be 
;;n= 1     2     3     4     5     6     7     8     9     10    11    12    13    14    15    16
;; (1 1) (1 2) (2 2) (1 3) (2 3) (1 4) (3 3) (1 5) (2 4) (1 6) (3 4) (1 7) (2 5) (1 8) (4 4) (1 9) (2 6) (1 10) (3 5) (1 11) (2 7) (1 12) (4 5) (1 13) (2 8) (1 14) (3 6) (1 15) (2 9) (1 16) (5 5) (1 17) (2 10) (1 18) (3 7) (1 19) (2 11) (1 20) (4 6) (1 21) (2 12) (1 22) (3 8) (1 23) (2 13) (1 24) (5 6) (1 25) (2 14) (1 26) (3 9) (1 27) (2 15) (1 28) (4 7) (1 29) (2 16) (1 30) (3 10) (1 31) (2 17) (1 32) (6 6) (1 33) (2 18) (1 34) (3 11) (1 35) (2 19) (1 36) (4 8) (1 37) (2 20) (1 38) (3 12) (1 39) (2 21) (1 40) (5 7) (1 41) (2 22) (1 42) (3 13) (1 43) (2 23) (1 44) (4 9) (1 45) (2 24) (1 46) (3 14) (1 47) (2 25) (1 48) (6 7) (1 49) (2 26) (1 50) (3 15)

;; If we get rid of the js we get
;; 1 1 2 1 2 1 3 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1 5 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1 5 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1 6 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1 5 1 2 1 3 1 2 1 4 1 2 1 3 1 2 1 6 1 2 1 3 
;; Notice that ones appear every other term (except when first appears)
;; Notice that twos appear every four terms (except when it first appears, which will be 2)
;; Notice that threes appear every eight terms (except whe it first appears, which will be 4)
;; We can conclude that four appears every 16 terms (except when it first appears, which will be 4)
;; In general i appears every 2^i except when it first
;; appears, it will appear every 2^(i-1). And the term i will
;; appear when n = 2^i - 1
;; So the first i=4 is when n=15

;; Suppose you have (i i). When will we reach (i j)?  We know that
;; there are 2^i - 1 elements between each i, so we have to go
;; through (j - i) * (2^(i-1)) elements before we reach (i j). In
;; addition, we have to reach (i 1) in the first place, and we do that when n =
;; (2^i) - 1, but the next iteration of i will be after 2^(i-1)
;; In total, reaching (i j) when total_n = reaching_n + firstiteration_n + gettingj_n
;; total_n = 2^(i)-1 + 2^(i)-1 + (j - i) * 2^(i-1)
;; However, when j=i we have no use for the second term. Therefore we have
;; n = 2^(i)-1 + 2^(i-1)-1 + (j - i) * 2^(i)
;; n = (j - i + 1)*2^(i) - 1 + (if j=i 2^(i-1))

;; a quickly made unoptimzied procedure to find n given (i j)

(define (pair-index pair)
  (if (or 
        (null? pair)
        (not (= (length pair) 2))
        (> (car pair) (car (cdr pair))))
    0
    (let ((i (car pair))
          (j (cadr pair)))
      (if (= i j)
        (- (expt 2 i) 1)
        (+ (* (+ j (- i)) (expt 2 i))
           -1
           (expt 2 (- i 1)))))))

;; testing
(pair-index (list 1 3))
(pair-index (list 2 3))
(pair-index (list 3 3))
(pair-index (list 4 4))

; (pair-index (list 1 100)) 198
; (pair-index (list 99 100)) 950737950171172051122527404031
; (pair-index (list 100 100)) 1267650600228229401496703205375



