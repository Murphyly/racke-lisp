#lang br/quicklang

;; BF - Leitor Versão 2 - Chama expansor imperativo

;; Usa Parser Versão 1
(require "parser.rkt")
(require brag/support)

;; Usa a versão expansor imperativo
(define (read-syntax path port)
  (define parse-tree (parse path (make-tokenizer port)))
  (define module-datum `(module bf-mod "expander.rkt"
                          ,parse-tree))
  (datum->syntax #f module-datum))
(provide read-syntax)


(require brag/support)

;; tokenizer
;; retorna função para ler, processar e repassar o próximo token
;; para o parser
(define (make-tokenizer port)
  (define (next-token)
    (define bf-lexer
      (lexer
       [(from/to ";" "\n") (next-token)]
       ["fwd\n" (token 'FWD ">")]
       ["rwd\n" (token 'RWD "<")]
       ["inc\n" (token 'INC "+")]
       ["dec\n" (token 'DEC "-")]
       ["begin\n" (token 'BEGIN "{")]
       ["end\n" (token 'END "}")]
       ["write\n" (token 'WRITE ".")]
       ["read\n" (token 'READ ",")]
       [(:seq "fwd" (repetition 1 +inf.0 numeric) "\n")
        (token 'FWD (list "+" (string->number (trim-ends "fwd" lexeme "\n"))))]
       [(:seq "rwd" (repetition 1 +inf.0 numeric) "\n")
        (token 'RWD (list "+" (string->number (trim-ends "rwd" lexeme "\n"))))]
       [(:seq "inc" (repetition 1 +inf.0 numeric) "\n")
        (token 'INC (list "+" (string->number (trim-ends "inc" lexeme "\n"))))]
       [(:seq "dec" (repetition 1 +inf.0 numeric) "\n")
        (token 'DEC (list "+" (string->number (trim-ends "dec" lexeme "\n"))))]
       [any-char (next-token)]))
    (bf-lexer port))
  next-token)


