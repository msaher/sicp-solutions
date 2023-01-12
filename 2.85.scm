#!/bin/guile


;; add this to scheme-number package
  (put 'equ? '(scheme-number scheme-number) =)


;; add this to rational package
(put 'equ? '(rational rational) equ-rat?))


  ;; add this to polar package
  (define (equ-polar? a b)
    (and (equ? (magnitude a) (magnitude b))
         (equ? (angle a) (angle b))))

(put equ? '(polar polar) equ-polar?)

;; add this to rectangular package
(define (equ-rectangular? a b)
  (and (equ? (real-part a) (real-part b))
       (equ? (imag-part a) (imag-part b))))

(put equ? '(rectangular rectangular) equ-rectangular?)

;; add this to complex package
(define (equ-complex a b)
  (let ((polar? (lambda (x) (if (eq 'polar (type-tag x) #f))))) ; just to be faster
    (if (and (polar? a) (polar? b))
        ((get 'equ 'polar) a b) ; sure thing
        (and (equ? (real-part a) (real-part b))
             (equ? (imag-part a) (imag-part b))))))
                 
(put equ? '(compelx complex) equ-complex)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; any null in the list?
(define (has-null? seq)
  (memq '() seq))

;; does the list have any #f?
(define (has-false? seq)
  (memq #f seq)) 

;; are all elements of the list the same?
(define (all-same? seq)
  (cond ((null? seq) true)
        (else
          (let ((first (car seq)))
            (has-false?
              (map (lambda (somearg)
                     (eq? somearg first))))))))

;; tower procedures
(define (superiors x)
  (cdr (memq x (find-tower x)))) ; I'm assuming find-tower exists

(define (above? a-type b-type)
  (memq b-type (find-tower a-type)))

(define (next-type type)
  (car (superiors type)))

;; quick and drity
;;;;;;;;;;;;;;;;;;
(define (inferiors x)
  (cdr (memq x (reverse (find-tower x)))))

(define (prev-level x)
  (car (inferiors x)))
;;;;;;;;;;;;;;;;;;

(define (prev-type type)

;; be aware that raise takes a datum as input, not a tag
(define (raise datum)
  (let ((tag (type-tag datum)))
    ((get-coercion tag (next-type tag)) datum)))

;; successivly rises one arguement until it reaches the desired type
(define (successive-rise datum newtype)
  (if (eq? (type-tag datum) newtype) datum
      (successive-rise (rise datum) newtype)))

; find the highest tag in a list
(define (highest-type tag-list)
  (define (helper remaining)
    (cond ((null? remaining (error "Bad tags" tag-list)))
          (else
            (let ((master-tag (car remaining))
                  (all-true? (lambda (x) (not (has-false? x)))))
              (if (all-true?  (map (lambda (sometag) (above? master-tag sometag)
                                     tag-list)))
                master-tag
                (helper (cdr remaining))))))) ; try again
  (helper tag-list))

;; If types are not the same, and the procedure does not exist, then run
;; apply-generic on the coerced version of the args, which are obtained by
;; mapping successive-raise on each arguements till they reach the highest-type
;; in tag-list
(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (cond (proc (apply proc (map contents args)))
            ((all-same? type-tags)
             (error "No method for these types" (list op type-tags)))
            (else
              (let ((master-type (highest-type type-tags)))
                (let ((coerced-args (map (lambda (somearg)
                                           (successive-rise somearg master-type))
                                         args-list)))
                  (apply-generic op coerced-args))))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (project x)
  (apply-generic 'project x))

(put 'project '(complex) real-part)
(put-coercion 'real 'complex (lambda (x) (make-from-real-imag x 0)))

(put 'project '(real) round) ; into an integer
(put-coercion 'rational 'real (lambda (x) (/ (numer x) (denom x))))

(put 'project '(rational) numer)
(put-coercion 'integer 'rational (lambda (x) (make-rat x 1)))

; ;; drop works by seing if the successive projection and rasing of x is the same
;;; as x, if it is, then try again untill we can't make x any simpler.
(define (drop x)
  (let ((simpler-x (project x)))
    (if (equ? (raise (project x)) x)
      (drop (project x)) x)))


(define (apply-generic op . args)
  (let ((type-tags (map type-tag args)))
    (let ((proc (get op type-tags)))
      (cond (proc (drop (apply proc (map contents args)))) ;; diff: just added `drop`
            ((all-same? type-tags)
             (error "No method for these types" (list op type-tags)))
            (else
              (let ((master-type (highest-type type-tags)))
                (let ((coerced-args (map (lambda (somearg)
                                           (successive-rise somearg master-type))
                                         args-list)))
                  (apply-generic op coerced-args))))))))
