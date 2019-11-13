     MOV  A,PCON    ;A=PCON
     SETB ACC.7     ;make D7=1
     MOV  PCON,A    ;SMOD=1,double baud rate 
                    ;with same XTAL freq.
     MOV  TMOD,#20H ;Timer 1, mode 2,auto reload
     MOV  TH1,-3    ;19200(57,600/3 =19200 baud rate
                    ;since SMOD=1) 
     MOV  SCON,#50H ;8-bit data,1 stop bit, RI enabled
     SETB TR1       ;start Timer 1
     MOV  A,#"B"    ;transfer letter B
A_1: CLR  TI        ;make sure TI=0
     MOV  SBUF,A    ;transfer it
H_1: JNB  TI H_1    ;stay here until the last bit is gone
     SJMP A_1       ;keep sending "B" again and again  
