section .data
    till equ 4
    sum db 0
    buf db 10, 0
    index db 0

section .bss

section .text
    global _start

_start:
    mov esi, 1
    xor al, al

sums:
    cmp esi, till
    jge loop_end

    mov al, [sum]
    mov [index], esi

    add al, [index]
    mov [sum], al

    add al, '0'
    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    inc esi 
    jmp sums

loop_end:
    mov eax, 1
    xor ebx, ebx
    int 0x80