Assume cs:code, ds:data, ss:stack

data segment
message db 501 dup(?)
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

MOV DX,143H	;specify control register
MOV AL,02H	;direction mode
OUT DX,AL	;send to dx

MOV DX,140H	;specify port A
MOV AL,00H	;0000 0000, all outputs
OUT DX,AL 

MOV DX,143H	;specify control register
MOV AL,03H	;operation mode
OUT DX,AL

MOV DX,140H	;port A
mov cx, 500
mov si, offset message


buttonpress:
in al, dx
and al, 01h
cmp al, 0
jne buttonpress


buttonrelease:
in al, dx
and al, 01h
cmp al, 1
jne buttonrelease

loop1:
IN al,DX	;get input
mov [si], al
inc si
loop loop1
mov al, "$"
mov [si], al
mov si, offset message
call print



end_prog:
mov ah, 4ch 
int 21h


print:
push ax
push dx

mov ah, 2
abc: ;loop title to display entire message
mov dl, [si]
cmp dl, "$"
je end_loop
AND dl, 01H	;mask input
add dl, 30H
int 21h
inc si
jmp abc

end_loop:
mov dl, 0dh
int 21h
mov dl, 0ah
int 21h
pop dx
pop ax
ret

code ends
end begin