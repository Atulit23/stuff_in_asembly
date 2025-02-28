section .data
    urandom_file db "/dev/urandom", 0
    msg db "Random Number: ", 0
    msg_len equ $ - msg
    newline db 10
    
section .bss
    random_num resd 1      
    dec_string resb 10     ; Space for decimal string (max 10 digits)

section .text
    global _start

_start:
    mov eax, 5              
    mov ebx, urandom_file             
    mov ecx, 0             
    int 0x80
    
    mov ebx, eax           
    mov eax, 3              
    mov ecx, random_num
    mov edx, 4
    int 0x80
    
    mov eax, [random_num]   
    mov edi, dec_string
    add edi, 9              
    mov byte [edi], 0       
    
    mov ebx, 10             ; Divisor for decimal
    
convert_loop:
    dec edi              
    xor edx, edx          
    div ebx                ; Divide by 10
    add dl, '0'            ; Convert remainder to ASCII
    mov [edi], dl          
    test eax, eax          
    jnz convert_loop
    
    mov eax, 4             
    mov ebx, 1            
    mov ecx, msg
    mov edx, msg_len
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, edi          
    mov edx, dec_string
    add edx, 9            
    sub edx, edi         
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    
    mov eax, 1              
    xor ebx, ebx            
    int 0x80