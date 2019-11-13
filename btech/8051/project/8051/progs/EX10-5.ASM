          ORG 0
          MOV P2,#0FFH    ;make P2 an input port
          MOV TMOD,#20H   ;timer 1,mode 2(auto-reload)
          MOV TH1,#0FAH   ;4800 baud rate
          MOV SCON,#50H   ;8-bit,1 stop, REN enabled
          SETB TR1        ;start timer 1
          MOV  DPTR,#MYDATA  ;load pointer for message
H_1:      CLR  A
          MOVC  A,@A+DPTR     ;get the character
          JZ  B_1             ;if last character get out
          ACALL SEND          ;otherwise call transfer
          INC  DPTR           ;next one
          SJMP H_1       ;stay in loop   
B_1:      MOV A,P2       ;read data on P2
          ACALL SEND     ;transfer it serially
          ACALL RECV     ;get the serial data
          MOV P1,A       ;display it on LEDs
          SJMP B_1      ;stay in loop indefinitly
;--------------serial data transfer. ACC has the data
SEND:     MOV SBUF,A     ;load the data
H_2:      JNB TI,H_2     ;stay here until last bit gone
          CLR TI         ;get ready for next char
          RET           ;return to caller
;---------------- Receive data serially in Acc
RECV:     JNB RI,RECV    ;wait here for char
          MOV A,SBUF     ;save it in ACC
          CLR RI         ;get ready for next char                RET            ;return to
caller
;-----------------The message
MYDATA    DB   "We Are Ready",0
          END

