          ORG  0
BACK:     MOV  A,#55H    ;load A with 55H
          MOV  P1,A      ;send 55H to port 1
          MOV  R4,#99H
          MOV  R5,#67H
          LCALL DELAY    ;time delay
          MOV   A,#0AAH  ;Load A with AA
          MOV  P1,A      ;send AAH to port 1
          LCALL DELAY    
          SJMP BACK      ;keep doing this 
;________this is the delay subroutine
          ORG 300H  
DELAY:    PUSH 4              ;PUSH R4
          PUSH 5              ;PUSH R5
          MOV  R4,#0FFH       ;R4=FFH
NEXT:     MOV  R5,#0FFH       ;R5=255
AGAIN:    DJNZ R5,AGAIN   
          DJNZ R4,NEXT
          POP  5         ;POP INTO R5
          POP  4         ;POP INTO R4
          RET            ;return to caller 
          END            ;end of asm file
