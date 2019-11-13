          ORG  0
          MOV  DPTR,#300H     ;LOAD LOOK-UP TABLE ADDRESS
          MOV  A,#0FFH        ;A=FF
          MOV  P1,A           ;CONFIGURE P1 AS INPUT PORT
BACK:     MOV  A,P1           ;GET X
          MOVC A,@A+DPTR ;GET X SQAURE FROM TABLE
          MOV  P2,A           ;ISSUE IT TO P2
          SJMP BACK           ;KEEP DOING IT

          ORG  300H
XSQR_TABLE:
          DB   0,1,4,9,16,25,36,49,64,81
          END
