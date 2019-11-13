     CLR  C   
     MOV  A,#4C     ;load A with value 4CH (A=4CH)
     SUBB A,#6EH    ;subtract 6E from A 
     JNC  NEXT      ;if CY=0 jump to NEXT target
     CPL  A         ;if CY=1 then take 1's complement
     INC  A         ;and increment to get 2's complement
NEXT:MOV  R1,A      ;save A in R1
