;Writing commands and data to LCD without checking busy flag
;Assume PA of 8255 connected to D0-D7 of LCD and
;PB0=RS, PB1=R/W, PB2=E for LCD's control pins connection
          MOV  A,#80H         ;all 8255 ports as output
          MOV  R0,#CNTPORT    ;load control reg address
          MOVX @R0,A          ;issue control word
          MOV  A,#38H         ;LCD:2 lines, 5X7 matrix
          ACALL CMDWRT        ;write command to LCD
          ACALL DELAY         ;wait before next issue(2 ms)
          MOV  A,#0EH         ;LCD command for cursor on
          ACALL CMDWRT        ;write command to LCD
          ACALL DELAY         ;wait before next issue
          MOV  A,#01H         ;clear LCD 
          ACALL CMDWRT        ;write command to LCD
          ACALL DELAY         ;wait before next issue
          MOV  A,#06          ;shift cursor right command
          ACALL CMDWRT        ;write command to LCD
          ACALL DELAY         ;wait before next issue
;         .....               ;etc. for all LCD commands
          MOV  A,#'N'         ;display data (letter N)
          ACALL DATAWRT       ;send data to LCD display     
          ACALL DELAY         ;wait before next issue
          MOV  A,#'O'         ;display data (letter O)
          ACALL DATAWRT       ;send data to LCD display     
          ACALL DELAY         ;wait before next issue
;         ....                ;etc. for other data 
;Command write subroutine, writes instruction commands to LCD
CMDWRT:   MOV  R0,#APORT      ;load port A address
          MOVX @R0,A          ;issue info to LCD data pins
          MOV  R0,#BPORT      ;load port B address
          MOV  A,#00000100B   ;RS=0,R/W=0,E=1 for H-TO-L 
          MOVX @R0,A          ;activate LCD pins RS,R/W,E
          NOP                 ;make E pin pulse wide enough 
          NOP
          MOV  A,#00000000B   ;RS=0,R/W=0,E=0 for H-TO-L
          MOVX @R0,A          ;latch in data pin info
          RET       
;Data write subroutine, write data to be displayed to LCD 
DATAWRT:  MOV  R0,#APORT      ;load port A address
          MOVX @R0,A          ;issue info to LCD data pins
          MOV  R0,#BPORT      ;load port B address
          MOV  A,#00000101B   ;RS=1,R/W=0,E=1 for H-TO-L
          MOVX @R0,A          ;activate LCD pins RS,R/W,E 
          NOP                 ;make E pin pulse wide enough 
          NOP
          MOV  A,#00000001B   ;RS=1,R/W=0,E=0 for H-TO-L 
          MOVX @R0,A          ;latch in LCD's data pin info
          RET       