#lang racket
(provide (all-defined-out))
(require "ast.rkt")

;; Any -> Boolean
;; Is x a well-formed expression?
(define (expr? x)
  (match x
    [(? integer? i) #t]
    [`(add1 ,x) (expr? x)]
    [`(sub1 ,x) (expr? x)]
    [`(if (zero? ,x) ,y ,z)
     (and (expr? x)
          (expr? y)
          (expr? z))]
    [`(abs ,x) (expr? x)]
    [`(- ,x) (expr? x)]
    [(list 'cond `((zero? ,xs) ,ys) ... `(else ,z))
     (and (andmap expr? xs)
          (andmap expr? ys)
          (expr? z))]
    ;; TODO
    [_ #f]))

; SExpr -> AST
; convert the s-expr into our AST
; This should be a one-to-one mapping for now.
(define (sexpr->ast s)
  (match s
    [(? integer? s) (int-e s)]
    [`(add1 ,e)     (add1-e (sexpr->ast e))]
    [`(sub1 ,e)     (sub1-e (sexpr->ast e))]
    [`(if (zero? ,i) ,t ,f) (if-e (sexpr->ast i) (sexpr->ast t) (sexpr->ast f))]
    [`(abs ,x) (abs-e (sexpr->ast x))]
    [`(- ,x) (neg-e (sexpr->ast x))]
    [`(cond ,@cs)
      ; collect the clauses in a pair where the car
      ; is the list of clauses the cdr is the 'else'
      (let ((p (clauses->ast '() cs))) 
        (cond-e (car p) (cdr p)))]
    
    [o              (error "operation not supported: " o)]))

(define (clauses->ast acc cs)
  (match cs
    [`((else ,f))
      (cons (reverse acc) (sexpr->ast f))]
    [(cons `((zero? ,i) ,b) rest)
      (let ((c (clause (sexpr->ast i) (sexpr->ast b))))
           (clauses->ast (cons c acc) rest))]))
