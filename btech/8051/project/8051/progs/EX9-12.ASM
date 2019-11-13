          MOV  TMOD,#10H      ;timer 1, mode 1 (16-bit)
AGAIN:    MOV  TL1,#00        ;TL1=00,low byte of timer
          MOV  TH1,#0DCH      ;TH1=DC,Hi byte
          SETB TR1            ;start the timer 1
BACK:     JNB  TF1,BACK       ;stay until timer rolls over
          CLR  TR1            ;stop timer 1
          CPL  P2.3           ;comp. p2.3 to get hi, lo
          CLR  TF1            ;clear timer flag 1 
          SJMP AGAIN          ;reload timer since mode 1
                              ;is not auto-reload 