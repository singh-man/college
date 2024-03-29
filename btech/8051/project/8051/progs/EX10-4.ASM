          MOV  TMOD,#20H ;timer1, mode 2 (auto reload)
          MOV  TH1,#-6   ;4800 baud
          MOV  SCON,#50H ;8-bit, 1 stop, REN enabled
          SETB TR1       ;start timer 1
HERE:     JNB  RI,HERE   ;wait for char to come in
          MOV  A,SBUF    ;save incoming byte in A
          MOV  P1,A      ;send to port 1
          CLR  RI        ;get ready to receive next byte
          SJMP HERE      ;keep getting data