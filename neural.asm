section .data
    alpha dq 0.01
    one dq 1.0
    buf db 10, 0
    log2_e dq 1.44269504088896340736  
    ln_2   dq 0.69314718055994530942 
    number dq 16 

section .text
    global _start

; rdi, rsi, rdx, rcx, r8, and r9
leaky_relu:
    mov rax, rdi

    cmp rax, 0
    jge positive

    imul rax, qword [alpha]

positive:
    ret

leaky_relu_derivative:
    movsd xmm1, xmm0

    xorpd xmm2, xmm2

    comisd xmm1, xmm2 
    
    jae dpositive

    movsd xmm0, [alpha] 
    ret

dpositive:
    movsd xmm0, [one]
    ret
                                       
log2:
    push rbx
    bsr rax, rax

    pop rbx
    ret

natural_log:
    push rbx

    cvtsd2si rax, xmm0
    call log2
    cvtsi2sd xmm0, rax
    mulsd xmm0, [ln_2]

    pop rbx
    ret

crossentropy:
    movsd xmm2, xmm0
    movsd xmm0, xmm1

    call natural_log

    mulsd xmm0, xmm2
    xorpd xmm1, xmm1
    subsd xmm1, xmm0
    movsd xmm0, xmm1
    
    ret

_start:
    mov rdi, 4
    mov rsi, 4
    call crossentropy

    mov eax, 1
    xor ebx, ebx
    int 0x80

section .text:
    global _start   
    global leaky_relu_derivative
    global leaky_relu


 ld -m elf_i386 rstr.o -o rstr