; mov <dst>, <src>
; dst must be memory or register
; src must be memory, register, or immediate
; dst cannot be an immediate
; both dst and src cannot be memory
; if both dst and src are registers, must be same size

section .data
    a db 10;
    b db 10;
    c db -10;
    d db -10;
    e db 20;
    f db 20;
section .text
%include "../lib.asm"
global main
main:
    nop;
    ; moving a byte...
    mov rax, -1     ; rax = 0xffffffffffffffff
    mov al, [a]     ; read one byte at `a` into `al` byte register
                    ; rax = 0xffffffffffffff0a
                    ; higher order bits left untouched

    mov rax, -1     ; reset rax
    mov ax, [a]     ; read two bytes starting from `a` into `ax` byte register
                    ; rax = 0xffffffffffff0a0a
                    ; Interestingly, we copied two bytes from a into ax, .data section
                    ; is contigous in memory, so we copied both `a` and `b` into ax

    mov rax, -1     ; reset rax
    mov eax, [a]    ; read 4 bytes starting from `a` into `eax` byte register
                    ; rax = 0x00000000f6f60a0a
                    ; similar to above, we copied 4 bytes starting at `a` and
                    ; including `d` into `eax` since `eax` is a 32bit register.

    mov rax, -1     ; reset rax
    mov rax, [a]    ; read 8 bytes starting from `a` into `rax` byte register
                    ; rax = 0x00001414f6f60a0a
                    ; same deal, but copied 8 bytes of contiguous memory now.

    mov rax, -1     ; reset rax

    ; now, we want to move the byte 'a' into rax, but **only** this byte.
    movzx rax, byte [a] ; move only a byte from 'a' into rax, and zero extend all high order bits
                        ; this assumes `a` is a unsigned integer.
                        ; rax = 0x000000000000000a

    ; now, lets do the same thing for a signed integer
    ; we can't zero extend or else we'll return the signed integer into an
    ; unsigned integer, but we can sign extend.
    xor rax, rax        ; set rax to all zeros
    movsx rax, byte [c] ; set rax to `c` and sign extend to 64bits
                        ; rax = 0xfffffffffffffff6 (-10 in two's compliment)

    xor rax, rax        ; set rax to all zeros
    movsx rax, byte [a] ; set rax to `a` and sign extend to 64bits
                        ; rax = 0x000000000000000a (10 in two's compliment)

    call sys_exit
