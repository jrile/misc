Assume cs:code, ds:data, ss:stack

data segment
going_up db 1 
going_down db 1 
keyboard_input db 1
direction db 1
current_floor db 1
goodbye1 db "You have arrived at floor "
goodbye2 db ". Have a nice day!"
data ends

stack segment
dw 100 dup(?)
stacktop:
stack ends

code segment
begin:

MOV DX,143H ; specify control register
MOV AL,02H ; direction mode
OUT DX,AL ; send to dx

MOV DX,140H ; specify port A
MOV AL,00H ; all inputs
OUT DX,AL 

mov dx, 141h ; specify port b
mov al, 0ffh ; all outputs
out dx, al

; set port c to all outputs
mov dx, 142h 
mov al, 0ffh
out dx, al

MOV DX,143H ; specify control register
MOV AL,03H ; operation mode
OUT DX,AL

mov dx, 141h ; specify port A

mov current_floor, 1 ; set floor to 1 initially.
mov direction, 1 ; set elevator to up initially.

; light up floor 1

move_elevator:
call check_input



cmp direction, 1
je move_up
jmp move_down


move_up:
inc current_floor
cmp current_floor, 2
je light_floor_2
cmp current_floor, 3
je light_floor_3
cmp current_floor, 4
je light_floor_4
cmp current_floor, 5
je light_floor_5

move_down:
dec current_floor
cmp current_floor, 1
je light_floor_1
cmp current_floor, 2
je light_floor_2
cmp current_floor, 3
je light_floor_3
cmp current_floor, 4
je light_floor_4

light_floor_1:
mov al, 11111110b
out dx, al 
mov direction, 1
jmp move_elevator

light_floor_2:
mov al, 11111101b
out dx, al
jmp move_elevator

light_floor_3:
mov al, 11111011b
out dx, al
jmp move_elevator

light_floor_4:
mov al, 11110111b
out dx, al
jmp move_elevator

light_floor_5:
mov al, 11101111b
out dx, al
mov direction, 0
jmp move_elevator


check_input:
push ax
push dx
push cx

MOV BX,19h
outer:
MOV CX,0ffffh 

inner: 
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
NOP
loop inner; 


DEC BX 
JNZ outer 

pop cx
POP DX
POP AX
RET


code ends
end begin