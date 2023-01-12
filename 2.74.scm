#!/bin/guile -l
!#

;; a
(define (get-record employee file)
  ((get 'record file) employee))

;; b
(define (get-salary employee file)
  ((get 'salary file) employee))

;; c
(define (find-employee-record name all)
  (if (null? all) '()
      (let ((first-record (get-record name (car all))))
        (if (null? first-record)
            (find-employee-record name (cdr all))
            first-record))))

;; d
;; Add their new procedures to the systme by issuing `put` on the rest of the
;; system.
