Assume cs:code, ds:data, ss:stack

data segment
b1 db "Button One Pressed$"
b2 db "Button Two Pressed$"
b3 db "Button Three Pressed$"
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


MOV DX,143H ; specify control register
MOV AL,02H ; direction mode
OUT DX,AL ; send to dx

MOV DX,140H ; specify port A
MOV AL,00H ; all inputs
OUT DX,AL 

MOV DX,143H ; specify control register
MOV AL,03H ; operation mode
OUT DX,AL


MOV DX,140H ;set to port A
prog:
in al, dx
and al, 00001111b

; compare the input (if any)
cmp al, 00001111b
je prog

cmp al, 1110b
je first_button

cmp al, 1101b
je second_button

cmp al, 1011b
je third_button

jmp end_prog ; if button 1,2,3 & no buttons are pressed, then end

first_button:
mov si, offset b1 ; move offset to button 1
call print ; print it
call delay1sec
jmp prog ; loop

second_button:
mov si, offset b2 ; move offset to button 2
call print ; print it
call delay1sec
jmp prog ; loop

third_button:
mov si, offset b3 ; move offset to button 3
call print ; print it
call delay1sec
jmp prog ; loop

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
