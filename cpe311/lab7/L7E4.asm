Assume cs:code, ds:data, ss:stack

data segment
b1 db "Pattern 1 was chosen$"
b2 db "Pattern 2 was chosen$"
b3 db "Pattern 3 was chosen$"
intro db "Please choose from the following list by pushing the correspoding push-button:$"
option1 db "1 - Alternating Lights$"
option2 db "2 - The Running Light$"
option3 db "3 - Running Forth and Back$"
option4 db "4 - Exit program$"
goodbye db "Good bye$"
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


; print welcome message
mov si, offset intro
call print
mov si, offset option1
call print
mov si, offset option2
call print
mov si, offset option3
call print
mov si, offset option4
call print

MOV DX,143H ; specify control register
MOV AL,02H ; direction mode
OUT DX,AL ; send to dx

MOV DX,140H ; specify port A
MOV AL,00H ; all inputs
OUT DX,AL 

mov dx, 141h ; specify port b
mov al, 0ffh ; all outputs
out dx, al

MOV DX,143H ; specify control register
MOV AL,03H ; operation mode
OUT DX,AL



prog:
MOV DX,140H ;set to port A
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
; alternating lights
mov si, offset b1 ; move offset to button 1
call print ; print it
call delay1sec

mov dx, 141h;
mov al, 42h
out dx,al
call delay1sec
not al
call delay1sec
OUT DX,AL ;send on signal

jmp prog ; loop

second_button:
; the running light
mov si, offset b2 ; move offset to button 2
call print ; print it
call delay1sec
mov cx,08h
mov dx, 141h
mov al, 7fh
output:
out dx,al
ror al,1
call delay1sec
loop output
jmp prog ; loop

third_button:
; running forth and back
mov si, offset b3 ; move offset to button 3
call print ; print it
call delay1sec
mov cx,7h
mov dx, 141h
mov al, 7fh
right:
out dx,al
ror al,1
call delay1sec
loop right

mov cx,8h
left:
out dx,al
rol al,1
call delay1sec
loop left

jmp prog ; loop

end_prog:
; 4th button, exit
mov si, offset goodbye
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
push cx

MOV BX,0FH
outer:
MOV CX,0ECBEH ; (4 cycles) 

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
