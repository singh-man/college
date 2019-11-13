     CLR  C              ;CY=0
     MOV  A,#62H         ;A=62H
     SUBB A,#96H         ;62H-96H=CCH with CY=1
     MOV  R7,A           ;save the result 
     MOV  A,#27H         ;A=27H
     SUBB A,#12H         ;27H-12H-1=14H
     MOV  R6,A           ;save the result
