MAIN:   ORG 000H
        SETB 80H    ; RESET IR
        SETB 84H    ; RESET MAGNETIC SENSOR
        SJMP STEP1

DELAY:  MOV R5,#FFH
        MOV R6,#FFH
AGAIN:  DJNZ R5,AGAIN
        DJNZ R6,AGAIN
        RET

STEP1:  CLR 90H     ; CONVEYER START
;CLR 80H             ; not a part of program
        JNB 80H,STEP2   ; IR DETECT
        SJMP STEP1
STEP2:  SETB 90H    ; CONVEYER STOP
        CLR 82H     ; BUZZER ON
        SETB 83H
        CLR 92H     ; M2 START FORWARD
        SETB 93H
        ACALL DELAY
        SETB 82H    ; BUZZER OFF
        SETB 92H    ; M2 STOP
        CLR 94H     ; M3 START FORWARD
        SETB 95H
        ACALL DELAY
        ACALL DELAY
        SETB 94H    ; M3 STOP
        CLR 82H     ; BUZZER ON
        SETB 83H
        SETB 92H    ; M2 START REVERSE
        CLR 93H
        ACALL DELAY
        SETB 93H    ; M2 STOP
        SETB 82H    ; BUZZER OFF
STEP3:  SETB 94H    ; M3 START REVERSE
        CLR 95H
;CLR 84H
        JB 84H,STEP3   ; MAGNETIC SENSOR FOR ARM
        SETB 95H    ; M3 STOP
        SJMP MAIN
END



