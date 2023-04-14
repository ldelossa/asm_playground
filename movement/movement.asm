section .data
    a db 0xA;
section .text
global _start
_start:
    mov rax , -1;
    mov rax, qword [a];
    nop;