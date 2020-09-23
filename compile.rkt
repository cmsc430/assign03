#lang racket
(provide (all-defined-out))
(require "ast.rkt")

;; This assignment should be completed individually.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; I pledge on my honor that I have not given or received any
;; unauthorized assistance on this assignment.
;;
;; Name: TODO
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Expr -> Asm
(define (compile e)
  `(entry
    ,@(compile-e e)
    ret))

;; Expr -> Asm
(define (compile-e e)
  (match e
    [(int-e i) `((mov rax ,i))]
    [(add1-e e0)
     (let ((c0 (compile-e e0)))
       `(,@c0
         (add rax 1)))]    
    [(sub1-e e0)
     (let ((c0 (compile-e e0)))
       `(,@c0
         (sub rax 1)))]
    [(if-e i t f)
     (let ((c0 (compile-e i))
           (c1 (compile-e t))
           (c2 (compile-e f))
           (l0 (gensym "if"))
           (l1 (gensym "if")))
       `(,@c0
         (cmp rax 0)
         (jne ,l0)
         ,@c1
         (jmp ,l1)
         ,l0
         ,@c2
         ,l1))]

    ;; TODO
    #;...))
