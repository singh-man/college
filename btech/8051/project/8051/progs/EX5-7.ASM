;(a) This method uses a counter
          ORG
          MOV DPTR,#MYDATA    ;LOAD ROM POINTER
          MOV R0,#40H              ;LOAD RAM POINTER
          MOV R2,#7           ;LOAD COUNTER
  BACK:   CLR A                    ;A=0
          MOVC A,@A+DPTR      ;MOVE DATA FROM CODE SPACE
          MOV  @R0,A               ;SAVE IT IN RAM
          INC  DPTR                ;INCREMENT ROM POINTER
          INC  R0                  ;INCREMENT RAM POINTER
          DJNZ R2,BACK        ;LOOP UNTIL COUNTER=0
  HERE:   SJMP HERE
 ;----------ON-CHIP CODE SPACE USED FOR STORING DATA
               ORG  250H
  MYDATA: DB   "AMERICA"
          END

;(b)This method uses null char for end of string
          ORG
          MOV DPTR,#MYDATA    ;LOAD ROM POINTER
          MOV R0,#40H         ;LOAD RAM POINTER
  BACK:   CLR A          ;A=0
          MOVC A,@A+DPTR      ;MOVE DATA FROM CODE SPACE
          JZ   HERE                ;EXIT IF NULL CHAR
          MOV  @R0,A          ;SAVE IT IN RAM
          INC  DPTR                ;INCREMENT ROM POINTER
          R0                      ;INCREMENT RAM POINTER
          SJMP BACK                ;LOOP
  HERE:   SJMP HERE

 ;----------ON-CHIP CODE SPACE USED FOR STORING DATA
          ORG  250H
  MYDATA: DB   "AMERICA",0    ;notice null char for 
                              ;end of string
         END
