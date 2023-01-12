(define sum 0)

(define (accum x) (set! sum (+ x sum)) sum)

;; this will set sum to 1, and return
;; (1 (stream-map accum (stream-enumerate-interval 2 20)))
(define seq
  (stream-map accum
              (stream-enumerate-interval 1 20)))

;; this will add 2 to sum to get sum=3, and return
;; (3 (stream-filter even? (stream-map accum (stream-enumerate-interval 3 20 ))
(define y (stream-filter even? seq))

(stream-filter even? (1 (stream-map accum (stream-enumerate-interval 2 20)))
(stream-filter even? (2 (stream-map accum (stream-enumerate-interval 3 20))))
(3 (stream-map accum (stream-enumerate-interval 4 20))) 


;; this will add 3, 4, 5 to sum sum=15, and return
;; (5 (stream-filter (lambda (x) (= (reaminder x 5)) 0)
;;                   (stream-filter 6 20)))
(define z
  (stream-filter (lambda (x) (= (remainder x 5) 0))
                 seq))

;; this will add 6 to get sum=21 and return 6
(stream-ref y 7)

;; this will add the rest of the numbers after 6 to get sum=210
(display-stream z)
