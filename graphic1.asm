data segment
	locx dw ?
	locy dw ?
	x dw ?
	y dw ?
	color dw ?
	godelsqw dw 80
	fixdel1 dw 1
	fixdel2 dw 86a0h
	sounddel1 dw 3
	sounddel2 dw 0d090h
	computerColors db 11 dup(?)
	userGuess db 11 dup(?)
	welcomeToGame db "Welcome to Simon Says!",10,13,'$'
	pressAnyKey db "Press ENTER to start the game",10,13,'$'
	gameOverMessage db "Game over :(",10,13,'$'
	gameWinnerMessage db "YOU WON :)",10,13,'$'
	clock equ es:6Ch
	userClickX dw ?
	userClickY dw ?
	currentTurn dw 1
	correctGuess db -1
	
data ends

sseg segment stack
  DW 500 dup (?) 
  
sseg ends

code segment

assume cs:code,ds:data,ss:sseg


proc	printPix
		push ax
		push bx
		push cx
		push dx
        xor bx, bx
		mov cx, [x]
        mov dx, [y]
        mov ax, [color]
        mov ah, 0ch
		int 10h
		pop dx
		pop cx
		pop bx
		pop ax
		ret
endp
proc printSqw
		
		push cx
		push [locy]
		pop [y]     ; y = locy
		mov cx, [godelsqw]
la2:
		push [locx]
		pop [x]     ; x = locx
		push cx
		mov cx, [godelsqw]
la1:
		call printPix
		inc [x]
		loop la1
		pop cx
		;loop1 end
		inc [y]
		loop la2
		;loop2 end
		pop cx
		ret
endp
proc printStart
		mov [color], 69h ;dark blue
		mov [locx], 80
		mov [locy], 10
		call printSqw
		 
		mov [color], 79h ;dark green
		mov [locx], 170
		mov [locy], 10
		call printSqw	
		
		mov [color], 70h ;dark red
		mov [locx], 80
		mov [locy], 100
		call printSqw	
		
		mov [color], 74h ;dark yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw
		ret
endp
proc pressBlue
		push ax
		push cx
		push dx
		in al, 61h	;open speacker
		or al, 3
		out 61h, al
		mov al, 0b6h
		out 43h, al
		mov al, 0cah ;c note
		out 42h, al
		mov al, 11h
		out 42h, al

		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		
		mov [color], 9 ;light blue
		mov [locx], 80
		mov [locy], 10
		call printSqw
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		mov ah, 86h
		int 15h
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		mov [color], 69h ;dark blue
		mov [locx], 80
		mov [locy], 10
		call printSqw
		pop dx
		pop cx
		pop ax
		ret
endp
proc pressGreen
		push ax
		push cx
		push dx
		in al, 61h	;open speacker
		or al, 3
		out 61h, al
		mov al, 0b6h
		out 43h, al
		mov al, 0dah ;d note
		out 42h, al
		mov al, 0fh
		out 42h, al

		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		
		mov [color], 10 ;light green
		mov [locx], 170
		mov [locy], 10
		call printSqw
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		mov ah, 86h
		int 15h
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		mov [color], 79h ;dark green
		mov [locx], 170
		mov [locy], 10
		call printSqw
		pop dx
		pop cx
		pop ax
		ret
endp
proc pressRed
		push ax
		push cx
		push dx
		in al, 61h	;open speacker
		or al, 3
		out 61h, al
		mov al, 0b6h
		out 43h, al
		mov al, 1fh	;e note
		out 42h, al
		mov al, 0eh
		out 42h, al

		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		
		mov [color], 12 ;light red
		mov [locx], 80
		mov [locy], 100
		call printSqw	
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		mov ah, 86h
		int 15h
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		mov [color], 70h ;dark red
		mov [locx], 80
		mov [locy], 100
		call printSqw	
		
		pop dx
		pop cx
		pop ax
		ret
endp
proc pressYellow
		push ax
		push cx
		push dx
		in al, 61h	;open speacker
		or al, 3
		out 61h, al
		mov al, 0b6h
		out 43h, al
		mov al, 5ah	;c note
		out 42h, al
		mov al, 0dh
		out 42h, al

		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		
		mov [color], 14 ;light yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw	
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		mov ah, 86h
		int 15h
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		mov ah, 86h
		int 15h
		
		mov [color], 74h ;dark yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw
		
		pop dx
		pop cx
		pop ax
		ret
endp
proc sleep05
		push ax
		push cx
		push dx
		mov cx,7h
		mov dx, 0a120h
		mov ah, 86h
		int 15h
		pop dx
		pop cx
		pop ax
		ret
