#!/bin/guile -l
!#

;; vectors
(define make-vect cons)

(define xcor-vect car)
(define ycor-vect cdr)

;; nah
; (define (add-vect v u)
;   (make-vect
;     (+ (xcor-vect v)
;        (xcor-vect u))
;     (+ (ycor-vect v)
;        (ycor-vect u))))

(define (art-vect op)
  (lambda (v u)
    (make-vect
    (op (xcor-vect v)
       (xcor-vect u))
    (op (ycor-vect v)
       (ycor-vect u)))))

(define add-vect (art-vect +))  
(define sub-vect (art-vect -))  

(define (scale-vect k v)
  (make-vect
    (* k (xcor-vect v))
    (* k (ycor-vect v))))

;;; Frames from 2.47 A
(define (make-frame origin edge1 edge2)
  (list origin edge1 edge2))
 
(define (origin-frame frame)
  (car frame))

(define (edge1-frame frame)
  (cadr frame))

(define (edge2-frame frame)
  (caddr frame))

;; segments
(define make-segment cons)
(define start-segment car)
(define end-segment cdr)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (segments->painter segment-list)
  (lambda (frame)
    (for-each
     (lambda (segment)
       (draw-line
	((frame-coord-map frame)
	 (start-segment segment))
	((frame-coord-map frame)
	 (end-segment segment))))
    segment-list)))

;; A) painter that draws outline of frame
(define outline
  (let ((0c0 (make-vect 0 0))
        (0c1 (make-vect 0 1))
        (1c0 (make-vect 1 0))
        (1c1 (make-vect 1 1)))
    (segments->painter (list
                         (make-segment 0c0 0c1)
                         (make-segment 0c1 1c1)
                         (make-segment 1c1 1c0)
                         (make-segment 1c0 0c0)))))

;; B) painter that draws an X
(define eks
  (let ((0c0 (make-vect 0 0))
        (0c1 (make-vect 0 1))
        (1c0 (make-vect 1 0))
        (1c1 (make-vect 1 1)))
    (segments->painter (list
                         (make-segment 0c0 1c1)
                         (make-segment 0c1 1c0)))))


;; C) Diamond painter
(define diamond
  (let ((h (make-vect 0 0.5)) ;; warning names only make sense if you know vi
        (j (make-vect 0.5 0))
        (k (make-vect 0.5 0.5))
        (l (make-vect 1 0.5)))
    (segments->painter (list
                         (make-segment h k)
                         (make-segment k l)
                         (make-segment l j)
                         (make-segment j h)))))

;; D) wave painter has curves. I'm not sure if am I supposed to define a
;; procedure that makes curves or if this is some kind of cruel joke. I copied
;; this from http://community.schemewiki.org/?sicp-ex-2.49

(define wave 
   (segments->painter (list 
                       (make-segment (make-vect .25 0) (make-vect .35 .5)) 
                       (make-segment (make-vect .35 .5) (make-vect .3 .6)) 
                       (make-segment (make-vect .3 .6) (make-vect .15 .4)) 
                       (make-segment (make-vect .15 .4) (make-vect 0 .65)) 
                       (make-segment (make-vect 0 .65) (make-vect 0 .85)) 
                       (make-segment (make-vect 0 .85) (make-vect .15 .6)) 
                       (make-segment (make-vect .15 .6) (make-vect .3 .65)) 
                       (make-segment (make-vect .3 .65) (make-vect .4 .65)) 
                       (make-segment (make-vect .4 .65) (make-vect .35 .85)) 
                       (make-segment (make-vect .35 .85) (make-vect .4 1)) 
                       (make-segment (make-vect .4 1) (make-vect .6 1)) 
                       (make-segment (make-vect .6 1) (make-vect .65 .85)) 
                       (make-segment (make-vect .65 .85) (make-vect .6 .65)) 
                       (make-segment (make-vect .6 .65) (make-vect .75 .65)) 
                       (make-segment (make-vect .75 .65) (make-vect 1 .35)) 
                       (make-segment (make-vect 1 .35) (make-vect 1 .15)) 
                       (make-segment (make-vect 1 .15) (make-vect .6 .45)) 
                       (make-segment (make-vect .6 .45) (make-vect .75 0)) 
                       (make-segment (make-vect .75 0) (make-vect .6 0)) 
                       (make-segment (make-vect .6 0) (make-vect .5 .3)) 
                       (make-segment (make-vect .5 .3) (make-vect .4 0)) 
                       (make-segment (make-vect .4 0) (make-vect .25 0)) 
                       ))) 
