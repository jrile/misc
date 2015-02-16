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
call delay ; debouncing
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


delay:
push ax
push dx
push cx

MOV BX,0FH
outer:
MOV CX,0FH ; (4 cycles) 

wasteTime: ; loop 1  3 + 17 = 20
NOP ; no operation (3 cycles)
loop wasteTime ; loop 2 (17 cycles)
; 20 * CX

DEC BX ; (2 cycles)
JNZ wasteTime ; (16 cycles)

pop cx
POP DX
POP AX
RET


code ends
end begin