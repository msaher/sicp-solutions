#lang racket


(define (sqrt-stream x)
  (define guesses
    (cons-stream
      1.0
      (stream-map (lambda (guess) (sqrt-improve guess x))
                  guesses)))
  guesses)

; (1 (stream-map (lambda (guess) (sqrt-improve guess x)) guesses)
; (1 (stream-map (lambda (guess) (sqrt-stream guess x)) (1 ... )))
; --> the guesses will be (1 (delay 1) with delay not evaluated
; yet. In the next iteration the delay will be called, and the value of
; that delay will stored for the next itertation due to memoization


(define (sqrt-stream x)
  (cons-stream 1.0 (stream-map
                     (lambda (guess)
                       (sqrt-improve guess x))
                     (sqrt-stream x))))

; (1 (stream-map (lambda (guess) (sqrt-improve guess x)) (sqrt-stream x))
; (1 (stream-map (lambda (guess) (sqrt-stream guess x)) (1 ... )))
; --> the result will be (1 (delay 1)) with delay not evaluated. In the
; next itertation we will call *another* (sqrt-improve x) which is a
; different entitiy with its own delays that are not actually evaluated.
; No memoization in this case so its way less efficient.



;; when expanding, notice that the only difference is that we have
;; (cons-stream ... guesses) vs (cons-stream ... (sqrt-improve x)
;; Notice that guesses is a stream, while (sqrt-stream x) is a
;; procedure that *returns* a stream. Each (sqrt-stream x) call will
;; actually generate the whole stream again without memoization
;; because the delays are different entities


