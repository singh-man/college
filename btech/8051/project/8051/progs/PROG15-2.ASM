;writing commands to the LCD with checking busy flag
;PA of 8255 connected to D0-D7 of LCD and
;PB0=RS, PB1=R/W, PB2=E for 8255 to LCD's control pins connect.
          MOV  A,#80H         ;all 8255 ports as output
          MOV  R0,#CNTPORT    ;load control reg address
          MOVX @R0,A          ;issue control word
          MOV  A,#38H         ;LCD: 2 LINES, 5X7 matrix
          ACALL NCMDWRT       ;write command to LCD
          MOV  A,#0EH         ;LCD command for cursor on
          ACALL NCMDWRT       ;write command to LCD
          MOV  A,#01H         ;clear LCD 
          ACALL NCMDWRT       ;write command to LCD
          MOV  A,#06          ;shift cursor right command
          ACALL NCMDWRT       ;write command to LCD
;         .....               ;etc. for all LCD commands
          MOV  A,#'N'         ;display data (letter N)
          ACALL NDATAWRT      ;send data to LCD display     
          MOV  A,#'O'         ;display data (letter O)
          CALL NDATAWRT       ;send data to LCD display     
;         ....                ;etc. for other data 
;New command write subroutine with checking busy flag
NCMDWRT:  MOV  R2,A           ;save A value
          MOV  A,#90H         ;PA=IN to read LCD status
          MOV  R0,#CNTPORT    ;load control reg address
          MOVX @R0,A          ;configure PA=IN, PB=OUT 
          MOV  A,#00000110B   ;RS=0,R/W=1,E=1 read command
          MOV  R0,#BPORT      ;load port B address
          MOVX @R0,A          ;RS=0,R/W=1 for RD and RS pins 
          MOV  R0,#APORT      ;load port A address
READY:    MOVX A,@R0          ;read command reg 
          RLC  A              ;move D7(busy flag) into carry
          JC   READY          ;until LCD is ready
          MOV  A,#80H         ;make PA and PB output again
          MOV  R0,#CNTPORT    ;load control port address
          MOVX @R0,A          ;issue control word to 8255
          MOV  A,R2           ;get back value to LCD
          MOV  R0,#APORT      ;load port A address
          MOVX @R0,A          ;issue info to LCD'S data pins
          MOV  R0,#BPORT      ;load port B address
          MOV  A,#00000100B   ;RS=0,R/W=0,E=1 for H-TO-L 
          MOVX @R0,A          ;activate RS,R/W,E pins of LCD
          NOP                 ;make E pin pulse wide enough 
          NOP
          MOV  A,#00000000B   ;RS=0,R/W=0,E=0 for H-TO-L
          MOVX @R0,A          ;latch in LCD'S data pin info
          RET

;New data write subroutine with checking busy flag
NDATAWRT: 
          MOV  R2,A           ;save A value
          MOV  A,#90H         ;PA=IN to read LCD status ,PB=OUT
          MOV  R0,#CNTPORT    ;load control port address
          MOVX @R0,A          ;configure PA=IN, PB=OUT 
          MOV  A,#00000110B   ;RS=0,R/W=1,E=1 to read command reg
          MOV  R0,#BPORT      ;load port B address
          MOVX @R0,A          ;RS=0,R/W=1 for RD and RS pins 
          MOV  R0,#APORT      ;load port A address
READY:    MOVX A,@R0          ;read command reg 
          RLC  A              ;move D7(busy flag) into carry
          JC   READY          ;wait until LCD is ready
          MOV  A,#80H         ;make PA and PB output again
          MOV  R0,#CNTPORT    ;load control port address
          MOVX @R0,A          ;issue control word to 8255
          MOV  A,R2           ;get back value to be sent to LCD
          MOV  R0,#APORT      ;load port A address
          MOVX @R0,A          ;issue info to LCD'S data pins
          MOV  R0,#BPORT      ;load port B address
          MOV  A,#00000101B   ;RS=1,R/W=0,E=1 for H-TO-L
          MOVX @R0,A          ;activate RS,R/W,E pins of LCD
          NOP                 ;make E pin pulse wide enough 
          NOP
          MOV  A,#00000001B   ;RS=1,R/W=0,E=0 for H-TO-L
          MOVX @R0,A          ;latch in LCD'S data pin info
          RET            