(define (make-queue)
  (let ((front-ptr '())
        (rear-ptr '()))
    (define (empty-queue?)
      (null? front-ptr))

    (define (front-queue)
      (if (empty-queue?)
        (error "FRONT called with an empty queue" (cons front-ptr rear-ptr))
        (car front-ptr)))

    (define (insert-queue! item)
      (let ((new-pair (cons item '())))
        (cond ((empty-queue?)
               (set! front-ptr new-pair)
               (set! rear-ptr new-pair)
               (cons front-ptr rear-ptr))
              (else
                (set-cdr! rear-ptr new-pair)
                (set! rear-ptr new-pair)
                (cons front-ptr rear-ptr)))))

    (define (delete-queue!)
      (cond ((empty-queue?)
             (error "DELETE! called with an empty queue" (cons front-ptr rear-ptr)))
            (else (set! front-ptr (cdr front-ptr))
                  (cons front-ptr rear-ptr))))

    (define (dispatch m)
      (cond ((eq? m 'delete-queue!) (delete-queue!))
            ((eq? m 'insert-queue!) insert-queue!)
            ((eq? m 'front-queue) (front-queue))
            ((eq? m 'empty-queue?) (empty-queue?))
            (else
              (error "BAD PROCEDURE: DOES NOT EXIST" m))))

    dispatch)))

;; testing
(define q (make-queue))
(q 'empty-queue?)
((q 'insert-queue!) 'c)
(q 'delete-queue!)
(q 'front-queue)
