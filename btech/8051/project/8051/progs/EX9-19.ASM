          ACALL LCD_SET_UP         ;initialize the LCD 
          MOV  TMOD,#000110B       ;Counter 0,mode2,C/T=1 
          MOV  TH0,#-60            ;counting 60 pulses
          SETB P3.4                ;make T0 as input
AGAIN:    SETB TR0                 ;starts the counter
BACK:     MOV  A,TL0               ;get copy of count TL0
          ACALL CONV               ;convert in R2,R3,R4
          ACALL DISPLAY            ;display on LCD 
          JNB  TF0,BACK            ;loop if TF0=0
          CLR  TR0                 ;stop the counter 0
          CLR  TF0                 ;make TF0=0 
          SJMP AGAIN               ;keep doing it

;converting 8-bit binary to ASCII
;upon return, R4,R3,R2 have ASCII data (R2 has LSD)

CONV:     MOV  B,#10     ;divide by 10
          DIV  AB
          MOV  R2,B      ;save low digit
          MOV  B,#10     ;divide by 10 once more
          DIV  AB
          ORL  A,#30H    ;make it ASCII
          MOV  R4,A      ;save MSD
          MOV  A,B  
          ORL  A,#30H    ;make 2nd digit an ASCII
          MOV  R3,A      ;save it
          MOV  A,R2 
          ORL  A,#30H    ;make 3rd digit an ASCII
          MOV  R2,A      ;save the ASCII
          RET
