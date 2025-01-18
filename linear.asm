section .data
    array db 1, 2, 3, 4
    len equ 4
    target db 2
    buf db 10, 0

section .bss 
    num resb 1

section .text
    global _start

_start:
    xor esi, esi  
    mov bl, byte [target]

search:
    cmp esi, len 
    jge  loop_end

    mov al, byte [array + esi]          
    cmp al,  bl

    je found

    inc esi
    loop search
    
found:
    add al, '0' ; printing element        
    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    add esi, '0'
    mov [buf], esi

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int  0x80

loop_end:
    mov eax, 1
    xor ebx, ebx
    int  0x80