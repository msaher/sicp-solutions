(fact n)

parameters: n
enclosing enviorment: global
value: (if (= n 1) 1 (* n fact (- n 1)))

--------------------------------------------------------------------------------

(fact 6)
E1: [ n:6 ]
(* 6 (fact 5))

;;;;;;;;;;;;;;;;;;;

(fact 5)
E2: [ n:5 ]
(* 5 (fact 4))

;;;;;;;;;;;;;;;;;;;

(fact 4)
E3: [ n:4 ]
(* 4 (fact 3))

;;;;;;;;;;;;;;;;;;;

(fact 3)
E4: [ n:3 ]
(* 3 (fact 2))

;;;;;;;;;;;;;;;;;;;

(fact 2)
E5: [ n:2 ]
(* 2 (fact 1))

;;;;;;;;;;;;;;;;;;;

(fact 1)
E6: [ n:1 ]
1

;; The second is also simillar. 
