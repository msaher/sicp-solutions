(define (make-interval a b) (cons a b))

(define (lower-bound x)
  (car x))

(define (upper-bound x)
  (cdr x))


(define (add-interval x y)
  (make-interval (+ (lower-bound x) (lower-bound y))
		 (+ (upper-bound x) (upper-bound y))))

(define (mul-interval x y)
  (let ((p1 (* (lower-bound x) (lower-bound y)))
	(p2 (* (lower-bound x) (upper-bound y)))
	(p3 (* (upper-bound x) (lower-bound y)))
	(p4 (* (upper-bound x) (upper-bound y))))
    (make-interval (min p1 p2 p3 p4)
		   (max p1 p2 p3 p4))))

(define (make-center-width c w)
  (make-interval (- c w) (+ c w)))

(define (center i)
  (/ (+ (lower-bound i) (upper-bound i)) 2))
(define (width i)
  (/ (- (upper-bound i) (lower-bound i)) 2))

(define (make-center-percent c p)
  (make-center-width c (* p c)))

(define (percent i)
  (/ (width i) (center i)))

(define (div-interval x y)
  (mul-interval
    x
    (make-interval (/ 1.0 (upper-bound y))
		   (/ 1.0 (lower-bound y)))))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (par1 r1 r2)
  (div-interval (mul-interval r1 r2)
		(add-interval r1 r2)))

(define (par2 r1 r2)
  (let ((one (make-interval 1 1)))
    (div-interval
      one (add-interval (div-interval one r1)
			(div-interval one r2)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (display-pair x y)
  (display "(")
  (display x)
  (display ", ")
  (display y)
  (display ")"))

(define (display-interval x)
  (display "        In normal form:   ")
  (display-pair (lower-bound x) (upper-bound x))
  (newline)
  (display "In center-percent form:   ")
  (display-pair (center x) (percent x)))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; Obeservations:

; 1. The result of dividing an interval by itself is a new interval written as
; a function of the percent of the original interval (1-p/1+p , 1+p/1-p) Or (x/y , y/x). (I'm
; assuming that it is a postive-postive interval). 

; 2. The idenitiy interval is some interval (a,b) such that for all intervals
; (x,y). (x,y)*(a,b) = (x,y). Does the identity really exist? Yes (1,1)

; 3. 

; 4. Since A/A or (1,1) / A does not produce the identity. It can not be used
; to manipluate algebric expressions. 

; 5. What Lem has done to find the "equivelent" form is to multiply the numerator
; and the denominatory by R2R1/R2R1 = A/A as if This was the identity, but it isn't


;;; Bunch of tests. Ignore them. 
(define (recp-interval x)
  (make-interval (/ 1.0 (upper-bound x))
		 (/ 1.0 (lower-bound x))))

(define r1 (make-center-percent 10 0.0002))
(define r2 (make-center-percent 5 0.0002))

(display-interval (par1 r1 r2))

(display-interval (par2 r1 r2))

(display-interval (div-interval r2 r2))



(display-interval (div-interval r1 r1))

(display-interval r1)

(display-interval (mul-interval r1 (div-interval r1 r1)))

(display-interval (div-interval r1 r2))
