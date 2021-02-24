#lang racket
(provide (all-defined-out))

;; type Expr =
;; | (Int Integer)
;; | (Prim1 Op Expr)
;; | (IfZero Expr Expr Expr)

;; type Op = 'add1 | 'sub1
;; type Op = 'abs | '- 

;; TODO: Add other forms of expression to the comment above and fill in your new structures below

;; There will be an IfZero statement where e1 is checking if it is zero. If true, then e2 otherwise e3
;; There can also be a Prim1 expression where it has an operator and an expression afterwards.
  ;; expression 1: abs. Gets absolute value of the expression.
  ;; expression 2: - . Flips sign of expression. + -> (-) && (-) -> +
;; Expressions can be an Integer represented by i.
;; Example: (IfZero (- 0) (abs (- 36)) 45)
  ;; Answer: 36 because -0 is true therefore is it the absolute value of -36 which is 36.

(struct Int (i)           #:prefab)
(struct Prim1 (p e)       #:prefab)
(struct IfZero (e1 e2 e3) #:prefab)


