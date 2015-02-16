Assume cs:code, ds:data, ss:stack

data segment
message db "Lab 5 Exercise 1$" ;changed message to specified message
var db "w"
storage db 20 dup(?) ;allocate room for string
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

mov ah, 1 ;set up for input command. screen echoing

mov di, offset storage	;points to string

input: ;loop to get input
int 21h
mov [di],al	;transfer input to string
cmp al, 0Dh	;once carriage return, stop
je reset	;jump to reset
inc di
jmp input

reset:	;resets di to point to storage
mov dl,"$"	;temp storage
mov [di],dl	;replace carriage return with $ end mark
mov di, offset storage	;reset pointer
mov ah,2	;function 2 for output
mov dl,0dh	;new line code block
int 21h	;
mov dl,0ah	;
int 21h	;end block

abc: ;loop to display entire message
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

