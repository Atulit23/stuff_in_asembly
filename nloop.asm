section .data
    array db 3, 5, 1, 6
    len equ 4
    i db 0
    j db 0
    msg_before db "Before sorting: ", 0
    msg_after db "After sorting: ", 0
    space db " ", 0
    newline db 10

section .bss
    num resb 1

section .text
    global _start

_start:
    ; Print "Before sorting: " message
    mov eax, 4
    mov ebx, 1
    mov ecx, msg_before
    mov edx, 14
    int 0x80

    call print_array

    mov byte [i], 0      

outerloop:
    movzx esi, byte [i]
    cmp esi, len - 1
    jge outerloop_end

    mov byte [j], 0      

innerloop:
    movzx esi, byte [j]
    cmp esi, len - 1
    jge innerloop_end

    mov al, byte [array + esi]      
    mov bl, byte [array + esi + 1]  
    
    cmp al, bl                      
    jle no_swap                     

    mov byte [array + esi], bl      
    mov byte [array + esi + 1], al  

no_swap:
    inc byte [j]                    
    jmp innerloop

innerloop_end:
    inc byte [i]                    
    jmp outerloop

outerloop_end:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, msg_after
    mov edx, 13
    int 0x80

    call print_array

    mov eax, 1
    xor ebx, ebx
    int 0x80

print_array:
    push eax        
    push ebx
    push ecx
    push edx
    push esi

    xor esi, esi    

print_loop:
    cmp esi, len
    jge print_done

    movzx eax, byte [array + esi]
    add al, '0'
    mov [num], al

    mov eax, 4
    mov ebx, 1
    mov ecx, num
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, space
    mov edx, 1
    int 0x80

    inc esi
    jmp print_loop

print_done:
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    pop esi         
    pop edx                  
    pop ecx
    pop ebx
    pop eax
    ret