          MOV  TMOD,#10H      ;timer 1, mode 1(16-bit)
AGAIN:    MOV  TL1,#1AH       ;TL1=1A,low byte of timer
          MOV  TH1,#0FFH      ;TH1=FF,Hi byte
          SETB TR1            ;start the timer 1
BACK:     JNB  TF1,BACK       ;stay until timer rolls over
          CLR  TR1            ;stop timer 1
          CPL  P1.5           ;comp. p1.5 to get hi, lo
          CLR  TF1            ;clear timer flag 1
          SJMP AGAIN          ;reload timer since mode 1 
                              ;is not auto-reload 