#lang racket
(provide interp)
(require "ast.rkt" "interp-prim.rkt")

;; type Value =
;; | Integer
;; | Boolean

;; Expr -> Value
(define (interp e)
  (match e
    [(Int i) i]
    [(Bool b) b]
    [(Prim1 p e)
     (interp-prim1 p (interp e))]
    [(If e1 e2 e3)
     (if (interp e1)
         (interp e2)
         (interp e3))]
    ;; TODO: Handle conditionals
    ;; SOLN
    [(Cond '() e) (interp e)]
    ;; SOLN
    [(Cond (cons (Clause p b) cs) e)
     (interp (If p b (Cond cs e)))]
    ))
