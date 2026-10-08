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

    resultMsg db 13,10, "X = 5*a + c*b = ", 0

.data?
    a DD ?
    b DD ?
    _c DD ?

    x DD ?

    buffer db 10 DUP(?)
    resultStr db 16 DUP(?)

.code
start:
    Invoke StdOut, addr aRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov a, EAX

    Invoke StdOut, addr bRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov b, EAX

    Invoke StdOut, addr cRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov _c, EAX

    mov EAX, a
    mov EBX, 5
    imul EBX
    mov ECX, EAX

    mov EAX, _c
    imul b
    add EAX, ECX

    mov x, EAX

    Invoke dwtoa, EAX, addr resultStr
    Invoke StdOut, addr resultMsg
    Invoke StdOut, addr resultStr

    Invoke ExitProcess, 0
end start
