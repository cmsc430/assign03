#lang racket
(provide parse)
(require "ast.rkt")

;; S-Expr -> Expr
(define (parse s)
  (cond
    [(integer? s) (Int s)]
    [(boolean? s) (Bool s)]
    [else
     (match s
       [(list 'add1 e)  (Prim1 'add1 (parse e))]
       [(list 'sub1 e)  (Prim1 'sub1 (parse e))]
       ;; TODO: Handle abs, - and not
       ;; SOLN
       [(list 'abs e)  (Prim1 'abs (parse e))]
       ;; SOLN
       [(list '- e)    (Prim1 '- (parse e))]
       ;; SOLN
       [(list 'not e)  (Prim1 'not (parse e))]
       [(list 'zero? e) (Prim1 'zero? (parse e))]
       [(list 'if e1 e2 e3)
        (If (parse e1) (parse e2) (parse e3))]
       ;; TODO: Handle conditionals
       ;; SOLN
       [(cons 'cond clauses)
        (let ((res (parse-cond clauses)))
          (Cond (car res) (cdr res)))]
       )]))


;; SOLN
(define (parse-cond cs)
  (match cs
    [(list (list 'else e)) (cons '() (parse e))]
    [(cons (list p e) css)
     (let ((res (parse-cond css)))
       (cons (cons (Clause (parse p) (parse e)) (car res)) (cdr res)))]))
