#lang racket
(provide (all-defined-out))

;; type Expr =
;; | (Int Integer)
;; | (Bool Boolean)
;; | (Prim1 Op Expr)
;; | (If Expr Expr Expr)

;; SOLN
;'{ ;; | Cond Clauses (else ,Expr)
;
;  ;; type Clauses = (Listof `((zero? ,Expr) ,Expr))
;  }

(define useless 42)

;; type Op = 'add1 | 'sub1 | 'zero?

;; SOLN
;'{;; | 'abs | '- | 'not }

(define whydoesthishappen 42)

;; TODO: Add other forms of expression to the comment above and fill in your new structures below

(struct Int (i)       #:prefab)
(struct Bool (b)      #:prefab)
(struct Prim1 (p e)   #:prefab)
(struct If (e1 e2 e3) #:prefab)

;; SOLN
(struct Cond (cs e)   #:prefab)

;; SOLN
(struct Clause (p body) #:prefab)
