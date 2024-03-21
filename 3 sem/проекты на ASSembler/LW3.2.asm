.model small

.stack 100h

.data
N equ 5
A dw 5, 10, 15, 20, 25
.code

main proc
mov ax, @data
mov ds, ax

lea si, [A]
mov cx, N
mov ax, 0
mov dx, 0
@@For:
add ax, [si]
adc dx, 0
add si, 2
loop @@For
mov bx, N
div bx


;вывод
AX_DECIMAL_OUTPUT:
XOR BP, BP ;number count
XOR DX, DX
CMP AX, 0 ;compare x to 0
JGE MINUS_END

MINUS: ;print minus
MOV DL, '-'
PUSH AX
MOV AH, 02h
INT 21h
POP AX
NEG AX ;minus is already printed

MINUS_END:
XOR DX, DX
MOV SI, 10
IDIV SI ; AX = AX / 10; DX = AX % 10
ADD DL, 30h ; transform into character
PUSH DX
INC BP ;counter + 1
CMP AX, 0
JNE MINUS_END


PRINT: ;print numbers in reverse order
POP DX
MOV AH, 02h
INT 21h
DEC BP
CMP BP, 0
JG PRINT


MOV DL, ' '
MOV AH, 02h
INT 21h
MOV DI, CX

main endp

end main