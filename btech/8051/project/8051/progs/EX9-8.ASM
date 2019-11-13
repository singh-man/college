          CLR  P2.3           ;clear P2.3
          MOV  TMOD,#01       ;Timer 0,mode 1(16-bit mode)
HERE:     MOV  TL0,#0         ;TL0=0, the low byte
          MOV  TH0,#0         ;TH0=0, the high byte
          SETB P2.3           ;SET high P2.3
          SETB TR0            ;start timer 0
AGAIN:    JNB  TF0,AGAIN      ;monitor timer Flag 0
          CLR  TR0            ;stop timer 0
          CLR  TF0            ;clear timer 0 flag 
          CLR  P2.3
