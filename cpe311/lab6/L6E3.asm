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

start:
MOV BX,0FH
MOV CX,0FFFFH
MOV AL,00H ;all on
outer:
MOV CX,0FFFFH
wasteTime: ; loop 1
NOP ; no operation
loop wasteTime ; loop 2
DEC BX 
JNZ wasteTime

OUT DX,AL ;send on signal
MOV AL,0FFH ;all off
MOV BX,0FH
MOV CX,0FFFFH
outer2:
MOV CX,0FFFFH
wasteTime2: ; loop 1
NOP ; no operation
loop wasteTime2 ; loop 2
DEC BX
JNZ wasteTime2

OUT DX,AL ;send off signal
jmp start ;repeat

code ends
end begin