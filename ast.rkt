#lang racket
(provide (all-defined-out))
;; type Expr =
;; | Integer
;; | add1 Expr
;; | sub1 Expr
;; | if (zero? ,Expr) Expr Expr

;; TODO: Add other forms of expression to the comment above

(struct int-e (i) #:transparent)
(struct add1-e (e) #:transparent)
(struct sub1-e (e) #:transparent)
(struct if-e (i t f) #:transparent)
(struct abs-e  (e) #:transparent)
(struct neg-e  (e) #:transparent)
(struct cond-e (cs el) #:transparent)

(struct clause (i body) #:transparent)

(define (ast->sexpr a)
  (match a
    [(int-e i)    `(int-e ,i)]
    [(add1-e e)   `(add1-e ,(ast->sexpr e))]
    [(sub1-e e)   `(sub1-e ,(ast->sexpr e))]
    [(if-e i t f) `(if-e (zero? ,(ast->sexpr i))
                         ,(ast->sexpr t)
                         ,(ast->sexpr f))]
    [(abs-e e)     `(abs-e ,(ast->sexpr e))]
    [(neg-e e)     `(neg-e ,(ast->sexpr e))]
    [(cond-e cs f) `(cond-e ,(clauses->sexpr cs) ,(ast->sexpr f))]))

(define (clauses->sexpr cs)
  (match cs
    ['() '()]
    [(cons (clause i b) cs) `(((zero? ,i) ,b) ,@(clauses->sexpr cs))]))
