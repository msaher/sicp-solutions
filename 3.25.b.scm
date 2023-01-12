;;; tables
(define (make-table label) (list label))
(define (get-records table) (cdr table))
(define (set-records! table records) (set-cdr! table records))
(define (append-table table record)
  (cons (car table)
        (append (list record) (get-records table))))
;;; record[s]
(define (make-record key value) (cons key value))
(define (get-key record) (car record))
(define (get-value record) (cdr record))
(define (set-value! record newvalue) (set-cdr! record newvalue))
(define append-rec-to-recs cons)
(define make-records list)
(define append-records append)
(define (first-record records) (car records))
(define (rest-records records) (cdr records))

(define (assoc key records)
  (if (null? records) false
    (let ((record (first-record records)))
      (if (equal? key (get-key record)) record
        (assoc key (rest-records records))))))

; (define (lookup key table)
;   (let ((record (assoc key (get-records table))))
;     (if record
;       (get-value record)
;       false)))

; (define (insert! key value table)
;   (let ((record (assoc key (get-records table))))
;     (if record
;       (set-value! record value)
;       (set-records! table
;                     (append-rec-to-recs (make-record key value)
;                                         (get-records table))))))
    
(define (lookup key-list table)
  (define (iter key-list table)
    (let ((record (assoc (car key-list) (get-records table))))
      (if record
        (if (null? (cdr key-list))
          (get-value record)
          (if (not (pair? (get-records record)))
            false
            (iter (cdr key-list) record))) ; must be a table
          false)))
  (if (null? table)
    false
    (iter key-list table)))

(define (insert! key-list value table)

  (define (make-tables key-list)
    (if (null? (cdr key-list))
        (make-record (car key-list) value)
        (append-table (make-table (car key-list))
                      (make-tables (cdr key-list)))))

  (define (iter key-list table)
    (let ((record (assoc (car key-list) (get-records table))))
      (if record
        (if (null? (cdr key-list))
          (set-value! record value)
          (set-records! record
                        (make-tables (cdr key-list))))
        (set-records! table
                      (append-rec-to-recs (make-tables key-list)
                                          (get-records table))))))

  (if (null? table) 'NO
    (iter key-list table)))


  ;;; testing
  (define t (make-table '*table*))
  (set-records! t (make-records
                   (make-record 'a 1)
                   (make-record 'b 2)
                   (make-record 'c 3)))
