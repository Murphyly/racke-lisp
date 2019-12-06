#lang br/quicklang
(require "parser-v2.rkt")

(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module bf-mod "expander-v2.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)

(require brag/support)
(define (make-tokenizer port)
  (define (next-token)
    (define bf-lexer
      (lexer
       [(char-set "FWD") lexeme]
       [(char-set "RWD") lexeme]
       [(char-set "INC") lexeme]
       [(char-set "DEC") lexeme]
       [(char-set "BEGIN") lexeme]
       [(char-set "END") lexeme]
       [(char-set "WRITE") lexeme]
       [(char-set "READ") lexeme]
       [any-char (next-token)]))
    (bf-lexer port))  
  next-token)