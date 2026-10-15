.586
.model flat, stdcall
option casemap:none

include \masm32\include\masm32.inc
include \masm32\include\kernel32.inc

includelib \masm32\lib\masm32.lib
includelib \masm32\lib\kernel32.lib

Split PROTO :DWORD, :DWORD, :DWORD

.data
    sRequest db "Input string S: ", 0
    s1Msg db 13,10, "S1 (letters): ", 0
    s2Msg db 13,10, "S2 (digits):  ", 0
    newLine db 13,10, 0

.data?
    s db 100 DUP(?)
    s1 db 100 DUP(?)
    s2 db 100 DUP(?)

.code
start:
    Invoke StdOut, addr sRequest
    Invoke StdIn, addr s, LengthOf s
    Invoke StripLF, addr s

    Invoke Split, addr s, addr s1, addr s2

    Invoke StdOut, addr s1Msg
    Invoke StdOut, addr s1
    Invoke StdOut, addr s2Msg
    Invoke StdOut, addr s2
    Invoke StdOut, addr newLine

    Invoke ExitProcess, 0

Split PROC USES ebx esi edi src:DWORD, letters:DWORD, digits:DWORD
    mov esi, src
    mov edi, letters
    mov ebx, digits
    cld

NextChar:
    lodsb
    cmp al, 0
    je Finish

    cmp al, '0'
    jb NextChar
    cmp al, '9'
    jbe IsDigit

    cmp al, 'A'
    jb NextChar
    cmp al, 'Z'
    jbe IsLetter

    cmp al, 'a'
    jb NextChar
    cmp al, 'z'
    ja NextChar

IsLetter:
    stosb
    jmp NextChar

IsDigit:
    mov [ebx], al
    inc ebx
    jmp NextChar

Finish:
    mov byte ptr [edi], 0
    mov byte ptr [ebx], 0
    ret
Split ENDP

end start
