#lang racket
(provide interp-prim1)

;; Op Value -> Value
(define (interp-prim1 op v)
  (match op
    ['add1  (add1 v)]
    ['sub1  (sub1 v)]
    ['zero? (zero? v)]
    ;; TODO: Handle abs, -, and not
    ;; SOLN
    ['abs (abs v)]
    ;; SOLN
    ['- (- v)]
    ;; SOLN
    ['not (not v)]
    ))
