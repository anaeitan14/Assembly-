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
	computerColors db 11 dup (?)
	userGuess db 11 dup (?)
	welcomeToGame1 db "Welcome to Simon Says!",10,13,'$'
	welcomeToGame2 db "Press <ENTER> to start the game...",10,13,'$'
	welcomeToGame3 db "Press <H> for help...",10,13,'$'
	gameHelp1 db "The game consists of 4 colored squares additionally each square has its own sound.",10,13,'$'
	gameHelp2 db "Click the same sequence as the computer without making any mistakes to win.",10,13,'$' 
	gameHelp3 db "Press <B> to go back to the main menu...",10,13,'$'
	gameOverMessage db "Game over :(",10,13,'$'
	gameWinnerMessage db "You won :)",10,13,'$'
	pressAnyKey db "Press any key to continue...",10,13,'$'
	userClickX dw ?
	userClickY dw ?
	currentTurn dw 1
	correctGuess db -1
	Clock equ es:6Ch
	
data ends

sseg segment stack
  DW 1000 dup (?) 
  
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
		call delay01
		
		
		mov [color], 9 ;light blue
		mov [locx], 80
		mov [locy], 10
		call printSqw
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		call delay025
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		call delay01
		
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
		call delay01
		
		
		mov [color], 10 ;light green
		mov [locx], 170
		mov [locy], 10
		call printSqw
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		call delay025
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		call delay01
		
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
		call delay01
		
		
		mov [color], 12 ;light red
		mov [locx], 80
		mov [locy], 100
		call printSqw	
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		call delay025
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		call delay01
		
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
		call delay01
		
		
		mov [color], 14 ;light yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw	
		
		mov cx, [sounddel1]	;sleep 0.25 sec
		mov dx, [sounddel2]
		call delay025
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov cx, [fixdel1]	;sleep 0.1 sec
		mov dx, [fixdel2]
		call delay01
		
		
		mov [color], 74h ;dark yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw
		
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
		mov cx, 10
		mov bx, 1
		
generateNum:
		push cx
		
		xor ah, ah
		int 1Ah
		call delay01
		mov ax, dx
		xor dx, dx
		mov cx, 4
		div cx
		inc dl
		add dl, '0'
		mov computerColors[bx], dl
		inc bx
		pop cx
		loop generateNum
		ret
endp


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
endp 


proc handleMouse
		mov ax, 1h 
		int 33h
		 
click:
		mov ax, 3h 
		int 33h	
					
		cmp bx, 0
		je click
		
		shr cx, 1 ; divide cx by 2
		
		mov userClickX, cx
		mov userClickY, dx
	
		ret
endp


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
	
endp 


proc showMenu
startMenu:
	mov dx, offset welcomeToGame1
	mov ah, 9h
	int 21h
	
	mov dx, offset welcomeToGame2
	mov ah, 9h
	int 21h
	
	mov dx, offset welcomeToGame3
	mov ah, 9h
	int 21h
	
readInput:
	mov ah, 07
	int 21h
	
	cmp al, 0Dh
	je startGame
	cmp al, 68h
	je showHelp
	jmp readInput
	
showHelp:
		mov dx, offset gameHelp1
		mov ah, 9h
		int 21h
		
		mov dx, offset gameHelp2
		mov ah, 9h
		int 21h
		
		mov dx, offset gameHelp3
		mov ah, 9h 
		int 21h
		
compareKey:
		mov ah, 07
		int 21h
		cmp al, 62h
		je startMenu
		jmp compareKey
	
startGame:
	ret
	
endp 

proc checkRightSquare

	mov ah, computerColors[si]
	cmp ah, userGuess[si]
	jne stopCheck
	jmp goBack
	
stopCheck:
	mov correctGuess, 0
	
goBack:	
	ret
	
endp
	

proc userTurn
	mov cx, currentTurn
	mov si, 1
	
turnLoop:
	push cx
	call handleMouse	
	call getSquareNumber
	call checkRightSquare
	cmp correctGuess, 0 
	je wrongChoice
	pop cx
	inc si
	loop turnLoop
	
doneTurn:
	ret
	
wrongChoice:
	pop cx
	ret

endp

proc delay01
	push ax
	push bx
	push dx
	
	mov ax, [Clock]
	
firstTick:
	cmp ax, [Clock]
	je firstTick
	mov cx, 2
delayLoop:
	mov ax, [Clock]
Tick:
	cmp ax, [Clock]
	je Tick
	loop delayLoop
	
	pop dx
	pop bx
	pop ax
	ret
endp

proc delay025
	push ax
	push bx
	push dx
	
	mov ax, [Clock]
	
firstTick2:
	cmp ax, [Clock]
	je firstTick2
	mov cx, 5
delayLoop2:
	mov ax, [Clock]
Tick2:
	cmp ax, [Clock]
	je Tick2
	loop delayLoop2
	
	pop dx
	pop bx
	pop ax
	ret
endp


start:  
	mov ax,data
    mov ds,ax
	mov ax, 40h
	mov es, ax
         	
		
	call showMenu
	
	
	mov ax, 13h
    int 10h
	
	call printStart
	call delay01
	call shaveAndHaircut
	call randomNumbers
	
gameLoop:
	call numberSquare
	call userTurn
	cmp correctGuess, 0
	je gameOver
	inc currentTurn
	cmp currentTurn, 11
	je gameWinner
	jmp gameLoop
	
gameOver:
	mov ax, 03
	int 10h
	
	mov dx, offset gameOverMessage
	mov ah, 9h
	int 21h
	
	mov dx, offset pressAnyKey
	mov ah, 9h
	int 21h
	
	jmp continue
	
gameWinner:
	mov ax, 03
	int 10h
	
	mov dx, offset gameWinnerMessage
	mov ah, 9h
	int 21h
	
	mov dx, offset pressAnyKey
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