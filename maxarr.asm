section .data
    array db 1, 2, 3, 4
    len equ 4
    result db 1
    buf db 10, 0

section .bss
    newline resb 1
    num resb 1

section .text
    global _start

_start:
    mov ecx, len
    mov esi, 1
    
looping:
    cmp esi, len
    jg loop_end

    mov al, [array + esi]
    mov bl, [result]

    cmp al, bl 
    jg greater

    mov [result], bl

    inc esi
    jmp looping           

greater:
    mov [result], al                   
    inc esi
    jmp looping    

loop_end:
    mov al, [result]
    add al, '0'

    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1

    int  0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80