section .data
    array db 1, 2, 3, 4, 5    
    len equ 5                 
    left db 0
    right db len-1           
    mid db 0                 
    target db 4              
    newline db 10            
    msg db "Found at index: " 
    msg_len equ $ - msg                  
    buf db 0, 10            

section .text
    global _start

_start:
    mov esi, 0              

binary_search:
    mov al, [left]
    cmp al, [right]
    jg not_found            

    mov al, [left]
    add al, [right]
    shr al, 1                
    mov [mid], al           

    movzx esi, byte [mid]   
    mov bl, [array + esi]   
    cmp bl, [target]
    je found                
    jl go_right           
    jg go_left              

go_left:
    mov al, [mid]
    dec al
    mov [right], al
    jmp binary_search

go_right:
    mov al, [mid]
    inc al
    mov [left], al
    jmp binary_search

found:
    mov eax, 4              
    mov ebx, 1             
    mov ecx, msg
    mov edx, msg_len
    int 0x80

    mov al, [mid]
    add al, '0'             
    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 2              
    int 0x80

    jmp exit

not_found:
    jmp exit

exit:
    mov eax, 1              
    xor ebx, ebx            
    int 0x80