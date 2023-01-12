;; (p or q ) = ~(~p and ~q)
(define (or-gate p q output)
  (let ((notp (make-wire))
        (notq (make-wire))
        (not-output (make-wire)))
    (inverter p notp)
    (inverter q notq)
    (and-gate notp notq not-output)
    (inverter not-output output))
  'ok)
  
;; or-delay will be sum of and-delay and 2 invert-delay
