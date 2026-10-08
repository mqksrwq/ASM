.586
.model flat, stdcall
option casemap:none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

.data
    xRequest db "Input X: ", 0
    m1 db 13,10, "X              = ", 0
    m2 db 13,10, "Even bits set  = ", 0
    m3 db 13,10, "Divided by 8   = ", 0
    m4 db 13,10, "Halves swapped = ", 0
    newLine db 13,10, 0

.data?
    xv DD ?

    buffer db 16 DUP(?)
    binStr db 33 DUP(?)

.code
start:
    Invoke StdOut, addr xRequest
    Invoke StdIn, addr buffer, LengthOf buffer
    Invoke StripLF, addr buffer
    Invoke atol, addr buffer
    mov xv, EAX

    Invoke StdOut, addr m1
    mov EDX, xv
    call ShowBin
    Invoke StdOut, addr binStr

    mov EDX, xv
    or EDX, 55555555h
    mov xv, EDX
    Invoke StdOut, addr m2
    mov EDX, xv
    call ShowBin
    Invoke StdOut, addr binStr

    mov EDX, xv
    shr EDX, 3
    mov xv, EDX
    Invoke StdOut, addr m3
    mov EDX, xv
    call ShowBin
    Invoke StdOut, addr binStr

    mov EDX, xv
    ror EDX, 16
    mov xv, EDX
    Invoke StdOut, addr m4
    mov EDX, xv
    call ShowBin
    Invoke StdOut, addr binStr

    Invoke StdOut, addr newLine
    Invoke ExitProcess, 0

ShowBin:
    lea EDI, binStr
    mov ESI, 32
BinNext:
    shl EDX, 1
    mov AL, '0'
    adc AL, 0
    mov [EDI], AL
    inc EDI
    dec ESI
    jnz BinNext
    mov BYTE PTR [EDI], 0
    ret
end start
