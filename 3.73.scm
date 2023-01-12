#lang racket

(require "streams.scm")



;; we start with v0 so we cons it first
 (define (RC r c dt) 
   (define (voltages v0 i)
     (cons-stream v0
                  (add-streams (integral (stream-scale i (/ 1 c)) 0 dt)
                               (add-streams (stream-scale ones v0) ; add v0s
                                            (stream-scale i r)))))
   voltages)


(define rc1 (RC 5 1 0.5))

(define z (rc1 0 integers))

(stream-ref z 0)
(stream-ref z 1)
(stream-ref z 2)
(stream-ref z 3)
(stream-ref z 4)
