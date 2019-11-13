          MOV  TMOD,#2H       ;Timer 0,mode 2
                              ;(8-bit,auto reload)
          MOV  TH0,#0         ;TH0=0
AGAIN:    MOV  R5,#250        ;count for multiple delay
          ACALL DELAY
          CPL  P1.0
          SJMP AGAIN
DELAY:    SETB TR0            ;start the timer 0
BACK:     JNB  TF0,BACK       ;stay until timer rolls over
          CLR  TR0            ;stop timer 0
          CLR  TF0            ;clear TF for next round
          DJNZ R5,DELAY
          RET
