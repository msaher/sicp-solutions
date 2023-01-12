(define (make-table) (cons '*table* '()))

(define (assoc key records)
  (cond ((null? records) false)
        ((equal? key (caar records)) (car records))
        (else (assoc key (cdr records)))))

(define (lookup key-list table)
  (define (iter key-list table)
    (let ((record (assoc (car key-list) (cdr table))))
      (if record
        (if (null? (cdr key-list))
          (cdr record)
          (iter (cdr key-list) record))
        false)))
  (if (not (null? key-list))
    (iter key-list table)))

(define (insert! key-list value table)
  (define (make-tables key-list)
    (if (null? (cdr key-list))
      (cons (car key-list) value)
      (list (car key-list)
            (make-tables (cdr key-list)))))
  (define (iter key-list table)
    (let ((record (assoc (car key-list) (cdr table))))
      (if record
        (if (null? (cdr key-list))
          (set-cdr! record value)
          (iter (cdr key-list) record))
        (set-cdr! table
                  (cons (make-tables key-list)
                        (cdr table))))))
  (if (null? key-list) 'NO
    (iter key-list table)))

(define t (make-table))

(insert! (list 'a 'b 'c) 10 t)

(lookup (list 'a 'b 'c) t)
