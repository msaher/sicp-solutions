;; That's because of normal order evaluation. This is a tree recursive
;; call. If you call it with some input, it will produce two nodes,
;; which will produce 4 nodes, and so on. The procedure grows
;; exponentially, but since its originally a logarithimic procedure,
;; it will be reduce to O(n)