endp
proc shaveAndHaircut
	call pressYellow
	mov [sounddel1], 0
	mov [sounddel2], 0c350h
	call pressBlue
	call pressBlue
	mov [sounddel1], 4
	mov [sounddel2], 93e0h
	call pressGreen
	mov [sounddel1], 0ch
	mov [sounddel2], 3500h
	call pressBlue
	mov [sounddel1], 4
	mov [sounddel2], 93e0h
	call pressRed
	mov [sounddel1], 0ch
	mov [sounddel2], 3500h
	call pressYellow
	mov [sounddel1], 4
	mov [sounddel2], 93e0h
	ret
endp

proc randomNumbers

		xor cx, cx
		xor si, si
		
		mov cx, 10
		mov si, 1
		
generateNum:
		mov ax, 40h
		mov es, ax 
		call sleep05
		mov ax, [clock]
		mov ah, [byte ptr cs:bx]
		inc bx
		xor al, ah
		and al, 00000011b
		inc al
		add al, '0'
		mov computerColors[si], al
		inc si
		loop generateNum
	
		
		ret
randomNumbers endp


proc numberSquare

	mov cx, currentTurn
	mov si, 1
	
printComputer:

	cmp computerColors[si], 49
	je Blue

	cmp computerColors[si], 50
	je Green

	cmp computerColors[si], 51
	je red

	cmp computerColors[si], 52
	je Yellow

	
	
Blue:
	call pressBlue
	jmp done
	
Green:
	call pressGreen
	jmp done
	
Red:
	call pressRed
	jmp done
	
Yellow:
	call pressYellow
	jmp done
	
done:
	inc si
	loop printComputer
	
	ret
endp numberSquare


proc handleMouse
		 mov ax, 0h ;Reset mouse
		 int 33h
		 
		 mov ax, 1h ;Display mouse to user
		 int 33h
		 
click:
		 mov ax, 3h ;Result to be displayed in BX, is LSB=1 Left click, if left to LSB=1 Rightclick
		 int 33h	;If both = 0, no click at all
					;CX holds column coordinate, 0-629, must divide by 2 because graphic is 320
					;DX holds row coordinate 0-199
		
		cmp bx, 0
		je click
		
		shr cx, 1 ; divide cx by 2
		
		mov userClickX, cx
		mov userClickY, dx
	
		ret
handleMouse endp


proc getSquareNumber
	
	cmp userClickX, 160
	jbe blueRedClick
	cmp userClickY, 90
	jbe greenClick
	call pressYellow
	mov userGuess[si], '4'
	jmp sofp
	
	
blueRedClick:
	cmp userClickY, 90
	jbe blueClick
	call pressRed
	mov userGuess[si], '3'
	jmp sofp

blueClick:
	call pressBlue
	mov userGuess[si], '1'
	jmp sofp
	
greenClick:
		call pressGreen
		mov userGuess[si], '2'
sofp:
	ret
	
endp getSquareNumber


proc showMenu
	mov dx, offset welcomeToGame
	mov ah, 9h
	int 21h
	
	mov dx, offset pressAnyKey
	mov ah, 9h
	int 21h
	
	xor ah, ah
	int 16h

	ret
	
endp showMenu

proc checkRightSquare

	mov ah, computerColors[si]
	cmp ah, userGuess[si]
	jne stopCheck
	jmp goBack
	
stopCheck:
	mov correctGuess, 0
	
goBack:	
	ret
	
checkRightSquare endp
	

proc userTurn
	mov cx, currentTurn
	mov si, 1
	
turnLoop:
	push cx
	call handleMouse	
	call getSquareNumber
	call checkRightSquare
	cmp correctGuess, 0 
	je doneTurn
	pop cx
	inc si
	loop turnLoop
	
doneTurn:
	ret

userTurn endp


start:  
	mov ax,data
    mov ds,ax
         	
		
	call showMenu
	
	mov ax, 13h
    int 10h
	
	
	call printStart
	call sleep05
	call shaveAndHaircut
	call randomNumbers
	
gameLoop:
	call numberSquare
	call userTurn
	call sleep05
	cmp correctGuess, 0
	je gameOver
	inc currentTurn
	cmp currentTurn, 11
	je gameWinner
	jmp gameLoop
	
gameOver:
	mov dx, offset gameOverMessage
	mov ah, 9h
	int 21h
	jmp continue
	
gameWinner:
	mov dx, offset gameWinnerMessage
	mov ah, 9h
	int 21h
	
	
continue:
	xor ah, ah
	int 16h

exit:    
	mov ah,4ch
    int 21h

code ends
end start