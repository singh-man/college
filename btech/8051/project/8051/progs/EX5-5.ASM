          MOV  R0,#35H   ;source pointer
          MOV  R1,#60H   ;destination pointer
          MOV  R3,#10    ;counter
BACK:     MOV  A,@R0     ;get a byte from source
          MOV  @R1,A     ;copy it to destination
          INC  R0        ;increment source pointer
          INC  R1        ;increment destination pointer
          DJNZ R3,BACK   ;keep doing it for all ten bytes