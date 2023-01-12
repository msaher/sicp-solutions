;;; a

(define x 10)
(parallel-execute (lambda () (set! x (* x x))) ; p1
                  (lambda () (set! x (* x x x)))) ;p2

;; p1 reads x, reads x, sets x to 100, p2 reads x reads x
;; reads x to get 1,000,000 (million)

;; p2 reads x, p2 reads x, p2 reads x, p2 sets x to 1,000, p1
;; reads x, reads x to get 1,000,000 (million)

;; p1 reads x, p1 reads x, p2 sets x to 1000, p1 sets x to 100

;; p2 reads x, p2 reads x, p2 reads x, p1 sets x to 100, p2 sets x to 1,000

;; p1 reads x, p2 reads x, p2 sets x to 1000, p1 reads x, p1 sets x to 10,000

;; p2 reads x, p2 reads x, p1 reads x, p1 sets x to 100, p2 reads x, p2 sets x
;; to 10,000

;; p2 reads x, p1 sets x to 100, p2 reads x, p2 reads x, p2 sets x to 100,000

;;; b

(define x 10)
(define s (make-serializer))
(parallel-execute (s (lambda () (set! x (* x x)))) ; p1
                  (s (lambda () (set! x (* x x x))))) ; p2

;; p1 reads x, reads x, sets x to 100, p2 reads x reads x
;; reads x to get 1,000,000 (million)

;; p2 reads x, p2 reads x, p2 reads x, p2 sets x to 1,000, p1
;; reads x, reads x to get 1,000,000 (million)
