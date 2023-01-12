(load "queue.scm")

;; Lisp does not understand what a queue it is. To the interpreter, a queue is
;; but a list whose car is the sequence of items, and whose cadr is the last
;; pair of that sequence. insert-queue! updates the rear pointer (which is the
;; cadr) of that list. However, delete-queue! does not do so, bcause that
;; wouldn't be useful. Infact, when the last queue is deleted, you get a list
;; whose car is an empty list and whose cdr the last element before you ran
;; delete-queue!. That's quite normal

;; As for a print-queue procedure, you can simply just diplay the front pointer
;; of the queue. We only keep track of the last pair for efficiency reasons.

(define (print-queue q)
  (display (front-ptr q)))
