section .data
    a db 10
    b db 0x0A
    c db -1
    d db -2
section .text
    global _start
_start:
    mov r11b, [a];
    add r11b, [b];
    add r11b, [c];
    add r11b, [d];
    nop;