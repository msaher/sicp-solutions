(define x 10)
(define s (make-serializer))
(parallel-execute
  (lambda () (set! x ((s (lambda () (* x x)))))) ; p1
  (s (lambda () (set! x (+ x 1))))) ; p2

;; combinations:

;; p2 sets x to 11, p1 sets x to 121
;; p1 sets x to 100, p2 sets x to 101
;; p1 accesses x, p2 starts, then p1 sets x to 100


;;; I saw this on the sicp wiki, but I don't agree with it.

;; p1 accesses x, p2 accesses x, p1 sets x to 100, p2 sets x to 11

;; the reasoning is that because p1 is not serialized, it can interfere with
;; serialized procedures, but I don't think that's true
