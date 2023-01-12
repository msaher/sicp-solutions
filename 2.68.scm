#!/bin/guile -l


(load "huffman.scm")

(define sample-tree
  (make-code-tree (make-leaf 'A 4)
                  (make-code-tree
                    (make-leaf 'B 2)
                    (make-code-tree
                      (make-leaf 'D 1)
                      (make-leaf 'C 1)))))

(define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))

(define sample-decode (decode sample-message sample-tree)) 

;; '(A D A B B C A)


(define (encode message tree)
  (if (null? message) '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))

; (define (element-of-set? x set)
;   (cond ((null? set) false)
;         ((equal? x (car set)) true)
;         (else
;           (element-of-set? x (cdr set)))))

; (define (choose-branch bit branch)
;   (cond ((= bit 0) (left-branch branch))
;         ((= bit 1) (right-branch branch))
;         (else (error "bad bit: CHOOSE-BRANCH" bit))))

; (define (encode-symbol sym tree)
;   (cond ((null? tree) '())
;         ((element-of-set? sym (symbols tree))
;          (cond
;            ((leaf? tree) '())
;            ((element-of-set? sym (symbols (left-branch tree)))
;             (cons 0 (encode-symbol sym (left-branch tree))))
;            ((element-of-set? sym (symbols (right-branch tree)))
;             (cons 1 (encode-symbol sym (right-branch tree))))))
;         (else
;           (error "bad symbol" sym)))


(define (element-of-set? x set)
  (cond ((null? set) false)
        ((equal? x (car set)) true)
        (else (element-of-set? x (cdr set)))))

(define (encode message tree)
  (if (null? message)
      '()
      (append (encode-symbol (car message) tree)
              (encode (cdr message) tree))))


;; working, but can be faster.
; (define (encode-symbol sym tree)
;   (cond ((or (null? tree) (leaf? tree)) '())
;         ((element-of-set? sym (symbols tree))
;          (let ((in-left-branch? (element-of-set? sym (symbols (left-branch tree)))))
;            (if in-left-branch?
;                (cons 0 (encode-symbol sym (left-branch tree)))
;                (cons 1 (encode-symbol sym (right-branch tree))))))
;         (else
;           (error "bad symbole" sym))))

;; from wiki, nicer.
(define (encode-symbol sym tree)
  (if (leaf? tree)
      (if (eq? sym (symbol-leaf tree)) '()
          (error "Bad"))
      (let ((left-side  (left-branch tree)))
        (if (element-of-set? sym (symbols left-side))
            (cons 0 (encode-symbol sym left-side))
            (cons 1 (encode-symbol sym (right-branch tree)))))))

; (define sample-message '(0 1 1 0 0 1 0 1 0 1 1 1 0))
; ;; '(A D A B B C A)

(define sample-text '(A D A B B C A))
(encode sample-text sample-tree)
