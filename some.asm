section .data
    array db 0, 1, 2, 3, 4
    target db 3
    len equ 5
    curr db 0
    left db 0
    right db len - 1

    found_msg db "Pair found", 0xa
    found_msg_len equ $ - found_msg

    not_found_msg db "Pair not found", 0xa
    not_found_msg_len equ $ - not_found_msg

section .text
    global _start

_start:
    xor esi, esi
    mov edi, len - 1

twosum: ; the only one you can get                
    cmp esi, edi
    jge loop_end

    movzx eax, byte [array + esi]
    movzx ebx, byte [array + edi]

    add eax, ebx

    cmp al, [target]
    je equal
    jg greater
    jmp less

equal:
    mov eax, 4
    mov ebx, 1
    mov ecx, found_msg
    mov edx, found_msg_len
    int 0x80
    jmp exit

greater:
    dec edi
    jmp twosum

less:
    inc esi
    jmp twosum

loop_end:
    ;not equal
    mov eax, 4
    mov ebx, 1
    mov ecx, not_found_msg
    mov edx, not_found_msg_len

    int 0x80

exit:
    mov eax, 1         
    xor ebx, ebx       
    int 0x80