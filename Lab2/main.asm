.586
.model flat, stdcall
option casemap:none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.data
    aRequest db "Input a: ", 0
    bRequest db "Input b: ", 0
    cRequest db "Input c: ", 0

    resultMsg db 13,10, "Numbers from 1 to 10:", 13,10, 0
    noneMsg db "none", 13,10, 0

    aName db "a = ", 0
    bName db "b = ", 0
    cName db "c = ", 0

    newLine db 13,10, 0

.data?
    a DW ?
    b DW ?
    _c DW ?

    cnt DW ?

    buffer db 10 DUP(?)
    resultStr db 16 DUP(?)

.code
start:
    Invoke StdOut, addr aRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov a, AX

    Invoke StdOut, addr bRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov b, AX

    Invoke StdOut, addr cRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov _c, AX

    mov cnt, 0
    Invoke StdOut, addr resultMsg

    mov AX, a
    cmp AX, 1
    jl SkipA
    cmp AX, 10
    jg SkipA
    movsx EAX, a
    Invoke dwtoa, EAX, addr resultStr
    Invoke StdOut, addr aName
    Invoke StdOut, addr resultStr
    Invoke StdOut, addr newLine
    inc cnt
SkipA:
    mov AX, b
    cmp AX, 1
    jl SkipB
    cmp AX, 10
    jg SkipB
    movsx EAX, b
    Invoke dwtoa, EAX, addr resultStr
    Invoke StdOut, addr bName
    Invoke StdOut, addr resultStr
    Invoke StdOut, addr newLine
    inc cnt
SkipB:
    mov AX, _c
    cmp AX, 1
    jl SkipC
    cmp AX, 10
    jg SkipC
    movsx EAX, _c
    Invoke dwtoa, EAX, addr resultStr
    Invoke StdOut, addr cName
    Invoke StdOut, addr resultStr
    Invoke StdOut, addr newLine
    inc cnt
SkipC:
    cmp cnt, 0
    jne Finish
    Invoke StdOut, addr noneMsg
Finish:
    Invoke ExitProcess, 0
end start
