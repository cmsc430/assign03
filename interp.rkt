#lang racket
(provide (all-defined-out))
(require "ast.rkt")

;; Expr -> Integer
(define (interp e)
  (match e
    [(int-e i) i]
    [(add1-e e0)
     (+ (interp e0) 1)]
    [(sub1-e e0)
     (- (interp e0) 1)]
    [(if-e i t f)
     (if (zero? (interp i))
         (interp t)
         (interp f))]

    ;; TODO
    #;...
    [(cond-e (cons (clause i b) cs) f)
      (interp (if-e i b (cond-e cs f)))]))
