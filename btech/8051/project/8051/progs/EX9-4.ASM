          MOV  TMOD,#01       ;Timer 0,mode 1(16-bit mode)
HERE:     MOV  TL0,#0F2H      ;TL0=F2H, the low byte
          MOV  TH0,#0FFH      ;TH0=FFH, the high byte
          CPL  P1.5           ;toggle P1.5
          ACALL DELAY
          SJMP HERE           ;load TH,TL again        
;__________-delay using timer 0
DELAY:    
          SETB TR0            ;start the timer 0
AGAIN:    JNB  TF0,AGAIN      ;monitor timer flag 0 until
                              ; it rolls over
          CLR  TR0            ;stop timer 0
          CLR  TF0            ;clear timer 0 flag 
          RET  
