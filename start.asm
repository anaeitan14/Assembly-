data segment
  msg1 db "Welcome to Simon Says!",10,13,'$'
  msg2 db "Press ENTER to start the game",10,13,'$'
  clock equ es:6Ch
  leftClick db "Left button clicked",10,13,'$'
  rightClick db "Right button clicked",10,13,'$'
  
  
data ends

sseg segment stack
  DW 100 dup (?)
sseg ends

code segment

assume cs:code,ds:data,ss:sseg

start:   mov ax,data
         mov ds,ax
		 
		 call startGame
		 call waitEnter
		 mov cx, 5
		 
print:   call random	
		 loop print
		 
		 call clickMouse
		 
 

exit:    mov ah,4ch
         int 21h



startGame proc
		 mov ah, 9h
		 
		 lea dx, msg1
		 int 21h
		 
		 lea dx, msg2
		 int 21h
		 
		 ret
		 
startGame endp


waitEnter proc





		ret
waitEnter endp


		 
		 
proc delay
	mov ax, 40h
	mov es, ax
	mov ax, [clock]
FirstTick:
	cmp ax, [clock]
	je firstTick
	mov cx, 18
	
DelayLoop:
	mov ax, [clock]
Tick:
	cmp ax, [clock]
	je Tick
	loop DelayLoop
	ret
delay endp	


proc random
		mov ax, 40h
		mov es, ax 
		call delay
		mov ax, [clock]
		mov ah, [byte ptr cs:bx]
		inc bx
		xor al, ah
		and al, 00000011b
		inc al
		add al, '0'
		mov dl, al
		
		 
		mov ah, 2h   ; call interrupt to display a value in dl
		int 21h 
		ret
random endp


clickMouse proc
		 mov ax, 13h ;Graphic mode
		 int 10h
		 
		 mov ax, 0h ;Reset mouse
		 int 33h
		 
		 mov ax, 1h ;Display mouse to user
		 int 33h
		 
click:
		 mov ax, 3h ;Result to be displayed in BX, is LSB=1 Left click, if left to LSB=1 Rightclick
		 int 33h	;If both = 0, no click at all
					;CX holds column coordinate, 0-629, must divide by 2 because graphic is 320
					;DX holds row coordinate 0-199
		
		
		
		cmp bx,01h
		jne click
		mov dx, offset leftClick
		mov ah,9
		int 21h
		
			
		mov ah, 00h
		int 16h
		
			
		mov ax, 3h
		int 10h
		
		ret


clickMouse endp


code ends
end start


