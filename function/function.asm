section .data
    a db 10;
    b db 20;

section .text
%include "../lib.asm"

; Add will demonstrate a very simple function which requires a minimal
; stack frame.
;
; Because all its arguments are passed in registers and it does not need to
; update a passed reference, no `rbp` has to be setup.
;
; Additionally, it does not require the use of any of the callee saved registers
; so not pushing and restoring of additional registers are necessary.
global addFunc ; Add(dword int, dword int) qword int
addFunc:
    ; arg1 is in rdi, arg2 in rsi

    mov rax, rdi; move arg1 into rax
    add rax, rsi; add rsi to rax

    ret; save to simply return as `rsp` is still pointed to return address.

global _start
_start:
    nop
    ; setup argument registers
    ; If we did not use movzx and specify that [a] is a byte,
    ; yasm would actually copy 64bits started at `a` into rdi, which
    ; would include `b` as well and break the math operation.
    movzx rdi, byte [a]
    movzx rsi, byte [b]
    call addFunc

    ; exit syscall
    call sys_exit