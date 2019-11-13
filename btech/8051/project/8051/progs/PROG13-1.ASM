;Keyboard subroutine. This program sends the ASCII code 
;for pressed key to P0.1  
;P1.0-P1.3 connected to rows P2.0-P2.3 connected to columns
       MOV P2,#0FFH      ;make P2 an input port
K1:    MOV P1,#0         ;ground all rows at once
       MOV A,P2          ;read all col. (ensure all keys open)
       ANL A,00001111B   ;masked unused bits
       CJNE A,#00001111B,K1   ;check til all keys released
K2:    ACALL DELAY            ;call 20 msec delay
       MOV A,P2               ;see if any key is pressed
       ANL A,#00001111B       ;mask unused bits
       CJNE A,#00001111B,OVER ;key pressed, await closure
       SJMP K2                ;check il key pressed
OVER:  ACALL DELAY            ;wait 20 msec debounce time
       MOV A,P2               ;check key closure
       ANL A,#00001111B       ;mask unused bits
       CJNE A,#00001111B,OVER1;key pressed, find row
       SJMP K2                ;if none, keep polling
OVER1: MOV P1,#11111110B      ;ground row 0
       MOV A,P2               ;read all columns
       ANL A,#00001111B       ;mask unused bits
       CJNE A,#00001111B,ROW_0;key row 0, find the col.
       MOV P1,#11111101B      ;ground row 1
       MOV A,P2               ;read all columns
       ANL A,#00001111B       ;mask unused bits 
       CJNE A,#00001111B,ROW_1;keyrow 1, find the col.
       MOV P1,#11111011B      ;ground row 2
       MOV A,P2               ;read all columns
       ANL A,#00001111B       ;mask unused bits
       CJNE A,#00001111B,ROW_2;key row 2, find the col.
       MOV P1,#11110111B      ;ground row 3
       MOV A,P2               ;read all columns
       ANL A,#00001111B       ;mask unused bits
       CJNE A,#00001111B,ROW_3;keyrow 3, find the col.
       LJMP K2                ;if none, false input, repeat
ROW_0: MOV DPTR,#KCODE0       ;set DPTR=start of row 0        
       SJMP FIND              ;find col. key belongs to
ROW_1: MOV DPTR,#KCODE1       ;set DPTR=start of row 1
       SJMP FIND              ;find col. key belongs to
ROW_2: MOV DPTR,#KCODE2       ;set DPTR=start of row 2 
       SJMP FIND              ;find col. key belongs to
ROW_3: MOV DPTR,#KCODE3       ;set DPTR=start of row 3
FIND:  RRC A                  ;see if any CY bit low
       JNC MATCH              ;if zero, get the ASCII code       
       INC DPTR               ;point to next col. address
       SJMP FIND              ;keep searching
MATCH: CLR A                  ;set A=0 (match is found)
       MOVC A,@A+DPTR         ;get ASCII code from table
       MOV  P0,A              ;display pressed key
       LJMP  K1
;ASCII LOOK-UP TABLE FOR EACH ROW
      ORG     300H
KCODE0: DB     '0','1','2','3'          ;ROW 0
KCODE1: DB     '4','5','6','7'          ;ROW 1
KCODE2: DB     '8','9','A','B'          ;ROW 2
KCODE3: DB     'C','D','E','F'          ;ROW 3
      END