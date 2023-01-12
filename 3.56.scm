(define s (cons-stream 1
                       (merge (stream-scale s 2) (merge (stream-scale s 3)
                                                        (stream-scale s 5)))))
