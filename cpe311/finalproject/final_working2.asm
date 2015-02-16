Assume cs:code, ds:data, ss:stack

data segment
internal_calls db 11111111b ; keyboard input
external_calls db 11111111b
kb_input db 100 dup(?)
direction db 11011111b ; 11011111b for up, 10111111b for down
current_floor db 11111110b
temp_button_pressed db 0ffh
prompt db "Please enter up to 3 floors. Press enter when done.$"
goodbye1 db "You have arrived at floor 1. Have a nice day!$"
goodbye2 db "You have arrived at floor 2. Have a nice day!$"
goodbye3 db "You have arrived at floor 3. Have a nice day!$"
goodbye4 db "You have arrived at floor 4. Have a nice day!$"
goodbye5 db "You have arrived at floor 5. Have a nice day!$"
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

mov dx, 142h
mov al, 0ffh
out dx, al

mov dx, 140h ; specify port A

mov current_floor, 11111110b ; set floor to 1 initially.
mov direction, 11011111b ; set elevator to up initially.

mov dx, 141h
mov al, 0ffh
out dx, al

mov dx,142h
mov al,current_floor
out dx,al


;mov dx,142h
;mov al,0ffh
;out dx,al


mov dx, 140h

move_elevator:
jmp check_input
input_checked:
jmp check_waiting
waiting_checked:
mov dx, 142h
cmp internal_calls, 11111111b
jne call_waiting
no_internal:
cmp external_calls, 11111111b
je move_elevator
call_waiting:
cmp direction, 11011111b
je move_up
jmp move_down


check_waiting:
cmp current_floor, 11111110b
je waiting_one
cmp current_floor, 11111101b
je waiting_two
cmp current_floor, 11111011b
je waiting_three
cmp current_floor, 11110111b
je waiting_four
cmp current_floor, 11101111b
je waiting_five
jmp waiting_checked

waiting_one:
mov cl, internal_calls
or cl, 11111110b
cmp cl, current_floor
je getting_off_one
done_getting_off_one:
mov cl, external_calls
or cl, 11111110b
cmp cl, current_floor
je clear_one
jmp waiting_checked

getting_off_one:
or internal_calls, 00000001b
mov si, offset goodbye1
call print
call print_new_line
jmp done_getting_off_one


waiting_two:
mov cl, internal_calls
or cl, 11111101b
cmp cl, current_floor
je getting_off_two
done_getting_off_two:
mov cl, external_calls
or cl, 11111101b
cmp cl, 11111101b
je clear_two
mov cl, external_calls
or cl, 11111011b
cmp cl, 11111011b
je clear_two
jmp waiting_checked

getting_off_two:
or internal_calls, 00000010b
mov si, offset goodbye2
call print
call print_new_line
jmp done_getting_off_two

waiting_three:
mov cl, internal_calls
or cl, 11111011b
cmp cl, current_floor
je getting_off_three
done_getting_off_three:
mov cl, external_calls
or cl, 11110111b
cmp cl, 11110111b
je clear_three
mov cl, external_calls
or cl, 11101111b
cmp cl, 11101111b
je clear_three
jmp waiting_checked

getting_off_three:
or internal_calls, 00000100b
mov si, offset goodbye3
call print
call print_new_line
jmp done_getting_off_three

waiting_four:
mov cl, internal_calls
or cl, 11110111b
cmp cl, current_floor
je getting_off_four
done_getting_off_four:
mov cl, external_calls
or cl, 11011111b
cmp cl, 11011111b
je clear_four
mov cl, external_calls
or cl, 10111111b
cmp cl, 10111111b
je clear_four
jmp waiting_checked

getting_off_four:
or internal_calls, 00001000b
mov si, offset goodbye4
call print
call print_new_line
jmp done_getting_off_four

waiting_five:
mov cl, internal_calls
or cl, 11101111b
cmp cl, current_floor
je getting_off_five
done_getting_off_five:
mov cl, external_calls
or cl, 01111111b
cmp cl, 01111111b
je clear_five
jmp waiting_checked

getting_off_five:
or internal_calls, 00010000b
mov si, offset goodbye5
call print
call print_new_line
jmp done_getting_off_five


clear_one:
push ax
push dx
or external_calls, 00000001b
mov al,external_calls
mov dx, 141h
out dx,al
call get_keyboard
pop dx
pop ax
jmp waiting_checked


