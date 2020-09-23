#lang racket
(provide parse)
(require "ast.rkt")

;; type Token =
;; | Integer
;; | 'add1
;; | 'sub1
;; | 'zero?
;; | 'if
;; | 'cond
;; | 'else
;; | 'abs
;; | '-
;; | 'lparen    ;; (
;; | 'rparen    ;; )
;; | 'lsquare   ;; [
;; | 'rsquare   ;; ]
;; | 'eof       ;; end of file

;; (Listof Token) -> Expr
(define (parse lot)
  ;; TODO
  0
)




(module+ test
  (require rackunit)
  (require "lex.rkt")
  ;; String -> Expr
  (define (p s)
    (parse (lex-string (string-append "#lang racket " s))))
  
  (check-equal? (p "7") (int-e 7))
  (check-equal? (p "(add1 7)") (add1-e (int-e 7)))
  (check-equal? (p "(sub1 7)") (sub1-e (int-e 7)))
  (check-equal? (p "[add1 7]") (add1-e (int-e 7)))
  (check-equal? (p "[sub1 7]") (sub1-e (int-e 7)))
  (check-equal? (p "(abs 7)") (abs-e (int-e 7)))
  (check-equal? (p "[abs 7]") (abs-e (int-e 7)))
  (check-equal? (p "(- 7)") (neg-e (int-e 7)))
  (check-equal? (p "[- 7]") (neg-e (int-e 7)))
  (check-equal? (p "(cond [else 1])") (cond-e '() (int-e 1)))
  (check-equal? (p "(cond [(zero? 0) 2] [else 1])")
                (cond-e (list (clause (int-e 0) (int-e 2))) (int-e 1)))
  (check-equal? (p "(cond [(zero? 0) 2] [(zero? 1) 3] [else 1])")
                (cond-e (list (clause (int-e 0) (int-e 2)) (clause (int-e 1) (int-e 3))) (int-e 1)))
  (check-equal? (p "(cond [(zero? 0) 2] [(zero? 1) 3] (else 1))")
                (cond-e (list (clause (int-e 0) (int-e 2)) (clause (int-e 1) (int-e 3))) (int-e 1)))
  (check-equal? (p "(if (zero? 9) 1 2)")
                (if-e (int-e 9) (int-e 1) (int-e 2)))
  ;; TODO: add more tests
  #;...)
