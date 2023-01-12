;;; tables
(define (make-table label) (list label))
(define (get-records table) (cdr table))
(define (set-records! table records) (set-cdr! table records))
; (define (append-table table record)
;   (cons (car table)
;         (append (list record) (get-records table))))
;;; record[s]
;;; trees
(define (make-tree e lb rb) (list e lb rb))
(define (entry tree) (car tree))
(define (left-branch tree) (cadr tree))
(define (right-branch tree) (caddr tree))
;; records
(define (make-record key value lb rb) (make-tree (cons key value) lb rb))

(define (get-key   entry) (car entry ))
(define (get-value entry) (cdr entry))

; (define (set-value! record newvalue) (set-cdr! (entry record) newvalue))
(define (set-value! entry newvalue) (set-cdr! entry newvalue))

(define append-rec-to-recs cons)
(define make-records list)
(define append-records append)

(define (first-record records) (car records))
; (define (rest-records records) (cdr records))

(define (assoc key record)
  (if (null? record) false
    (let ((key-record (get-key (entry record))))
      (cond ((= key key-record) (entry record))
            ((< key key-record)
             (assoc key (left-branch record)))
            (else
              (assoc key (right-branch record)))))))

  ;;; testing
  (define t (make-table '*table*))


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
    
; (define (lookup key-list table)
;   (define (iter key-list table)
;     (let ((record (assoc (car key-list) (get-records table))))
;       (if record
;         (if (null? (cdr key-list))
;           (get-value record)
;           (if (not (pair? (get-records record)))
;             false
;             (iter (cdr key-list) record))) ; must be a table
;           false)))
;   (if (null? table)
;     false
;     (iter key-list table)))

; (define (insert! key-list value table)

;   (define (make-tables key-list)
;     (if (null? (cdr key-list))
;         (make-record (car key-list) value)
;         (append-table (make-table (car key-list))
;                       (make-tables (cdr key-list)))))

;   (define (iter key-list table)
;     (let ((record (assoc (car key-list) (get-records table))))
;       (if record
;         (if (null? (cdr key-list))
;           (set-value! record value)
;           (set-records! record
;                         (make-tables (cdr key-list))))
;         (set-records! table
;                       (append-rec-to-recs (make-tables key-list)
;                                           (get-records table))))))

;   (if (null? table) 'NO
;     (iter key-list table)))


;;; tree 

(define (lookup key-list table)
  (define (iter key-list table)
    (let ((sub (assoc (car key-list) (get-records table))))
      (if sub
        (if (null? (cdr key-list))
          (get-value sub)
          (if (not (pair? (get-value sub)))
            false
            (iter (cdr key-list) (get-value sub))))
        false)))
  (if (null? key-list) false
    (iter key-list table)))

(define (insert! key-list table value)

  (define (make-tables key-list)
    (if (null? (cdr key-list)) (make-record (car key-list) value '() '())
      (make-record (car key-list)
                   (make-tables (cdr key-list))
                   '() '())))

  ; (define (iter key-list table)
  ;   (let ((e (assoc (car key-list) (get-records table))))
  ;     (if e
  ;       (if (null? (cdr key-list))
  ;         (set-value! e value)
  ;         (set-value! e (make-tables (cdr key-list))))
  ;       (set-records! table (make-tables key-list)))))
  ; (if (null? key-list) 'NO
  ;   (iter key-list table)))

  (define (help key-list table)
    (let ((e (assoc (car key-list) (get-records table))))
      (if e
        (if (null? (cdr key-list))
          (set-value! e value)
          (set-value! e (make-tables (cdr key-list))))
        (set-value! table (make-tables key-list)))))
  (if (null? key-list) 'NO
    (help key-list table)))


;;; testing
(define t (make-table '*table*))
(set-records! t (make-record 5 'a
                             (make-record 4 'b '() '())
                             (make-record 6 'c '() '())))

(insert! (list 10) 'c t)

(lookup (list 5) t)

(insert! (list 5) 'x t)

(lookup (list 10) t)

(set-value! (assoc 5 (get-records t)) 'a))

;; sorting
(define (min-list l)
    (if (null? l) 999999999
      (min (car l) (min-list (cdr l)))))

(define (remove x l)
  (cond ((null? l) '())
        ((= x (car l)) (cdr l))
        (else
          (cons (car l)
                (remove x (cdr l))))))

(define (sort l)
  (if (null? l) '()
    (let ((smallest (min-list l)))
      (cons smallest (sort (remove smallest l))))))

(iter (cadr l) (cdr l) (list (car l))))

(sort (list 18 3 1 85 91 5))

(make-tables (list 1 2 3))

  (define (make-tables key-list)
    (if (null? (cdr key-list)) (make-record (car key-list) 10 '() '())
      (make-record (car key-list)
                   (make-tables (cdr key-list))
                   '() '())))


(get-(get-value (entry (get-value (entry (make-tables (list 1 2 3))))))

(make-tables (list 1 2 3))


