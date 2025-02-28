section .data
    array db 1, 2, 4, 0
    buf db 10, 0
    result db 0
    len equ 4

section .text
    global _start

_start:
    mov esi, 0

looping:
    cmp esi, len - 1
    jg loop_end

    mov al, [result]
    mov al, [array + esi]
    mov [result], al

    add al, '0'
    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    inc esi
    jmp looping

    mov eax, 1
    xor ebx, ebx
    int 0x80

loop_end:
    mov eax, 1
    xor ebx, ebx
    int 0x80