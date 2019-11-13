               MOV  A,#0FFH
               MOV  P1,A      ;make P1 an input port
               MOV  A,P1      ;read data from P1
               MOV  B,#10     ;B=0A hex (10 dec)
               DIV  AB        ;divide by 10
               MOV  R7,B      ;save lower digit
               MOV  B,#10     ;
               DIV  AB        ;divide by 10 once more
               MOV  R6,B      ;save the next digit
               MOV  R5,A      ;save the last digit
