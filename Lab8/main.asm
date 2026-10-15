.586
.model flat, stdcall
option casemap:none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

SetEven MACRO var
    or var, 55555555h
ENDM

Div8 MACRO var
    shr var, 3
ENDM

SwapHalves MACRO var
    ror var, 16
ENDM

ShowBin MACRO var, caption
    LOCAL BinLoop
    Invoke StdOut, addr caption
    mov edx, var
    lea edi, binStr
    mov ecx, 32
BinLoop:
    shl edx, 1
    mov al, '0'
    adc al, 0
    mov [edi], al
    inc edi
    loop BinLoop
    mov byte ptr [edi], 0
    Invoke StdOut, addr binStr
ENDM

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
    mov xv, eax

    ShowBin xv, m1

    SetEven xv
    ShowBin xv, m2

    Div8 xv
    ShowBin xv, m3

    SwapHalves xv
    ShowBin xv, m4

    Invoke StdOut, addr newLine
    Invoke ExitProcess, 0
end start
