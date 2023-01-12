(define (reverse x)
  (define (loop x y)
    (if (null? x)
      y
      (let ((temp (cdr x)))
        (set-cdr! x y)
        (loop temp x))))
  (loop x '()))

(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))

(define (set-front-ptr! deque item)
(set-car! deque item))

(define (set-rear-ptr! deque item)
(set-cdr! deque item))

(define (empty-deque? deque)
(null? (front-ptr deque)))

(define (make-deque) (cons '() '()))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with an empty deque" deque)
    (car (front-ptr deque))))

(define (rear-insert-deque! deque item)
  (let ((new-pair (cons item '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque (reverse new-pair))
           (front-deque deque))
           (else
             (set-cdr! (rear-ptr deque) (rear-ptr deque))
             (set-car! (rear-ptr deque) new-pair)
             (front-deque deque)))))

(define (front-insert-deque! deque item)
  (let ((new-pair (cons item '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-pair)
           (set-rear-ptr! deque (reverse new-pair))
           (front-deque deque))
           (else
             (set-cdr! (front-ptr deque) (front-ptr deque))
             (set-car! (front-ptr deque) new-pair)
             (front-deque deque)))))

(define (front-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else (set-front-ptr! deque (cdr (front-ptr deque)))
              (front-deque deque))))

(define (rear-delete-deque! deque)
  (cond ((empty-deque? deque)
         (error "DELETE! called with an empty deque" deque))
        (else (set-rear-ptr! deque (cdr (rear-ptr deque)))
              (front-deque deque))))

;; testing
(define x (make-deque))

(front-insert-deque! x 'b)
(rear-insert-deque! x 'c)


