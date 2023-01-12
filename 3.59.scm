;;; a
;; 1 1/2 1/3 ...
(define fracs
  (stream-map (lambda (x) (/ 1 x))
              integers))

(define (integrate-series s)
  (stream-multiply fracs s))

;;; b

;; cosine
(define cosine-series
  (cons-stream 1 (stream-scale -1 (integerate-series sin-series))))

;; sine
(define sine-series
  (cons-stream 0 (integrate-series cos-series)))
