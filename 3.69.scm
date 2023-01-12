#lang racket

;;;
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

(define ones (cons-stream 1 ones))
(define integers (cons-stream 1 (add-streams ones integers)))


; (define (pairs s t)
;   (cons-stream
;     (list (stream-car s) (stream-car t))
;     (interleave
;       (stream-map (lambda (x) (list (stream-car s) x))
;                   (stream-cdr t))
;       (pairs (stream-cdr s) (stream-cdr t)))))

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                        pred
                        (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))
;;;

; (define (triples s t u)
;   (define (pairs t u)
;     (cons-stream (list (stream-car t) (stream-car u))
;                  (stream-append 
;                    (stream-map (lambda (x) (list (stream-car t) x))
;                                (stream-cdr t))
;                    (pairs (stream-cdr t) (stream-cdr u)))))
;   (cons-stream (list (stream-car s) (stream-car t) (stream-car u))
;                (interleave
;                  (stream-map (lambda (x) (append (list (stream-car s)) x))
;                              (pairs (stream-cdr t) (stream-cdr u)))
;                  (triples (stream-cdr s) (stream-cdr t) (stream-cdr u)))
;                ))

    ; (stream-map (lambda (x) (list (stream-car s) (stream-car t) x))
    ;             (stream-cdr u))))

; (define (pairs t u)
;     (cons-stream (list (stream-car t) (stream-car u))
;                  (stream-append 
;                    (stream-map (lambda (x) (list (stream-car t) x))
;                                (stream-cdr t))
;                    (pairs (stream-cdr t) (stream-cdr u)))))

; (display-stream (pairs integers integers))

; (display-stream pythagorean-triples)


; (define (triples s t u)
;   (define (pairs t u)
;     (cons-stream
;       (list (stream-car t) (stream-car u))
;       (interleave
;         (stream-map (lambda (ui) (list (stream-car t) (stream-car u)))
;                     (stream-cdr t))
;         (pairs (stream-cdr t) (stream-cdr u)))))
;   (let ((s1 (stream-car s))
;         (sn-1 (stream-cdr s))
;         (t1 (stream-car t))
;         (tn-1 (stream-cdr t))
;         (u1 (stream-car u))
;         (un-1 (stream-cdr u)))
;     (cons-stream 
;       (list s1 t1 u1)
;       (interleave
;         (stream-map (lambda (pair) (cons s1 pair))
;                     (pairs tn-1 un-1))
;         (triples sn-1 tn-1 un-1)))))


(define (square x) (* x x))

(define (pairs s t)
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (stream-map (lambda (x) (list (stream-car s) x))
                  (stream-cdr t))
      (pairs (stream-cdr s) (stream-cdr t)))))


;; take the corner
;; repeat (first second increment third)
;; (triple increment all)
;; Notice that you're recursing twice here

(define (triples s t u)
  (cons-stream (list (stream-car s)
                     (stream-car t)
                     (stream-car u))
               (interleave
                 (stream-map (lambda (pair) (cons (stream-car s) pair))
                             (stream-cdr (pairs t u))) ; take the cdr to avoid duplicates
                 (triples (stream-cdr s)
                          (stream-cdr t)
                          (stream-cdr u)))))

(define (pythagorean-triple? triple)
  (let ((a (car triple))
        (b (car (cdr triple)))
        (c (car (cdr (cdr triple)))))
    (= (+ (square a) (square b)) (square c))))

(define pythagorean-triples 
  (stream-filter pythagorean-triple?
                 (triples integers integers integers)))


; (display-stream (triples integers integers integers))

(stream-ref pythagorean-triples 0)
(stream-ref pythagorean-triples 1)
(stream-ref pythagorean-triples 2)
(stream-ref pythagorean-triples 3)
(stream-ref pythagorean-triples 4)
