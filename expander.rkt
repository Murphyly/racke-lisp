#lang br/quicklang

;; BF Expansor V2 - Versão imperativa do Expansor

(define-macro (bf-module-begin PARSE-TREE)
  #'(#%module-begin
     PARSE-TREE))

(provide (rename-out [bf-module-begin #%module-begin]))

(define-macro (bf-program OP-OR-LOOP-ARG ...)
  #'(void OP-OR-LOOP-ARG ...))

(provide bf-program)

(define-macro (bf-loop "[" OP-OR-LOOP-ARG ... "]")
  #'(until (zero? (current-byte))
      OP-OR-LOOP-ARG ...))

(provide bf-loop)

(define-macro-cases bf-op
   [(bf-op) (">" NUMBER)  #'(gtn NUMBER)]
   [(bf-op) ("<" NUMBER)  #'(ltn NUMBER)]
   [(bf-op) ("+" NUMBER)  #'(plusn NUMBER)]
   [(bf-op) ("-" NUMBER)  #'(minusn NUMBER)]
   [(bf-op ".") #'(period)]
   [(bf-op ",") #'(comma)] ;
)
(provide bf-op)

(define arr (make-vector 30000 0))
(define ptr 0)

(define (current-byte) (vector-ref arr ptr))
(define (set-current-byte! val) (vector-set! arr ptr val))

(define (gt) (set! ptr (add1 ptr)))
(define (lt) (set! ptr (sub1 ptr)))
(define (plus) (set-current-byte! (add1 (current-byte))))
(define (minus) (set-current-byte! (sub1 (current-byte))))
(define (period) (write-byte (current-byte)))
(define (comma) (set-current-byte! (read-byte)))
(define (gtn n) (set! ptr (+ ptr n)))
(define (ltn n) (set! ptr (- ptr n)))
(define (plusn n) (set-current-byte! (+ (current-byte) n)))
(define (minusn n) (set-current-byte! (- (current-byte) n)))

