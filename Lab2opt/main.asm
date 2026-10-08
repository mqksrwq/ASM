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
    buffer db 10 DUP(?)
    resultStr db 16 DUP(?)

.code
start:
    xor EBX, EBX

    Invoke StdOut, addr aRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    movsx ECX, AX

    push ECX
    Invoke StdOut, addr bRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    movsx EDX, AX
    pop ECX

    push ECX
    push EDX
    Invoke StdOut, addr cRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    pop EDX
    pop ECX
    movsx EAX, AX

    push EAX
    push ECX
    push EDX
    Invoke StdOut, addr resultMsg
    pop EDX
    pop ECX
    pop EAX

    cmp ECX, 1
    jl SkipA
    cmp ECX, 10
    jg SkipA
    push EAX
    push ECX
    push EDX
    Invoke dwtoa, ECX, addr resultStr
    Invoke StdOut, addr aName
    Invoke StdOut, addr resultStr
    Invoke StdOut, addr newLine
    pop EDX
    pop ECX
    pop EAX
    inc EBX
SkipA:
    cmp EDX, 1
    jl SkipB
    cmp EDX, 10
    jg SkipB
    push EAX
    push ECX
    push EDX
    Invoke dwtoa, EDX, addr resultStr
    Invoke StdOut, addr bName
    Invoke StdOut, addr resultStr
    Invoke StdOut, addr newLine
    pop EDX
    pop ECX
    pop EAX
    inc EBX
SkipB:
    cmp EAX, 1
    jl SkipC
    cmp EAX, 10
    jg SkipC
    push EAX
    push ECX
    push EDX
    Invoke dwtoa, EAX, addr resultStr
    Invoke StdOut, addr cName
    Invoke StdOut, addr resultStr
    Invoke StdOut, addr newLine
    pop EDX
    pop ECX
    pop EAX
    inc EBX
SkipC:
    cmp EBX, 0
    jne Finish
    Invoke StdOut, addr noneMsg
Finish:
    Invoke ExitProcess, 0
end start
