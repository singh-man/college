          ORG  0000H
          LJMP MAIN      ;by-pass interrupt vector table
;_-ISR for hardware interrupt INT1 to turn on the LED
          ORG  0013H     ;INT1 ISR
          SETB P1.3      ;turn on LED
          MOV  R3,#255
BACK:     DJNZ R3,BACK   ;keep LED on for a while
          CLR  P1.3      ;turn off the LED
          RETI           ;return from ISR 
;__ MAIN program for initialization
          ORG  30H
MAIN:     MOV  IE,#10000100B  ;enable external INT 1
HERE:     SJMP HERE      ;stay here until get interrupted     
          END
