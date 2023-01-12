(define (make-table) (cons '*table* '()))

(define (make-tree entry left right)
  (list entry left right))

(define (get-entry tree)
  (car tree))

(define (get-left tree)
  (cadr tree))

(define (get-right tree)
  (caddr tree))

(define (assoc key record)
  (if (null? record) false
    (let ((record-key (car (get-entry record))))
      (cond ((= key record-key) record)
            ((< key record-key) (assoc key (get-left record)))
            (else (assoc key (get-right record)))))))

(define (lookup key-list table)
  (define (iter key-list table)
    (let ((record (assoc (car key-list) (cdr table))))
      (if record
        (if (null? (cdr key-list))
          (cdr (get-entry record))
          (if (pair? (cdr (get-entry record)))
            (iter (cdr key-list) (get-entry record))
            false))
          false)))
      (if (null? key-list) false
        (iter key-list table)))

(define (insert! key-list value table)
  (define (make-tables key-list)
    (if (null? (cdr key-list))
      (make-tree (cons (car key-list) value) '() '())
      (make-tree (cons (car key-list)
                       (make-tables (cdr key-list)))
                 '() '())))
  (define (iter key-list table)
    (let ((record (assoc (car key-list) (cdr table))))
      (if record
        (if (null? (cdr key-list))
          (set-cdr! (get-entry record) value)
          (if (pair? (cdr (get-entry record)))
            (iter (cdr key-list) (get-entry record))
            (set-cdr! (get-entry record)
                      (make-tables (cdr key-list)))))
        (set-cdr! table
                  (cons (make-tables key-list)
                        (cdr table))))))
    (if (null? key-list) 'NO
      (iter key-list table)))

;; testing
(define t (make-table))

(set-cdr! t
          (make-tree (cons 5 'a)
                     (make-tree (cons 4 'b) '() '())
                     (make-tree (cons 6 'c) '() '())))


(lookup (list 4 5) t)

(insert! (list 4 5) 'x t)
