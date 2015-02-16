Assume cs:code, ds:data, ss:stack

data segment
message db "Lab 5 Exercise 1$" ;changed message to specified message
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

mov ah, 2 ;removed the line to output contents in dl only

mov si, offset message
mov bx, 0 ;set bx to zero

abc: ;loop title to display entire message
mov dl, [si+bx]
cmp dl, "$"
je end_prog
int 21h
inc bx
jmp abc

end_prog:
mov ah, 4ch
int 21h


code ends
end begin

