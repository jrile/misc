Assume cs:code, ds:data, ss:stack

data segment
message db "Lab 5 Exercise 1$" ;changed message to specified message
var db "w"
storage db 17 dup(" ")
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
mov di, offset storage	;points to storage

load: ;loop title to display entire message
mov dl,[si]	;use dl as temp storage to transfer
mov [di], dl	;send dl to [di]
cmp dl, "$"
je reset	;once copied, jump to reset
inc si
inc di
jmp load

reset:	;resets di to point to storage
mov di, offset storage

abc: ;loop title to display entire message
mov dl, [di]
cmp dl, "$"
je end_prog
int 21h
inc di
jmp abc

end_prog:
mov ah, 4ch
int 21h


code ends
end begin

