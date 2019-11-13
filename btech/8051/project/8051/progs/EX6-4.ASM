          MOV  R0,#40H   ;load pointer
          MOV  R2,#5     ;load counter
          CLR  A         ;A=0
          MOV  R7,A      ;clear R7
AGAIN:    ADD  A,@R0     ;add the byte pointer to by R0
          DA   A         ;adjust for BCD
          JNC  NEXT      ;if CY=0 don't accumulate carry
          INC  R7        ;keep track of carries
NEXT:     INC  R0        ;increment pointer
          DJNZ R2,AGAIN  ;repeat until R2 is zero
