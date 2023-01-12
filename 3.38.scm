;;; a

;; peter, paul, mary = 45
;; peter, mary, paul = 35

;; paul, peter, mary = 45
;; paul, mary, peter = 50

;; mary, paul, peter = 40
;; mary, peter, paul = 40

;;; b

;; if allow interleaving we could overwrite and practically ignore up to two
;; transactions. Some possible combinations (some are repeated)

;; ignore peter:
                ;; ignore no one else
                        ;; mary, paul = 30
                        ;; paul, mary = 40

                ;; ignore paul
                        ;; mary = 50

                ;; ignore mary
                        ;; paul = 80

;; ignore paul
                ;; ignore no one else
                        ;; peter, mary = 55
                        ;; mary, peter = 60

                ;; ignore peter
                        ;; mary = 50

                ;; ignore mary
                        ;; peter = 110

;; ignore mary:
                ;; ignore no one else
                        ;; peter, paul = 90
                        ;; paul, peter = 90
                ;; ignore peter
                        ;; peter = 80
                ;; ignore paul
                        ;; peter = 110

;; notice how mary sets balance to (- balance (/ balance 2)). This is critical
;; as it implies that the first balance may not necessarily be equal to the
;; second balance, which allows us even more combinations
