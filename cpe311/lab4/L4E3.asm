Assume cs:code, ds:data, ss:stack

data segment
message db "Hello World$"
var db "w"
data ends

stack segment
dw 100 dup(?)
stacktop:
stack ends

code segment
begin:
Mov ax,data
Mov ds,ax
Mov ax,stack
Mov ss,ax
Mov sp, offset stacktop

mov ah, 2
mov dl, message
int 21h

mov si, offset message

abc:
mov dl, [si]
cmp dl, "$"
je end_prog
int 21h
inc si
jmp abc

end_prog:
mov ah, 4ch
int 21h


code ends
end begin

