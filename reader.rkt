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
       ;;["begin\n" "{"]
       ;;[(char-set "FWD") lexeme]
       ;;[(char-set "RWD") lexeme]
       ;;[(char-set "DEC") lexeme]
       ;;[(char-set "WRITE") lexeme]
       ;;[(char-set "READ") lexeme]
       ;;[(char-set "INC") lexeme]
       ;;[(char-set "BEGIN") lexeme]
       ;;[(char-set "END") lexeme]
       [(:seq "fwd" (repetition NUMBER +inf.0 numeric) "\n")
        (token 'FWD (list "+" (string->number (trim-ends "fwd" lexeme "\n"))))]
       [(:seq "rwd" (repetition NUMBER +inf.0 numeric) "\n")
        (token 'RWD (list "+" (string->number (trim-ends "rwd" lexeme "\n"))))]
       [(:seq "inc" (repetition NUMBER +inf.0 numeric) "\n")
        (token 'INC (list "+" (string->number (trim-ends "inc" lexeme "\n"))))]
       [(:seq "dec" (repetition NUMBER +inf.0 numeric) "\n")
        (token 'DEC (list "+" (string->number (trim-ends "dec" lexeme "\n"))))]
       [any-char (next-token)]))
    (bf-lexer port))
  next-token)


