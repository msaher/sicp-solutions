;; This is a rather abstract and hard to read solution. There are probably
;; simpler and more elegant ways to do this. I don't understnad it myself, but
;; it works as intended. Maybe I shouldn't have wrote this at 2 AM

;; d a t a  a b s t r a c t i o n
(define (show-deque deque)
  (map car (front-ptr deque)))

(define (make-box item parent child)
  (cons (cons item parent) child))

(define (make-empty-box) (make-box '() '() '()))

(define (box-content box) (car box))
(define (box-item box) (car (box-content box)))
(define (box-parent box) (cdr (box-content box)))
(define (box-child box) (cdr box))

(define (set-box-parent! box parent)
  (set-cdr! (box-content box) parent))

(define (set-box-child! box child)
  (set-cdr! box child))

(define (set-box-item! box item)
  (set-car! (box-content box) item))

(define (no-child? box)
  (null? (box-child box)))

(define (no-parent? box)
  (null? (box-parent box)))

;; deque
(define (front-ptr deque) (car deque))
(define (rear-ptr deque) (cdr deque))
(define (set-front-ptr! deque item) (set-car! deque item))
(define (set-rear-ptr! deque item) (set-cdr! deque item))

(define (make-deque)
  (let ((empty-box (make-empty-box)))
    (cons empty-box empty-box)))
  
(define (empty-deque? deque)
  (let ((box (front-ptr deque)))
    (and (no-parent? box)
         (no-child? box)
         (null? (box-item box)))))

(define (front-deque deque)
  (if (empty-deque? deque)
    (error "FRONT called with an empty deque" (show-deque deque))
    (box-item (front-ptr deque))))

(define (rear-deque deque)
  (if (empty-deque? deque)
    (error "REAR called with an empty deque" (show-deque deque))
    (box-item (rear-ptr deque))))

(define (rear-insert-deque! deque item)
  (let ((new-box (make-box item '() '()))) ; could have used rear-ptr too
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-box)
           (set-rear-ptr! deque new-box)
           (show-deque deque))
          (else
            (let ((old-rear-box (rear-ptr deque)))
              (set-box-child! old-rear-box new-box)
              (set-box-parent! new-box old-rear-box)
              (set-rear-ptr! deque new-box)
              (show-deque deque))))))

(define (front-insert-deque! deque item)
  (let ((new-box (make-box item '() '())))
    (cond ((empty-deque? deque)
           (set-front-ptr! deque new-box)
           (set-rear-ptr! deque new-box)
           (show-deque deque))
          (else
            (let ((old-front-box (front-ptr deque)))
              (set-box-parent! old-front-box new-box)
              (set-box-child! new-box old-front-box)
              (set-front-ptr! deque new-box)
              (show-deque deque))))))

(define (rear-delete-deque! deque)
  (if (empty-deque? deque)
    (error "DELETE called with an empty deque" (show-deque deque))
    (begin
      (let ((new-rear-box (box-parent (rear-ptr deque))))
        (cond ((null? new-rear-box)
               (set-front-ptr! deque (make-empty-box))
               (show-deque deque))
              (set-box-child! new-rear-box '())
              (set-rear-ptr! deque new-rear-box)
              (show-deque deque))))))

(define (front-delete-deque! deque)
  (if (empty-deque? deque)
    (error "DELETE called with an empty deque" (show-deque deque))
    (let ((new-front-box (box-child (front-ptr deque))))
      (cond ((null? new-front-box)
             (set-front-ptr! deque (make-empty-box))
            (show-deque deque))
            (else
               (set-box-parent! new-front-box '())
               (set-front-ptr! deque new-front-box)
               (show-deque deque))))))

;; testing!
(define test (make-deque))
(empty-deque? test)
(front-insert-deque! test 'a)
(rear-insert-deque! test 'z)

(rear-delete-deque! test)
(front-delete-deque! test)

;; Chapter 2 was a simpler time where programs where programs were more
;; predictable.
