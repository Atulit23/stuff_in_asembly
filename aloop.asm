section .data
    array db 1, 2, 3
    len equ 3
    result db 0
    buf db 10, 0        

section .bss
    num resb 1

section .text
    global _start

_start:
    mov ecx, len
    mov esi, 0
    mov al, 0

mainloop:
    cmp esi, len - 1
    jg loop_end

    mov al, [result]
    add al, [array + esi]
    mov [result], al

    add al, '0'
    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 2
    int 0x80 

    inc esi
    loop mainloop

    mov eax, 1
    xor ebx, ebx
    int 0x80

loop_end:
    mov eax, 1
    xor ebx, ebx
    int 0x80
    