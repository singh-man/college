          ORG  0000H
          LJMP MAIN
;_-ISR for hardware interrupt INT1 to turn on the LED
          ORG  0013H     ;INT1 ISR
          SETB P1.3      ;turn on the LED
          MOV  R3,#255
BACK:     DJNZ R3,HERE   ;keep the buzzer on for a while
          CLR  P1.3      ;turn off the buzzer
          RETI           ;return from Buzzer
;__ MAIN program for initialization
          ORG  30H
MAIN:     SETB TCON.2    ;make INT1 edge-trigger interrupt
          MOV  IE,#10000100B  ;enable External INT 1
HERE:     SJMP HERE      ;stay here until get interrupted     
          END