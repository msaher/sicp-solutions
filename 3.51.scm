(define (display-line x)
  (newline)
  (display x))

(define (show x)
(display-line x)
x)

(define x
  (stream-map show
              (stream-enumerate-interval 0 10)))
;; this will print 0 only.
;; because it evaluates into
;;      (cons (shown 0) ;; shown means show ran already
;;              (stream-enumerate-interval 1 10)) ;; promise to run later
;;              

;; we practically have the stream (0 1 2 3 4 5 6 7 8 9 10), such that the car of
;; shown already because calling cdr is what applies show. In this case 0 has
;; already been shown

;; will not show 0, will show 1 2 3 4 5 and return 5
(stream-ref x 5)

;; will not show 0, will show 6 7 and return 7. This is because (delay proc)
;; will try to remember the return values of procedures it ran before. So show
;; will not run for 1 2 3 4 5 because it ran previously when we evaluated
;; (stream-ref x 5)
(stream-ref x 7)
