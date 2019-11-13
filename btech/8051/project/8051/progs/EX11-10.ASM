          ORG 0
          LJMP MAIN
          ORG 000BH                ;ISR FOR TIMER 0
          CPL P0.1            ;TOGGLE P0.1
          RETI                ;RETURN FROM ISR
          ORG 23H
          LJMP SERIAL         ;JUMP TO SERIAL INT. ISR
          ORG 30H
MAIN:     MOV P1,#0FFH             ;MAKE P1 AN INPUT PORT
          MOV TMOD,#22H  ;TIMER 0&1,MODE 2, AUTO RELOAD
          MOV TH1,#0F6H       ;4800 BAUD RATE
          MOV SCON,#50H       ;8-BIT,1 STOP,REN ENABLED
          MOV TH0,#-92        ;FOR 5 KHZ WAVE.  
          MOV IE,#10010010B   ;ENABLE SERIAL,TIMER 0 INT.
          SETB TR1            ;START TIMER 1
          SETB TR0            ;START TIMER 0
BACK:     MOV  A,P1           ;READ DATA FROM PORT 1
          MOV  SBUF,A         ;GIVE A COPY TO SBUF
          MOV  P2,A           ;WRITE IT TO P2
          SJMP BACK           ;STAY IN LOOP INDEFINITELY
;------------------SERIAL PORT ISR
          ORG 100H
SERIAL:   JB  TI,TRANS        ;JUMP IF TI IS HIGH
          MOV A,SBUF          ;OTHERWISE DUE TO RECEIVE
          MOV P0,A            ;SEND SERIAL DATA TO P0
          CLR RI         ;CLEAR RI SINCE CPU DOES NOT
          RETI                ;RETURN FROM ISR
TRANS:    CLR TI         ;CLEAR TI SINCE CPU DOES NOT
          RETI                ;RETURN FROM ISR
          END
