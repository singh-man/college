     CLR  C         ;make CY=0
     MOV  A,#0E7H   ;load the low byte now A=E7H  
     ADD  A,#8DH    ;add the low byte now A=74H and CY=1
     MOV  R6,A      ;save the low byte of the sum in R6
     MOV  A,#3CH    ;load the high byte
     ADDC A,#3BH    ;add with the carry
                    ;3B + 3C + 1 = 78(all in hex)
     MOV  R7,A      ;save the high byte of the sum