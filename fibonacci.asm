section .data
    current dd 1
    prev dd 1
    till equ 8
    buf times 20 db 0    
    newline db 10        
    result dd 0

section .text
    global _start

_start:
    mov eax, 1          
    xor ebx, ebx        
    xor esi, esi        
    mov [result], ebx

fibonacci:
    cmp esi, till - 2
    jge convert_number

    mov [current], eax
    mov [prev], ebx

    add eax, ebx
    mov [result], eax
    
    mov ebx, [current]
    mov eax, [result]

    inc esi
    jmp fibonacci

convert_number:
    mov eax, [result]             
    mov ecx, buf        
    add ecx, 19         
    mov byte [ecx], 0   
    dec ecx
    mov byte [ecx], 10  
    dec ecx
    
    mov ebx, 10         

convert_loop:
    xor edx, edx        
    div ebx            
    add dl, '0'         
    mov [ecx], dl       
    dec ecx             
    test eax, eax      
    jnz convert_loop

    inc ecx             

print_result:
    mov eax, 4        
    mov ebx, 1          
    mov edx, buf        
    add edx, 20        
    sub edx, ecx       
    int 0x80

exit:
    mov eax, 1          
    xor ebx, ebx      
    int 0x80