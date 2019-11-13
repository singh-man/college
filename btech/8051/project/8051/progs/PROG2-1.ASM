     ORG  0H        ;start (origin) at location 0
     MOV  R5,#25H   ;load 25H into R5  
     MOV  R7,#34H   ;load 34H into R7 
     MOV  A,#0      ;load 0 into A                     
     ADD  A,R5      ;add contents of R5 to A                
                    ;now A = A + R5
     ADD  A,R7      ;add contents of R7 to A
                    ;now A = A + R7
     ADD  A,#12H    ;add to A value 12H 
                    ;now A = A + 12H
HERE:SJMP HERE      ;stay in this loop
     END            ;end of asm source file 