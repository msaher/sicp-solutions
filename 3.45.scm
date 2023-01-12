;; the procedure will never run. If you have a s1s2 serializer, and you run a
;; procedure inside of it that has an s1 serialized procedure, then s1 running
;; that procedure is the equievelent of interrupting s1s2, which is impossible,
;; meaning that the exchange procedure will never run
