#lang racket
(provide parse)
(require "ast.rkt")

;; S-Expr -> Expr
(define (parse s)
  (cond
    [(integer? s) (Int s)]
    [else
     (match s
       [(list 'add1 e) (Prim1 'add1 (parse e))]
       [(list 'sub1 e) (Prim1 'sub1 (parse e))]
       ;; TODO: Handle abs and -
       ;; SOLN
       [(list 'abs e)  (Prim1 'abs (parse e))]
       ;; SOLN
       [(list '- e)    (Prim1 '- (parse e))]
       [(list 'if z1 e2 e3)
        (match z1
          [(list 'zero? e1)
           (IfZero (parse e1) (parse e2) (parse e3))])]
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
    [(cons (list (list 'zero? ep) ea) css)
     (let ((res (parse-cond css)))
       (cons (cons (Clause (parse ep) (parse ea)) (car res)) (cdr res)))]))
       
