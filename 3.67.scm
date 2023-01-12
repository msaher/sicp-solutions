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

(define (stream-filter pred stream)
  (cond ((stream-null? stream) the-empty-stream)
        ((pred (stream-car stream))
         (cons-stream (stream-car stream)
                      (stream-filter
                        pred
                        (stream-cdr stream))))
        (else (stream-filter pred (stream-cdr stream)))))
;;;


; (define all-pairs
;   (let ((half-pairs (pairs integers integers)))
;     (stream-filter (lambda (x y) (not (= x y)))
;             (interleave half-pairs (stream-map reverse half-pairs)))))

; (display-stream (pairs integers integers))

; (define (pairs s t)
;   (cons-stream
;     (list (stream-car s) (stream-car t))
;     (interleave
;       (stream-map (lambda (x) (list (stream-car s) x))
;                   (stream-cdr t))
;       (pairs (stream-cdr s) (stream-cdr t)))))

; (define (pairs s t)
;   (cons-stream
;     (list (stream-car s) (stream-car t))
;     (interleave
;       (stream-map (lambda (x) (list (stream-car s) x))
;                   (stream-cdr t))
;       (pairs (stream-cdr s) (stream-cdr t)))))


; (define (all-pairs s t)
;   (define (mono-directional s t)
;     (cons-stream (list (stream-car s) (stream-car t))
;       (interleave 
;         (stream-map (lambda (x) (list (stream-car s) x))
;                     (stream-cdr t))
;         (all-pairs (stream-cdr s) t)))) ;; remove the cdr here
;   (interleave (mono-directional s t)
;               (stream-map reverse (mono-directional t s))))

(define (cons-the-reverses s)
  (if (null? s) the-empty-stream
    (let ((cars (car s)))
    (cons-stream cars
                 (cons-stream (reverse cars)
                              (cons-the-reverses (stream-cdr s)))))))

;; I'm not actually sure if repetition is allowed, but this will
;; but this will repeat (i i) (i i) twice, since the procedure
; (define (all-pairs s t)
;   (cons-stream
;     (list (stream-car s) (stream-car t))
;     (list (stream-car t) (stream-car s))
;     (interleave
;       (cons-the-reverses ;; simply cons the reverse of the pair you get
;         (stream-map (lambda (x) (list (stream-car s) x))
;                     (stream-cdr t)))
;       (all-pairs (stream-cdr s) t)))) ;; remove the cdr here since  i > j is possible

;; If repetition is not allwed then we can do this

;; Another solution (I saw this in the wiki after seeing that most people
;; didn't implement repeated entries.
(define (all-pairs s t)
  (let ((make-pair (lambda (x y) (list x y))))
  (cons-stream
    (list (stream-car s) (stream-car t))
    (interleave
      (cons-stream
        (stream-map (lambda (y) (make-pair (stream-car s) y))
                    (stream-cdr s))
        (stream-map (lambda (y) (make-pair (stream-car t) y))
                    (stream-cdr t)))
      (pairs (stream-cdr s) (stream-cdr t))))))


(display-stream (all-pairs integers integers))

; (display-stream
;   (interleave 
;     (stream-map (lambda (x) (list (stream-car integers) x)) integers)))
