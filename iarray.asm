section .data
    array db 1, 2, 3, 4, 5
    len equ 5
    target equ 3

section .bss
    newline resb 1
    num resb 1

section .text
    global _start

_start:
    mov esi, 0
    mov bl, 6
    
looping:
    cmp esi, len
    jge exit

    cmp esi, [target]
    je second 

    cmp esi, [target]
    jg third

    inc esi
    jmp looping

second:
    mov al, [array + esi]
    mov [array + esi], bl
    inc esi
    jmp looping

third:
    cmp esi, len
    jge exit

    mov [array + esi], al

    inc esi
    mov al, [array + esi]
    jmp third

exit:
    mov eax, 1          
    xor ebx, ebx      
    int 0x80