#lang brag

bf-program : (bf-op | bf-loop)*
bf-op      : ">" | "<" | "+" | "-" | "." | ","
bf-loop    : "[" (bf-op | bf-loop)* "]"

;;bf-op    : "FWD" | "RWD" | "INC" | "DEC" | "WRITE" | "READ"
;;bf-loop  : "BEGIN" (bf-op | bf-loop)* "END"
