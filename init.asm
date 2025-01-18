section .data
    num1 db 9          
    num2 db 7 
    result db 0         
    msg db "Result: ", 0 
    len_msg equ $ - msg  
    buf db 10, 0        

section .bss
    temp resb 4    

section .text
    global _start

_start:
    mov al, [num1]   ; num1 -> al
    mov bl, [num2]      
    
    mul bl        
    mov [result], al  ; Store result in memory

    xor ah, ah
    mov bl, 10
    div bl

    add ah, '0'
    mov [buf + 1], ah
    add al, '0'
    mov [buf], al

    mov byte [buf + 2], 0xA

    mov eax, 4          
    mov ebx, 1          
    mov ecx, msg        
    mov edx, len_msg    
    int 0x80            

    mov eax, 4          
    mov ebx, 1          
    mov ecx, buf        
    mov edx, 3          
    int 0x80            

    mov eax, 1          
    xor ebx, ebx  
    int 0x80