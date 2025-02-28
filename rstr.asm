section .data
    input db "atta", 0             
    len equ $ - input - 1         
    success db "Strings are palindrome", 0
    s_len equ $ - success
    error db "Strings are not palindrome", 0
    e_len equ $ - error
    result times len+1 db 0 

section .text
    global _start

_start:
    mov esi, 0
    mov edi, len - 1                                 

reverse:
    cmp esi, len
    jge loop_end

    mov al, [input + esi]
    mov [result + edi], al

    inc esi
    dec edi

    jmp reverse

loop_end:
    mov byte [result + len], 0  

    mov eax, 4
    mov ebx, 1
    mov ecx, result
    mov edx, len
    int 0x80

    mov esi, input
    mov edi, result
    mov ecx, len
    repe cmpsb
    je execute_eq

    mov eax, 4
    mov ebx, 1
    mov ecx, error
    mov edx, e_len
    int 0x80
    jmp exit_program

execute_eq:
    mov eax, 4
    mov ebx, 1
    mov ecx, success
    mov edx, s_len
    int 0x80

exit_program:
    mov eax, 1
    xor ebx, ebx
    int 0x80