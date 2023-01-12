#!/bin/guile -l
!#

(define (transform-painter painter origin corner1 corner2)
  (lambda (frame)
    (let ((m (frame-coord-map frame)))
      (let ((new-origin (m origin)))
        (painter (make-frame
                   new-origin
                   (sub-vect (m corner1) new-origin)
                   (sub-vect (m corner2) new-origin)))))))

; (define (flip-vert painter)
;   (transform-painter painter
;                      (make-vect 0 1) ; new origin
;                      (make-vect 1 1) ; new end of edge1
;                      (make-vect 0 0))) ; new end of edge2

(define (flip-horz painter)
  (transform-painter painter
                     (make-vect 1 0) ; new origin
                     (make-vect 0 0) ; new edge1
                     (make-vect 1 1) ; new edge2
                     ))

(define (rotate180 painter)
  (transform-painter painter
                     (make-vect 0 1) ; new origin
                     (make-vect 0 0) ; new edge1
                     (make-vect 1 1) ; new edge2
                     ))

(define (rotate270 painter)
  (transform-painter painter
                     (make-vect 1 1) ; new origin
                     (make-vect 1 0) ; new edge1
                     (make-vect 0 1) ; new edge2
                     ))

; (define (beside painter1 painter2)
;   (let ((split-point (make-vect 0.5 0.0)))
;     (let ((paint-left
;             (transform-painter
;               painter1
;               (make-vect 0.0 0.0)
;               split-point
;               (make-vect 0.0 1.0)))
;           (paint-right
;             (transform-painter
;               painter2
;               split-point
;               (make-vect 1.0 0.0)
;               (make-vect 0.5 1.0))))
;       (lambda (frame)
;         (paint-left frame)
;         (paint-right frame)))))
; Observe how the painter data abstraction, and in particular the repre-

(define (below painter1 painter2)
  (lambda (frame)
    (let ((split-point (make-vect 0 0.5)))
      (let ((paint-up
              (transform-painter
                painter2
                split-point
                (make-vect 1 0.5)
                (make-vect 0.5 1))))
        (paint-down
          (transform-painter
            painter1
            (make-vect 0 0)
            (make-vect 1 0)
            split-point)))))
  (painder-down frame)
  (painter-up frame))
