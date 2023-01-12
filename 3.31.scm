;; Let's say you have wire a, b both with signal 1. You also have c with signal
;; 0
;; assume you run (and-gate a b c).

;; If the add-action! only ran the procedure when the signal changes, then c
;; will continue to be 0. which does not make sense.
