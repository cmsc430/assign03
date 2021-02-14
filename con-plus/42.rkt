#lang racket
(cond ((zero? 42) 0)
      ((zero? 0) (abs (- 42)))
      (else 17))
