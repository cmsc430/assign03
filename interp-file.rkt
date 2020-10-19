#lang racket
(provide (all-defined-out))
(require "interp.rkt" "syntax.rkt")

;; String -> Void
;; Parse and interpret contents of given filename,
;; print result on stdout
(define (main fn)
  (with-input-from-file fn
    (λ ()
        (let ((p (read-program)))
          (interp p)))))

(define (read-program)
  (parse (lex-port (current-input-port))))
