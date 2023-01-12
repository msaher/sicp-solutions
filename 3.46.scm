;; assumme that A reads the state of the mutex as true, then before changing it
;; to false, B reads it as true, and then both A and B sets it to true. Now both
;; A and B have aquired the mutex. This is a chicken or an egg problem
