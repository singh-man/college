          MOV  TMOD,#20H      ;T1/mode 2/8-bit/auto reload
          MOV  TH1,#5         ;TH1=5 
          SETB TR1            ;start the timer 1
BACK:     JNB  TF1,BACK       ;stay till timer rolls over
          CPL  P1.0           ;comp. P1.0 to get hi, lo
          CLR  TF1            ;clear timer flag 1 
          SJMP BACK           ;mode 2 is auto-reload 
