(define (make-serializer)
  (let ((mutex (make-mutex)))
    (lambda (p)
      (define (serialized-p . args)
        (mutex 'acquire)
        (let ((val (apply p args)))
          (mutex 'release)
          val))
      serialized-p)))

;; when mutex is false, it means it is available 
(define (make-mutex)
  (let ((cell (list false)))
    (define (the-mutex m)
      (cond ((eq? m 'acquire)
             (if (test-and-set! cell)
               (the-mutex 'acquire))) ; retry
            ((eq? m 'release) (clear! cell))))
    the-mutex))

(define (clear! cell) (set-car! cell false))

(define (test-and-set! cell)
(if (car cell) true (begin (set-car! cell true) false)))

;;; four implementation

;; 1 a
(define (make-semaphore n)
  (let ((mutex (make-mutex))
        (free n))

    (define (acquire)
      (mutex 'acquire)
      (if (= free 0)
        (begin
          (mutex 'release)
          (acquire))
        (begin 
          (set! free (- free 1))
          (mutex 'release))))

    (define (release)
      (mutex 'acquire)
      (if (not (= free n))
        (set! free (+ free 1)))
      (mutex 'release))

    (define (the-semaphore m)
      (cond ((eq? m 'acquire) (acquire))
            ((eq? m 'release) (release))))))

;; 1 b
(define (make-semaphore n)
  (let ((free n)
        (cell (list false)))

    (define (acquire)
      (if (test-and-set! cell)
        (acquire)
        (begin
          (if (= free 0)
            (set! free (- free 1))
            (begin
              (clear! cell)
              (acquire))))))

    (define (release)
      (if (test-and-set! cell)
        (release)
        (begin 
          (if (not (= free n))
            (set! free (+ free 1)))
          (clear! cell))))

    (define (the-semaphore m)
      (cond ((eq? m 'acquire) (acquire))
            ((eq? m 'release) (release))))))

;;; 1 a
(define (make-semaphore n)
  (define (make-mutexes n)
    (if (= n 0) '()
      (cons (make-mutex)
            (make-mutexes (- n 1)))))

  (let ((all-mutexes (make-mutexes n))
        (serializer (make-serializer)))
    (let ((free-mutexes all-mutexes))

      (define (acquire)
        (let ((mutex (car (free-mutexes))))
          (mutex 'aquire)
          (set! free-mutexes (cdr free-mutexes))))

      (define (release)
        (let ((mutex (car all-mutexes)))
              (mutex 'release)
              (if (not (memq mutex free-mutexes))
                (set! free-mutexes
                  (cons mutex free-mutexes)))))

      (define (the-semaphore m)
        (cond ((eq? 'aquire)) ((serializer aquire))
              ((eq? 'release)) ((serializer release))))
        the-semaphore)))

;;; 2 b
(define (make-semaphore n)
  (define (make-cells n)
    (if (= n 0) '()
      (cons (list false) (make-cells (- n 1)))))

  (let ((cell-list (make-cells n)))
    (let ((free-cells cell-list))

    (define (acquire)
      (define (iter sub-cell-list)
        (if (null? sub-cell-list)
          (iter cell-list)
          (let ((cell (car (sub-cell-list))))
            (if (test-and-set! cell)
              (iter (cdr sub-cell-list)))))) ; retry next
      (iter cell-list))

    (define (release)
      (clear! (caar cell-list)))
