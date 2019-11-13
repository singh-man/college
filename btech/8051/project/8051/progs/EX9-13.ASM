          MOV  TMOD,#10H      ;Timer 1,mode 1(16-bit)
          MOV  R3,#200        ;counter for multiple delay
AGAIN:    MOV  TL1,#08        ;TL1=08,low byte of timer
          MOV  TH1,#01        ;TH1=01,Hi byte
          SETB TR1            ;start the timer 1
BACK:     JNB  TF1,BACK       ;stay until timer rolls over
          CLR  TR1            ;stop timer 1
          CLR  TF1            ;clear timer flag 1 
          DJNZ R3,AGAIN       ;if R3 not zero then 
                              ;reload timer 

