#lang br/quicklang

;; BF - Leitor Versão 2 - Chama expansor imperativo

;; Usa Parser Versão 1
(require "parser.rkt")

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
       [(char-set "><-.,+[]") lexeme] ;;'fwd''rwd''dec''write''read''inc''begin''end'
       [any-char (next-token)]))
    (bf-lexer port))
  next-token)


