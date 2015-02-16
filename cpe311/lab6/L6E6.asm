Assume cs:code, ds:data, ss:stack

data segment
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

MOV DX,141H ; specify port B
MOV AL,0FFH ; 1111 1111 , all outputs
OUT DX,AL 

MOV DX,143H ; specify control register
MOV AL,03H ; operation mode
OUT DX,AL

MOV DX,141H ;set to port B
MOV AL,42H ; 0111 1111


up:
not al
start:
MOV BX,0FH
MOV CX,0FFFFH
outer:
MOV CX,0FFFFH

wasteTime: ; loop 1
NOP ; no operation
loop wasteTime ; loop 2
DEC BX 
JNZ wasteTime
OUT DX,AL ;send on signal

jMP UP

code ends
end begin