clear_two:
push ax
push dx
or external_calls, 00000110b
mov al, external_calls
mov dx, 141h
out dx, al
call get_keyboard
pop dx
pop ax
jmp waiting_checked

clear_three:
push ax
push dx
or external_calls, 00011000b
mov al, external_calls
mov dx, 141h
out dx, al
call get_keyboard
pop dx
pop ax
jmp waiting_checked

clear_four:
push ax
push dx
or external_calls, 01100000b
mov al, external_calls
mov dx, 141h
out dx, al
call get_keyboard
pop dx
pop ax
jmp waiting_checked

clear_five:
push ax
push dx
or external_calls, 10000000b
mov al, external_calls
mov dx, 141h
out dx, al
call get_keyboard
pop dx
pop ax
jmp waiting_checked

get_keyboard proc
push ax
push dx
mov si, offset prompt
call print

mov ah, 1 ;set up for input command. screen echoing

mov di, offset kb_input	;points to string
mov cx,3h
input: ;loop to get input
int 21h
mov [di],al	;transfer input to string
cmp al, 0Dh	;once carriage return, stop
je reset	;jump to reset
inc di
loop input

reset:	;resets di to point to storage
call print_new_line
mov dl,"$"	;temp storage
mov [di],dl	;replace carriage return with $ end mark
mov di, offset kb_input	;reset pointer

; check input here (up to $)

check_kb_input_string:
mov dl, [di]
cmp dl, "$"
je end_proc
cmp dl, "1"
je kb_one
cmp dl, "2"
je kb_two
cmp dl, "3"
je kb_three
cmp dl, "4"
je kb_four
cmp dl, "5"
je kb_five
jmp end_proc

kb_one:
and internal_calls, 11111110b
inc di
jmp check_kb_input_string

kb_two:
and internal_calls, 11111101b
inc di
jmp check_kb_input_string

kb_three:
and internal_calls, 11111011b
inc di
jmp check_kb_input_string

kb_four:
and internal_calls, 11110111b
inc di
jmp check_kb_input_string

kb_five:
and internal_calls, 11101111b
inc di
jmp check_kb_input_string

end_proc:
pop dx
pop ax
ret
get_keyboard endp






move_up:
;mov direction,11011111b
ROL current_floor, 1
cmp current_floor, 11111101b
je light_floor_2
cmp current_floor, 11111011b
je light_floor_3
cmp current_floor, 11110111b
je light_floor_4
cmp current_floor, 11101111b
je light_floor_5
jmp move_elevator

move_down:
;mov direction,10111111b
ROR current_floor, 1
cmp current_floor, 11111110b
je light_floor_1
cmp current_floor, 11111101b
je light_floor_2
cmp current_floor, 11111011b
je light_floor_3
cmp current_floor, 11110111b
je light_floor_4
jmp move_elevator

light_floor_1:
push ax
mov direction, 11011111b
mov al, 11011110b
out dx, al 
pop ax
jmp move_elevator

light_floor_2:
push ax
mov al, 11111101b
and al,direction
out dx, al
pop ax
jmp move_elevator

light_floor_3:
push ax
mov al, 11111011b
and al,direction
out dx, al
pop ax
jmp move_elevator

light_floor_4:
push ax
mov al, 11110111b
and al,direction
out dx, al
pop ax
jmp move_elevator

light_floor_5:
push ax
mov al, 10101111b
out dx, al
pop ax
mov direction, 10111111b
jmp move_elevator


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
; make a print new line function?
mov dl, 0dh
int 21h
mov dl, 0ah
int 21h
pop dx
pop ax
ret

print_new_line proc
push ax
push dx
mov ah, 2
mov dl, 0dh
int 21h
mov dl, 0ah
int 21h
pop dx
pop ax
ret
print_new_line endp


check_input:
push dx
push cx
;push ax
MOV BX,18h
outer:
MOV CX,0fffeh 

inner: 
mov dx,140h
in al, dx
and al, 0ffh
cmp al, 0ffh
jne button_pressed
done_with_button_pressed:
loop inner; 

DEC BX 
JNZ outer 

;pop ax
POP cx
POP dx
jmp input_checked

button_pressed:
;mov temp_button_pressed,al
;pop ax
;and al,temp_button_pressed
and external_calls,al
mov al,external_calls
mov dx, 141h
out dx,al
;push ax
jmp done_with_button_pressed


code ends
end begin