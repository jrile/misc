Assume cs:code, ds:data, ss:stack

data segment
msg db "Lab 7 Exercise 2$"
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

mov si, offset msg
call print
call delay1sec
mov si, offset msg
call print

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

delay1sec:
push ax
push dx

MOV BX,0FH
outer:
MOV CX,0ECBEH ; (4 cycles) 

wasteTime: ; loop 1  3 + 17 = 20
NOP ; no operation (3 cycles)
loop wasteTime ; loop 2 (17 cycles)
; 20 * CX

DEC BX ; (2 cycles)
JNZ wasteTime ; (16 cycles)

POP DX
POP AX
RET

code ends
end begin
