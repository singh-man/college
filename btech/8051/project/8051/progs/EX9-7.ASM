          CLR  P2.3           ;clear P2.3
          MOV  TMOD,#01       ;Timer 0,mode 1(16-bit mode)
HERE:     MOV  TL0,#3EH       ;TL0=3EH, the low byte
          MOV  TH0,#0B8H      ;TH0=B8H, the high byte
          SETB P2.3           ;SET high P2.3
          SETB TR0            ;start the timer 0
AGAIN:    JNB  TF0,AGAIN      ;monitor timer Flag 0 
          CLR  TR0  ;stop the timer 0
          CLR  TF0  ;clear timer 0 flag for next round
          CLR  P2.3
