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

Mov ah,2
Mov dl,'C'
Int 21h

Mov dl,'p'
Int 21h

mov dl, 'E'
int 21h

mov dl, '3'
int 21h

mov dl,'1'
int 21h

mov dl,'1'
int 21h

mov ah,4ch
int 21h

code ends
end begin

