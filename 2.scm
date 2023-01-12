#!/bin/guile -l
!#

(define (get-record employee file)
  ((get 'record file) employee))


(define (get-salary employee file)
  ((get 'salary file) employee))

(define (find-employee-record name all)
  (if (null? all) '()
      (let ((first-record (get-record name (car all))))
        (if (null? first-record)
            (find-employee-record name (cdr all))
            first-record))))
