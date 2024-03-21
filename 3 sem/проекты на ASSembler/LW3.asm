STAK    SEGMENT STACK
        DB  256 DUP (?)
STAK    ENDS
 
DATA    SEGMENT
    BUF     DB      5, 00, 6 DUP ('$')      
    OUTBUF  DB      13, 10, 16 DUP ('0'), '$'
DATA    ENDS
 
CODE SEGMENT
    ASSUME  CS:CODE, DS:DATA, SS:STAK
; -----------------------------------------------------------------------
 

READ    PROC    
    MOV AH, 0AH  
    LEA DX, BUF 
    INT 21H
    RET
READ    ENDP
 
; -----------------------------------------------------------------------
 

PRINT   PROC
    MOV AH, 09H 
    LEA DX, OUTBUF  
    INT 21H
    RET
PRINT   ENDP
 
; -----------------------------------------------------------------------
 

STR_TO_NUM      PROC        
    MOV DI, 0
    LEA BX, BUF + 1 
    MOV CX, [BX]    
    XOR CH, CH
    MOV SI, 1       
 M1:    PUSH    SI  
    MOV SI, CX  
    MOV AX, [BX+SI] 
    XOR AH, AH 
    POP SI      
    SUB AX, 30H 
    MUL SI      
    ADD DI, AX  
    MOV AX, SI  
    MOV DX, 10D 
    MUL DX      
    MOV SI, AX  
    LOOP    M1      
STR_TO_NUM      ENDP
 
; -----------------------------------------------------------------------
 

DEC_TO_BIN  PROC    
    MOV BX, DI             
    LEA SI, OUTBUF + 2      
    MOV CX, 10h             
 DB2:   SHL BX, 1          
    JC DB1                 
    MOV BYTE PTR [SI], '0'     
    JMP DB3
 DB1:   MOV BYTE PTR [SI], '1'  
 DB3:   INC SI          
    LOOP DB2
    RET
DEC_TO_BIN  ENDP
 
; -----------------------------------------------------------------------
 
START:
    XOR AX, AX
    MOV BX, DATA    
    MOV DS, BX  
 
    CALL    READ   
    CALL    STR_TO_NUM  
 
; -----------------------------------------------------------------------
 
    CALL    DEC_TO_BIN  
    CALL    PRINT   
    
    
; -----------------------------------------------------------------------
 
MOV AH, 4CH
    INT 21H
CODE    ENDS
END START
