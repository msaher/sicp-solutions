#lang racket

(define (random-in-range low high) 
   (let ((range (- high low))) 
     (+ low (* (random) range)))) 

(define (monte-carlo trials experiment)
  (define (iter trials-remaining trials-passed)
    (cond ((= trials-remaining 0)
           (/ trials-passed trials))
          ((experiment)
           (iter (- trials-remaining 1)
                 (+ trials-passed 1)))
          (else
            (iter (- trials-remaining 1)
                  trials-passed))))
  (iter trials 0))

(define (estimate-integral P x1 x2 y1 y2 trials)

  (define (experiement)
    (P (random-in-range x1 x2)
       (random-in-range y1 y2)))

  (let ((distance-in-x (abs (- x2 x1)))
        (distance-in-y (abs (- y2 y1))))

  (let ((area (* distance-in-x distance-in-y))
        (percentage (monte-carlo trials experiement)))

    (* percentage area)))) ;; that's the integral

(define (estimate-pi trials) 

  (define (in-circle? x y)
    (<= (+ (* x x) (* y y)) 1))

  ;; unit circle sourrounded by a 2x2 square
  (estimate-integral in-circle? -1 1 -1 1 trials))

;; testing
(estimate-pi 1000000.0)
