!#/bin/guile -l
#!

(define (cc amount coin-values)
  (define (no-more? x)
    (= (length x) 0))
  (define (except-first-denomination x)
    (cdr x))
  (define (first-denomination x)
    (car x))
  (cond ((= amount 0) 1)
        ((or (< amount 0) (no-more? coin-values)) 0)
        (else
          (+ (cc amount
                 (except-first-denomination
                   coin-values))
             (cc (- amount
                    (first-denomination
                      coin-values))
                 coin-values)))))

;; test
(cc 10 (list 25 50 10 5 1))

;; Does the order matter?
        ;; No, since the program goes through every possiblity. So even
        ;; if an element is pushed to the next spot. `cc` will still go
        ;; through it, but it will do it later. 

;; Old program
(define (count-change amount) (cc amount 5))
(define (cc amount kinds-of-coins)
  (cond ((= amount 0) 1)
        ((or (< amount 0) (= kinds-of-coins 0)) 0)
        (else (+ (cc amount
                     (- kinds-of-coins 1))
                 (cc (- amount
                        (first-denomination
                          kinds-of-coins))
                     kinds-of-coins)))))
(define (first-denomination kinds-of-coins)
  (cond ((= kinds-of-coins 1) 1)
        ((= kinds-of-coins 2) 5)
        ((= kinds-of-coins 3) 10)
        ((= kinds-of-coins 4) 25)
        ((= kinds-of-coins 5) 50)))
