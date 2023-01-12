;; I think It's fine. The difference is that each bank has it's own sterilizer.
;; That is, calls to the local withdraw and deposit in a bank are ordered, the
;; previous implementation had a similar result (withdraw and deposit were
;; ordered), but individual calls to deposit and withdraw were sterilized. This
;; is a slight difference, but it does not effect the result
