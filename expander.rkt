#lang br/quicklang

;; BF Expansor V4 - Versão funcional do Expansor

(define-macro (bf-module-begin PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [bf-module-begin #%module-begin]))

;; fold-funcs
(define (fold-funcs apl bf-funcs)
  (for/fold ([current-apl apl])
            ([bf-func (in-list bf-funcs)])
    (apply bf-func current-apl)))

;; bf-program
(define-macro (bf-program OP-OR-LOOP-ARG ...)
  #'(begin
      (define first-apl (list (make-vector 30000 0) 0))
      (void (fold-funcs first-apl (list OP-OR-LOOP-ARG ...)))))

(provide bf-program)

;;bf-loop
(define-macro (bf-loop "[" OP-OR-LOOP-ARG ... "]")
  #'(lambda (arr ptr)
      (for/fold ([current-apl (list arr ptr)])
                ([i (in-naturals)]
                 #:break (zero? (apply current-byte
                                       current-apl)))
        (fold-funcs current-apl (list OP-OR-LOOP-ARG ...)))))

(provide bf-loop)

;; bf-op
(define-macro-cases bf-op
   [(bf-op) (">" 'NUMBER)  #'(gtn NUMBER)]
   [(bf-op) ("<" 'NUMBER)  #'(ltn NUMBER)]
   [(bf-op) ("+" 'NUMBER)  #'(plusn NUMBER)]
   [(bf-op) ("-" 'NUMBER)  #'(minusn NUMBER)]
   [(bf-op ".") #'period]
   [(bf-op ",") #'comma])

(provide bf-op)

;; Opera no vetor ponteiro
(define (current-byte arr ptr) (vector-ref arr ptr))

(define (set-current-byte arr ptr val)
  (define new-arr (vector-copy arr))
  (vector-set! new-arr ptr val)
  new-arr)

;; Implementa comandos

(define (gtn arr ptr n) (list arr (+ ptr n)))

(define (ltn arr ptr n) (list arr (- ptr n)))

(define (plusn arr ptr n)
  (list
   (set-current-byte arr ptr (+ (current-byte arr ptr) n))
   ptr))

(define (minusn arr ptr n)
  (list
   (set-current-byte arr ptr (- (current-byte arr ptr) n))
   ptr))

(define (period arr ptr)
  (write-byte (current-byte arr ptr))
  (list arr ptr))

(define (comma arr ptr)
  (list (set-current-byte arr ptr (read-byte)) ptr))
