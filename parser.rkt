#lang brag

bf-program : (bf-op | bf-loop)*
bf-op      : ">" | "<" | "+" | "-" | "." | ","
bf-loop    : "[" (bf-op | bf-loop)* "]"

;;bf-op    : "fwd" | "rwd" | "inc" | "dec" | "write" | "read"
;;bf-loop  : "begin" (bf-op | bf-loop)* "end"
;;begin end inc dec fwd rwd read write