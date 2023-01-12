(define (make-table)
  (let ((local-table (list '*table*)))

    (define (view)
      local-table)

    (define (lookup key-list)
      (define (iter key-list table)
        (let ((sub (assoc (car key-list) (cdr table))))
          (if sub
            (if (null? (cdr key-list))
              (cdr sub)
              (if (pair? (cdr sub))
                (iter (cdr key-list) sub)
                false))
            false)))
      (if (null? key-list) false
        (iter key-list local-table)))


    (define (insert! key-list value)

      (define (make-tables key-list)
        (if (null? (cdr key-list)) (cons (car key-list) value)
          (list (car key-list)
                (make-tables (cdr key-list)))))

      (define (iter key-list table)
        (let ((sub (assoc (car key-list) (cdr table))))
          (if sub
            (if (null? (cdr key-list))
              (set-cdr! sub value)
              (if (pair? (cdr sub)) ; is table?
                (iter (cdr key-list) sub)
                (set-cdr! sub (list (make-tables (cdr key-list))))))
              (set-cdr! table
                        (cons (make-tables key-list)
                              (cdr table))))))
      (if (null? key-list) 'NO
        (iter key-list local-table)))


      (define (make-tables key-list value)
        (if (null? (cdr key-list)) (cons (car key-list) value)
          (list (car key-list)
                (make-tables (cdr key-list) value))))

    (define (dispatch m)
      (cond ((eq? m 'lookup-proc) lookup)
            ((eq? m 'insert-proc!) insert!)
            ((eq? m 'view) view)
            ((eq? m 'make-tables) make-tables)
            (else (error "Unknown operation: TABLE" m))))
    dispatch))

;; testing
(define x (make-table))

; lvl 1
((x 'view))

((x 'insert-proc!) (list 'a) 1)

((x 'lookup-proc) (list 'a))

; lvl 2
(define keys (list 'a 'b 'c))
(define value 2)

((x 'view))

((x 'lookup-proc) keys)

((x 'insert-proc!) keys value)


((x 'make-tables) (list 'b 'c) 2)
