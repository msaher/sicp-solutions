;; rand-update does not actually exist

; (define rand
;   (let ((x random-init))
;     (lambda ()
;       (set! x (rand-update x))
;       x)))

(define (rand random-init)
  (define (dispatch m)
                    (cond ((eq? m 'generate)
                           (set! random-init (rand-update random-init))
                           random-init)
                          ((eq? 'reset)
                           (lambda (new-init)
                             (set! random-init new-init)))))
  dispatch)
