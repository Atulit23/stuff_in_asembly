section .data
    array db 1, 2, 3, 1
    buf db 10, 0
    rem db 10, 0
    dot db ".", 0
    dot_len equ $ - dot
    len equ 4

section .text
    global _start

_start:
    mov esi, 0
    mov eax, 0 
    
mean:
    cmp esi, len
    jge calculate_mean
    movzx ebx, byte [array + esi]
    add eax, ebx
    inc esi
    jmp mean

calculate_mean:
    mov ebx, len
    cdq
    div ebx
    
    push edx
    
    add eax, '0'
    mov [buf], al
    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, dot
    mov edx, dot_len
    int 0x80

    pop eax ; get back the remaninder & store it in eax
    mov ebx, 10
    mul ebx ; multiply eax & ebx
    mov ebx, len
    div ebx
    add al, '0'
    mov [rem], al

    mov eax, 4
    mov ebx, 1
    mov ecx, rem
    mov edx, 1
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80