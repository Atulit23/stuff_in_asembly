section .data
    till equ 7
    buf db 40, 0
    init equ 1
    fact db 1

section .text
    global _start

_start:
    xor esi, esi
    mov eax, 1
    mov [fact], eax

factorial:  
    cmp esi, till
    jge loop_end           
    inc esi                       

    mov eax, [fact]
    mul esi

    mov [fact], eax
    
    jmp factorial

loop_end:
    mov ebx, 10       
    mov ecx, buf      
    add ecx, 19       

convert_loop:
    xor edx, edx        
    div ebx             
    add dl, '0'         
    mov [ecx], dl       
    dec ecx             
    test eax, eax       
    jnz convert_loop    

    mov edx, buf        
    add edx, 19         
    sub edx, ecx        
    inc ecx             
    
    mov eax, 4          
    mov ebx, 1          
    push ecx            
    pop ecx             
    int 0x80

    mov eax, 1
    xor ebx, ebx
    int 0x80