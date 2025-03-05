section .data
    num equ 16
    fizz db "fizz", 10
    fizz_len equ $ - fizz

    buzz db "buzz", 10
    buzz_len equ $ - buzz

    fizzbuzz db "fizzbuzz", 10
    fizzbuzz_len equ $ - fizzbuzz                   
    buf db 10, 0

section .text
    global _start

_start:
    mov esi, 1
    xor eax, eax
    mov edi, num

fizz_buzz:
    cmp esi, edi

    jge loop_end
    xor ax, ax       ; Clear AX
    mov ax, si       
    mov bl, 3        
    div bl           
    cmp ah, 0       
    jne not_fb

    xor ax, ax       ; Clear AX
    mov ax, si
    xor dx, dx       
    mov bx, 5        
    div bx          
    cmp dx, 0        
    jne not_fb

    jmp print_fb

print_fb:
    mov eax, 4
    mov ebx, 1
    mov ecx, fizzbuzz
    mov edx, fizzbuzz_len
    int 0x80

    inc esi
    jmp fizz_buzz

not_fb:
    xor ax, ax
    mov ax, si
    mov bl, 3
    div bl
    cmp ah, 0
    je print_f

    xor ax, ax
    mov ax, si
    xor dx, dx
    mov bx, 5
    div bx
    cmp dx, 0
    je print_b

    ; neither fizz nor buzz
    mov [buf], esi
    mov al, [buf]
    add al, '0'
    mov [buf], al

    mov eax, 4
    mov ebx, 1
    mov ecx, buf
    mov edx, 1
    int 0x80

    inc esi
    jmp fizz_buzz

print_f:
    mov eax, 4
    mov ebx, 1
    mov ecx, fizz
    mov edx, fizz_len
    int 0x80

    inc esi
    jmp fizz_buzz

print_b:
    mov eax, 4
    mov ebx, 1
    mov ecx, buzz
    mov edx, buzz_len
    int 0x80

    inc esi
    jmp fizz_buzz

loop_end:
    mov eax, 1         
    xor ebx, ebx       
    int 0x80