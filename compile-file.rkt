#lang racket
(provide (all-defined-out))
(require "compile.rkt" "syntax.rkt" "asm/printer.rkt" "lex.rkt" "parse.rkt")

;; String -> Void
;; Compile contents of given file name,
;; emit asm code on stdout
(define (main fn)
  (with-input-from-file fn
    (λ ()
      (let ((p (read-program)))
        (asm-display (compile p))))))

(define (read-program)
  ;; remove this when your parser is complete: (delete until next comment)
  (begin
    (read-line)
    (let ((e (read)))
      (unless (expr? e) (error "syntax error"))
      (sexpr->ast e)))
  ;; use this when your parser is complete: (remove this line and the line below)
  #;
  (parse (lex-port (current-input-port))))
