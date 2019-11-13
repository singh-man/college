        ORG 0
        LJMP MAIN
        ORG 000BH        ;ISR for Timer 0
        CPL P1.2
        MOV TL0,#00
        MOV TH0,#0DCH
        RETI
        ORG 30H
;------main program for initialization
MAIN:   MOV TMOD,#00000001B      ;Timer 0, Mode 1
        MOV TL0,#00
        MOV TH0,#0DCH
        MOV IE,#82H        ;enable Timer 0 interrupt
        SETB TR0
HERE:    SJMP HERE
        END
