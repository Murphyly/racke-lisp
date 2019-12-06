#lang brag

bf-program : (bf-op | bf-loop)*
bf-op    : FWDN | RWDN | INCN | DECN | WRITE | READ
bf-loop  : BEGIN (bf-op | bf-loop)* END
