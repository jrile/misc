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
IN AL,DX	;get input
AND AL,0FH	;mask input

code ends
end begin