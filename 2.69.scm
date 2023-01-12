;#!/bin/guile -l
;!#

(load "huffman.scm")

(define (generate-huffman-tree pairs)
  (successive-merge (make-leaf-set pairs))) ;; make-leaf-set makes symbol weight pairs

; (define (successive-merge leaf-tree-set)
;   (if (or (null? leaf-tree-set)
;           (null? (cdr leaf-tree-set)))
;        leaf-tree-set
;        (successive-merge
;          (adjoin-set
;            (make-code-tree (car leaf-tree-set)
;                            (cadr leaf-tree-set))
;            (cddr leaf-tree-set)))))


; (define (successive-merge leaf-tree-set)
;   (if (or (null? leaf-tree-set)
;           (null? (cdr leaf-tree-set)))
;        leaf-tree-set
;        (successive-merge
;          (adjoin-set
;            (make-code-tree (car leaf-tree-set)
;                            (cadr leaf-tree-set))
;            (cddr leaf-tree-set)))))
; ;; testing
; (define mytest '((A 1) (B 2) (C 3) (D 4)))

;; nice!
(define (successive-merge leaf-tree-set)
  (cond ((null? leaf-tree-set) '())
        ((null? (cdr leaf-tree-set)) (car leaf-tree-set))
        (else
          (successive-merge
            (adjoin-set
              (make-code-tree (car leaf-tree-set)
                              (cadr leaf-tree-set))
              (cddr leaf-tree-set))))))

;; refactoring 1: no need to check for null, because make-leaf-set does it already
(define (successive-merge leaf-tree-set)
  (if (null? (cdr leaf-tree-set))
      (car leaf-tree-set)
      (successive-merge
        (adjoin-set
          (make-code-tree (car leaf-tree-set)
                          (cadr leaf-tree-set))
          (cddr leaf-tree-set)))))

;; testing
(define mytest '((A 1) (B 2) (C 3) (D 4)))
(define myleaf (make-leaf-set mytest))
(generate-huffman-tree mytest)
(define kill (adjoin-set (make-code-tree (car myleaf) (cadr myleaf)) (cdr (cdr myleaf))))
