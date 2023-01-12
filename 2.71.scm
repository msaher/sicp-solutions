#!/bin/guile -l
!#

(load "2.68.scm")
(load "2.69.scm")

(define mytree (generate-huffman-tree
  '(
    (a 1)
    (b 2)
    (c 4)
    (d 8)
    (e 16)
    (f 32)
    (g 64)
    (h 128)
    (i 256)
    (j 512))))

(encode '(j) mytree)

;; Number of bits for most frequenet is 1
;; Number of bits for least frequenet is n-1

;; bonus: showing off my vim skills

(define haha (generate-huffman-tree
               '(
                 (a 1)
                 (b 2)
                 (c 4)
                 (d 8)
                 (e 16)
                 (f 32)
                 (g 64)
                 (h 128)
                 (i 256)
                 (j 512)
                 (k 1024)
                 (l 2048)
                 (m 4096)
                 (n 8192)
                 (o 16384)
                 (p 32768)
                 (q 65536)
                 (r 131072)
                 (s 262144)
                 (t 524288)
                 (u 1048576)
                 (v 2097152)
                 (w 4194304)
                 (x 8388608))))

                 ; (y 1.677722e7) ; those don't count! 
                 ; (z 3.355443e7) ; those don't count! 
