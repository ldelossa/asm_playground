; This assembly program will show how to call a glibc function, printf
; from assembly.
section .data
    hello_fmt db "Hello %s!",0; 10 bytes
    arg db "Assembler",0; 10 bytes

section .text
%include "../lib.asm"
global main
extern printf ; forward declaration of printf which will be linked later by gcc.
main:
    nop
    ; setup stack frame
    push rbp
    mov  rbp, rsp

    ; setup args
    mov rdi, hello_fmt; lea could be used here too: lea rdi [hello_fmt]
    mov rsi, arg

    call printf

    ; cleanup stack
    pop rbp

    ; return success
    xor rax, rax;
    ret

