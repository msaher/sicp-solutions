#!/bin/guile -l
!#

(define (partial-tree elts n)
  (if (= n 0)
      (cons '() elts)
      (let ((left-size (quotient (- n 1) 2)))
        (let ((left-result
                (partial-tree elts left-size)))
          (let ((left-tree (car left-result))
                (non-left-elts (cdr left-result))
                (right-size (- n (+ left-size 1))))
            (let ((this-entry (car non-left-elts))
                  (right-result
                    (partial-tree
                      (cdr non-left-elts)
                      right-size)))
              (let ((right-tree (car right-result))
                    (remaining-elts
                      (cdr right-result)))
                (cons (make-tree this-entry
                                 left-tree
                                 right-tree)
                      remaining-elts))))))))

(define (list->tree elements)
  (car (partial-tree elements (length elements))))

;; partical tree divides the list of elements into right and left sides, and a
;; node (median). It applies the procedure recursively into each part, and makes
;; a tree where the left part is another partial tree and the right part is also
;; another partial tree.

;; As for growth... log_2 n? I'm not sure
