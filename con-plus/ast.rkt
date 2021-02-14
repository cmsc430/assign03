#lang racket
(provide (all-defined-out))

;; type Expr =
;; | (Int Integer)
;; | (Prim1 Op Expr)
;; | (IfZero Expr Expr Expr)
;; SOLN
;'{ ;; | Cond Clauses (else ,Expr)
;
;  ;; type Clauses = (Listof `((zero? ,Expr) ,Expr))
;  }

(define useless 42)

;; type Op = 'add1 | 'sub1

;; SOLN
;'{;; | 'abs | '-}

(define whydoesthishappen 42)

;; TODO: Add other forms of expression to the comment above and fill in your new structures below

(struct Int (i)           #:prefab)
(struct Prim1 (p e)       #:prefab)
(struct IfZero (e1 e2 e3) #:prefab)
;; SOLN
(struct Cond (cs e)       #:prefab)

;; SOLN
(struct Clause (i body) #:prefab)

