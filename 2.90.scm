(define (install-dense-term-list)

;; List the term, and find the order
(define (first-term term-list)
  (list 
    (car term-list) ; first term
    (- 1 (length term-list)))) ; order is length-1 (we index polynomials from 0)

;; Slightly modified to cons the coeff instead of the actual term
(define (adjoin-term term term-list)
  (let ((coeff-of-term (coeff term)))
    (if (=zero? coeff-of-term)
      term-list
      (cons coeff-of-term term-list))))

(define (rest-terms term-list) (cdr term-list))

(define (tag term-list) (attach-type 'dense-list x))
(put 'first-term '(dense-list) first-term)
(put 'adjoing-term '(dense-list) adjoin-term)

(put 'rest-terms '(dense-list) 
     (lambda (term-list) (tag (rest-terms term-list)))))


;; sparse
(define (install-sparse-term-list)

(define (first-term term-list)
  (car (term-list)))

(define (rest-terms) (cdr term-list))

(define (adjoin-term term term-list)
  (if (=zero? coeff-of-term)
    term-list
    (cons term term-list)))

(define (tag term-list) (attach-type 'sparse-list x))
(put 'first-term '(sparse-list) first-term)
(put 'adjoing-term '(sparse-list) adjoin-term)

(put 'rest-terms '(sparse-list) 
     (lambda (term-list) (tag (rest-terms term-list)))))

(define (first-term term-list)
  (apply-generic 'first-term (type-tag term-list) term-list))

(define (rest-terms term-list)
  (apply-generic 'rest-terms (type-tag term-list) term-list))

(define (adjoin-term term term-list)
  (apply-generic 'adjoin-term (type-tag term-list) term term-list))
