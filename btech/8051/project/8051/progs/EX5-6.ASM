     ORG  0000H               ;burn into ROM starting at 0
     MOV  DPTR,#200H     ;DPTR=200H look-up table address 
     CLR  A              ;clear A(A=0)
     MOVC A,@A+DPTR ;get the char from code space 
     MOV  R0,A           ;save it in R0
     INC  DPTR           ;DPTR=201 pointing to next char
     CLR  A              ;clear A(A=0)
     MOVC A,@A+DPTR ;get the next char 
     MOV  R1,A           ;save it in R1
     INC  DPTR           ;DPTR=202 pointing to next char
     CLR  A              ;clear A(A=0)
     MOVC A,@A+DPTR ;get the next char 
     MOV  R2,A           ;save it in R2
HERE:SJMP HERE           ;stay here
;Data is burned into code space starting at 200H 
          ORG 200H
DATA:     DB "USA"
          END            ;end of program
