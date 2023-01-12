(define (squarer a b)
  (define (process-new-value)
    (if (has-value? b)
      (if (< (get-value b) 0)
        (error "square less than 0: SQUARER"
               (get-value b))
        (set-value! a (sqrt b) me)) ; alternative1
        (if (has-value? a) (set-value! b (square a) me)))) ; alternative2
  (define (process-forget-value) ; body1
    (forget-value! a me)
    (forget-value! b me)
    (process-new-value))
    (define (me request)
      (cond ((eq? request 'I-have-a-value) (process-new-value))
            ((eq? request 'I-lost-my-value) (process-forget-value))
            (else (error "Unknown request: SQUARER"
                         request))))
    (connect a me) ; body 2
    (connect b me)
  me)
