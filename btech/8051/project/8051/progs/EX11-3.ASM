;_-Upon wake up go to main, avoid using memory space ;allocated to Interrupt Vector Table 
          ORG  0000H
          LJMP MAIN      ;by-pass interrupt vector table
;
;_-ISR for Timer 1 to generate square wave 
          ORG  001BH     ;timer 1 interrupt vector table                   LJMP 
ISR_T1    ;jump to ISR
;
;_-The main program for initialization 
          ORG  0030H     ;after vector table 
MAIN:     MOV  TMOD,#10H ;timer 1, mode 1
          MOV  P0,#0FFH  ;make P0 an input port 
          MOV  TL1,#018H ;TL1=18 the low byte of -1000
          MOV  TH1,#0FCH ;TH1=FC the high byte of -1000
          MOV  IE,#88H  ;IE=10001000 enable timer 1 int.              SETB 
TR1       ;start timer 1
BACK:     MOV  A,P0      ;get data from P0
          MOV  P1,A      ;issue it to P1
          SJMP BACK      ;keep doing it
;
;__Timer 1 ISR. Must be reloaded since not auto-reload
ISR_T1:   CLR  TR1       ;stop Timer 1
          CLR  P2.1      ;P2.1=0, start of low portion
          MOV  R2,#4     ;                        2 MC
HERE:     DJNZ R2,HERE   ;    4x2 machine cycle(MC)8 MC
          MOV  TL1,#18H  ;load T1 low byte value  2 MC
          MOV  TH1,#0FCH ;load T1 high byte value 2 MC
          SETB TR1       ;starts timer 1          1 MC
          SETB P2.1      ;P2.1=1, back to high   1 MC
          RETI           ;return to main     
          END