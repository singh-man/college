          MOV  TMOD,#2H       ;Timer 0,mode 2
                              ;(8-bit,auto reload)
          MOV  TH0,#-150      ;TH0=6AH = 2's comp of -150
AGAIN:    SETB P1.3           ;P1.3=1
          ACALL DELAY
          ACALL DELAY
          CLR  P1.3           ;P1.3=0
          ACALL DELAY
          SJMP AGAIN
          
          SETB TR0            ;start timer 0
BACK:     JNB  TF0,BACK       ;stay until timer rolls over
          CLR  TR0            ;stop timer 0
          CLR  TF0            ;clear TF for next round
          RET
