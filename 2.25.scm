#!/bin/guile -l
!#

;; a
(define a (list 1 3 (list 5 7) 9))
(car (cdr ( car (cdr (cdr a)))))

;; b
(define b (list (list 7)))
(car (car b))

;; c
(define c (list 1 (list 2 (list 3 (list 4 (list 5 (list 6 7)))))))
(car ; take the element 7
  (cdr ; get rid of element 6
    (car ; take the list starting with 6
      (cdr ; get rid of element 5
        (car ; take the list starting with 5
          (cdr ; get rid of element 4
            (car ; take the list starting with 4
              (cdr ; get rid of element 3
                (car ; take the list starting with 3
                  (cdr ; get rid of element 2
                    (car ; take the list starting with 2
                      (cdr c)))))))))))) ; get rid of element 1
