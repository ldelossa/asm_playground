section .data
    fmt db "Program Name: %s Args: %s"
section .text
global main
extern printf ; use printf function to display arguments
main:
    nop
    ; setup stack pointer
    push rbp
    mov rbp, rsp

    ; keep a pointer to argv in r10
    mov r10, rsi

    mov rdi, fmt     ; 1st arg is format string
    mov rsi, [r10]   ; 2nd arg is argv[0] = char *
    mov rdx, [8+r10] ; 3rd arg is argv[1] = char *

    ; first argument to main will be in rdi so
    ; we can send that directly to printf
    call printf;

    ; clean stack
    add rsp, 8

    ; return success
    xor rax,rax
    ret