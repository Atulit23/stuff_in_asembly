section .data
    array db 1, 2, 3, 4, 5
    len equ 5

section .bss
    newline resb 1
    num resb 1

section .text
    global _start

_start:
    mov ecx, len
    mov esi, 0
    
looping:
    cmp esi, len - 1
    jg loop_end  ;i want it to go into another loop& when its end is reached  i want it to exit & come back 

    mov al, [array + esi]
    add al, '0'
    mov [num], al

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 0x80

    inc esi
    loop looping ; here actually make call to another loop

    mov eax, 1
    xor ebx, ebx
    int 0x80

loop_end:
    mov eax, 1
    xor ebx, ebx
    int 0x80