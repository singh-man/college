     MOV  A,#29H    ;A=29H, packed BCD
     MOV  R2,A      ;keep a copy of BCD data in R2
     ANL  A,#0FH    ;mask the upper nibble(A=09)
     ORL  A,#30H    ;make it an ASCII, A=39H (`9')
     MOV  R6,A      ;save it (R6=39H ASCII char)
     MOV  A,R2      ;A=29H;get the original data
     ANL  A,#0F0H   ;mask the lower nibble(A=20)
     RR   A         ;rotate right
     RR   A         ;rotate right
     RR   A         ;rotate right
     RR   A         ;rotate right,(A=02)
     ORL  A,#30H    ;A=32H,ASCII char.'2'
     MOV  R2,A      ;save ASCII char in R2

