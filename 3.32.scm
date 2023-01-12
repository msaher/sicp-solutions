;; Suppose we have a1 a2 be 0, 1 respectively. when we mainain the order using
;; queues, the following will happen:

;; change signal a1 1
;; first. and-gate output change added to agenda (set-signal! output 1)
;; change signal a12 0
;; second. and-gate output change added to agenda (set-signal! output 0)

;; With queues, first will run, then second, giving us 0 (correct)
;; With lists, second would run then first, giving us 1 (incorrect)

;; With lists, things happen bacwards, which does not make sense
