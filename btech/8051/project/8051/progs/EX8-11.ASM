     MOV  C,12H          ;copy bit location 12H to carry
     JNC  NO             ;check to see if is high
     MOV  DPTR,#400H     ;yes, load address of message 
     LCALL DISPLAY       ;display message (see Chap. 12)
     SJMP EXIT           ;get out
NO:  MOV  DPTR,#420H     ;load the address of No message
     LCALL DISPLAY       ;display it
EXIT:                    ;exit
;________________data to be displayed on LCD
          ORG  400H
YES_MG:   DB   "New Messages"
          ORG  420H
NO_MG:    DB   "No New Messages" 