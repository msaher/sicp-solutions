#!/bin/guile -l
!#

; Exercise 2.84: Using the raise operation of Exercise 2.83,
; modify the apply-generic procedure so that it coerces its
; arguments to have the same type by the method of succes-
; sive raising, as discussed in this section. You will need to
; devise a way to test which of two types is higher in the
; tower. Do this in a manner that is “compatible” with the
; rest of the system and will not lead to problems in adding
; new levegls to the tower.

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

;; Bonus! I have noticed that both the `coerce` procedure of 2.82 and the
;; `highest-type` procedure of 2.84 look simillar, which means that they could
;; both be defined in terms of a common abstraction barrier.

;; By examing their from we can see that they accpet a list as an arguement, and
;; then run map with a procedure that involves the car on the whole list.
;; Finally it runs a predicate, on the resulting map list, and if it satisfies
;; it, we return the car, if not, we try again with the cdr.

(define (find-master seq map-op predicate?)
  (define (find-master-helper remaining)
    (if (null? remaining) (error "Fail")
      (let ((master (car remaining)))
        (let ((mapped-seq (map (lambda (somearg) (map-op master somearg))
                               seq)))
          (if (predicate? mapped-seq)
            master
            (find-master-helper (cdr remaining)))))))
    (find-master-helper seq))

;; Now we can define coerce and highest-type in terms of find-master

;; Could be faster if we don't use abstraction, but not as elegent. This is
;; mainly due to the fact that there's no clean to obtain the the master type of
;; a list of arguements without a some sort of tower data structure. This proves
;; the book's point that the `successive-raise` procedure makes apply-generic
;; sipmler. Another point is the fact that coerce args is not an "atmoic"
;; procedure, for it tries to find the master-type AND coerce all the
;; arguements. Unlike `successive-raise` which is atmoic. This means that
;; coerce is not as flexible, nor does it satisfy the unix philosophy.

(define (coerce args-list)
  (let ((master-type (find-master 
                       (map type-tag args-list)
                       (lambda (x y)
                         (if (eq? x y) (lambda (a) a)
                           (get-coercion y x)))
                       has-null?)))
    (map (lambda (somearg) (get-coercion (type-tag somearg) master-type))
         arg-list)))

(define (highest-type type-list)
  (find-master type-list
               (lambda (x y) (above? x y))
               (lambda (x) (not (has-false? x)))))

;; Since abstraciton is so magical, we can use for other things as well. For
;; instance to find the highest number in a list.
(define (highest-number numbers)
  (find-master numbers
               (lambda (master somearg) (>= master somearg))
               (lambda (x) (not (has-false? x)))))

;; This impelentaion of find-master is not as efficient as it could be, because
;; it runs the map-op on each element in the sequence, regardless of the
;; preceding sequence is any valid. However, since all other procedures we have
;; defined are sepereted by the find-master abstraction barrier, we can modify
;; find-master and everything will work out just fine.
