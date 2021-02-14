#lang racket
(provide (all-defined-out))
(require "ast.rkt" a86/ast)

;; Expr -> Asm
(define (compile e)
  (prog (Label 'entry)
        (compile-e e)
        (Ret)))

;; Expr -> Asm
(define (compile-e e)
  (match e
    [(Int i)           (compile-integer i)]    
    [(Prim1 p e)       (compile-prim1 p e)]
    [(IfZero e1 e2 e3) (compile-ifzero e1 e2 e3)]
    ;; TODO: Handle conditionals
    ;; SOLN
    [(Cond cs e)       (compile-cond cs e)]
    ))

;; Integer -> Asm
(define (compile-integer i)
  (seq (Mov 'rax i)))

;; Op Expr -> Asm
(define (compile-prim1 p e)
  (seq (compile-e e)
       (match p
         ['add1 (Add 'rax 1)]
         ['sub1 (Sub 'rax 1)]
         ;; TODO: Handle abs and -
         ;; SOLN
         ['abs  (let ((l (gensym 'abs)))
                  (list (Cmp 'rax 0)
                        (Jg l)
                        (Mov 'rbx 0)
                        (Sub 'rbx 'rax)
                        (Mov 'rax 'rbx)
                        (Label l)))]
         ;; SOLN
         ['-    (list (Mov 'rbx 0)
                      (Sub 'rbx 'rax)
                      (Mov 'rax 'rbx))]
         )))

;; Expr Expr Expr -> Asm
(define (compile-ifzero e1 e2 e3)
  (let ((l1 (gensym 'if))
        (l2 (gensym 'if)))
    (seq (compile-e e1)
         (Cmp 'rax 0)
         (Je l1)
         (compile-e e3)
         (Jmp l2)
         (Label l1)
         (compile-e e2)
         (Label l2))))

;; SOLN
(define (compile-cond cs e)
  (match cs
    ['() (compile-e e)]
    [(cons (Clause i b) cs) (compile-e (IfZero i b (Cond cs e)))]))
