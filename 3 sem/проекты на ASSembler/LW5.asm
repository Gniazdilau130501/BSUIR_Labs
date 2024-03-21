.model small
.data
Filename db "D:\file.txt", 0
Str db "Error",'$'
Buffer db "$$$$$"
FHndl dw 0
.code
start:
    mov ax, @data
    mov ds, ax
    mov es, ax
    mov ah, 3dh
    mov al, 0
    lea dx, Filename
    int 21h
    jc error
    mov FHndl, ax
LP:
    mov ah, 3Fh
    lea dx, Buffer
    mov cx, 1
    mov bx, FHndl
    int 21h
    jc error
    cmp ax, cx
    jne EOF
    push dx
    mov dl, Buffer
    mov ah, 02h
    int 21h
    pop dx
    jmp LP
EOF:
    mov bx, FHndl
    mov ah, 3Eh
    int 21h
    jnc quit
error:
    mov ah, 9h
    mov dx, OFFSET Str
    int 21h 
quit:
mov ax, 4c00h
int 21h
end start.
