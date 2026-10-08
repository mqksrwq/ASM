.586
.model flat, stdcall
option casemap:none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.data
    mRequest db "Input m: ", 0

    resultMsg db 13,10, "Max k (2*k < m): ", 0

.data?
    m DW ?
    k DW ?

    buffer db 10 DUP(?)
    resultStr db 16 DUP(?)

.code
start:
    Invoke StdOut, addr mRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov m, AX

    movsx EBX, m
    mov EDX, 0
    movsx ECX, m
Up:
    mov EAX, EDX
    imul EAX, 2
    cmp EAX, EBX
    jge Found
    inc EDX
    loop Up

Found:
    dec EDX

    mov k, DX

    movsx EAX, k
    Invoke dwtoa, EAX, addr resultStr
    Invoke StdOut, addr resultMsg
    Invoke StdOut, addr resultStr

    Invoke ExitProcess, 0
end start
