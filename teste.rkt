#lang reader "reader.rkt"

;;A maior linguagem de todos os tempos!

;;Hello World

;;++++++[>++++++++++++<-]>.
;;>++++++++++[>++++++++++<-]>+.
;;+++++++..+++.>++++[>+++++++++++<-]>.
;;<+++[>----<-]>.<<<<<+++[>+++++<-]>.
;;>>.+++.------.--------.>>+.

;;++++-+++-++-++[>++++-+++-++-++<-]>.

inc
inc
inc
inc
dec
inc
inc
inc
dec
inc
inc
dec
inc
inc
begin
 fwd
 inc
 inc
 inc
 inc
 dec
 inc
 inc
 inc
 dec
 inc
 inc
 dec
 inc
 inc
 rwd
 dec
end
fwd
write

;;inc 6 begin fwd 1 inc 12 rwd 1 dec end fwd 1 write
;;fwd 1 inc 10 begin fwd 1 inc 10 rwd 1 dec end fwd 1 write
;;inc 7 write write inc 3 write fwd 1 inc 4 begin fwd 1 inc 11 rwd 1 dec end fwd 1 write
;;rwd 1 inc 3 begin fwd 1 dec 4 rwd 1 dec end fwd write rwd 5 inc 3 begin fwd 1 inc 5 rwd 1 dec end fwd 1 write
;;fwd 2 write inc 3 write dec 6 write dec 8 write fwd 2 inc 1 write
