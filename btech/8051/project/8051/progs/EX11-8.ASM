        ORG 0
        LJMP MAIN
        ORG 23H                 
        LJMP SERIAL      ;jump to serial interrupt ISR
        ORG 30H
MAIN:   MOV P1,#0FFH     ;make P1 an input port
        MOV TMOD,#20H    ;timer 1, mode 2 (auto reload)
        MOV TH1,#0FDH    ;9600 baud rate
        MOV SCON,#50H    ;8-bit, 1 stop, ren enabled
        MOV IE,#10010000B     ;enable serial interrupt
        SETB TR1         ;start timer 1
BACK:   MOV  A,P1             ;read data from port 1
        MOV  SBUF,A           ;give a copy to SBUF
        MOV  P2,A        ;send it to P2
        SJMP BACK             ;stay in loop indefinitely
;
;------------------SERIAL PORT ISR
        ORG 100H
SERIAL:  JB  TI,TRANS    ;jump if TI is high
        MOV A,SBUF       ;otherwise due to receive
        CLR RI           ;clear RI since CPU does not
        RETI             ;return from ISR
TRANS:   CLR TI          ;clear TI since CPU does not
        RETI           ;return from ISR
        END

