data segment
	locx dw ?
	locy dw ?
	x dw ?
	y dw ?
	color dw ?
	Godelsqw equ 80
	Fixdel equ 1
	sounddel dw 8
	delaytime dw 50
	computerColors db 11 dup (?)
	userGuess db 11 dup (?)
	welcomeToGame1 db "Welcome to Simon Says!",10,13,'$'
	welcomeToGame2 db "ENTER to start the game...",10,13,'$'
	welcomeToGame3 db "H for help...",10,13,'$'
	welcomeToGame4 db "E to exit...",10,13,'$'
	gameHelp1 db "The game has 4 colores squares",10,13,'$'
	gameHelp2 db "Click the same sequence as the computer without making any mistakes to win.",10,13,'$' 
	gameHelp3 db "B to go back to the main menu...",10,13,'$'
	gameOverMessage db "Game over :(",10,13,'$'
	gameWinnerMessage db "You won :)",10,13,'$'
	pressAnyKey db "Press any key to continue...",10,13,'$'
	score db "Score:$"
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


		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
		mov [color], 9 ;light blue
		mov [locx], 80
		mov [locy], 10
		call printSqw
		
		push [sounddel] ;sleep 0.25 sec
		pop [delaytime]
		call delay
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov [delaytime], Fixdel
		call delay
		
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

		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
		
		mov [color], 10 ;light green
		mov [locx], 170
		mov [locy], 10
		call printSqw
		
		push [sounddel] ;sleep 0.25 sec
		pop [delaytime]
		call delay
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
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

		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
		
		mov [color], 12 ;light red
		mov [locx], 80
		mov [locy], 100
		call printSqw	
		
		push [sounddel] ;sleep 0.25 sec
		pop [delaytime]
		call delay
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
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

		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
		
		mov [color], 14 ;light yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw	
		
		push [sounddel] ;sleep 0.25 sec
		pop [delaytime]
		call delay
		
		in al, 61h	;close speacker
		and al, 0fch
		out 61h, al
		
		mov [delaytime], Fixdel ;sleep 0.1 sec
		call delay
		
		mov [color], 74h ;dark yellow
		mov [locx], 170
		mov [locy], 100
		call printSqw
		
		pop dx
		pop cx
		pop ax
		ret
endp

proc printSqw
		
		push cx
		push [locy]
		pop [y]     ; y = locy
		mov cx, godelsqw
la2:
		push [locx]
		pop [x]     ; x = locx
		push cx
		mov cx, godelsqw
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
		mov dx, offset score
		mov ah, 09h
		int 21h
		
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


proc shaveAndHaircut
	push[sounddel]
	mov [sounddel], 6 ; 0.5
	call pressYellow
	mov [sounddel], 2 ; 0.25
	call pressBlue
	call pressBlue
	mov [sounddel], 6 ; 0.5
	call pressGreen
	mov [sounddel], 14 ; 1
	call pressBlue
	mov [sounddel], 6 ; 0.5
	call pressRed
	mov [sounddel], 14 ; 1
	call pressYellow
	pop [sounddel]
	ret
endp

proc inTheJungle
	push[sounddel]
	mov [sounddel], 6 ; 0.5
	call pressBlue
	mov [sounddel], 2 ; 0.25
	call pressGreen
	mov [sounddel], 6 ; 0.5
	call pressRed
	call pressGreen
	mov [sounddel], 2 ; 0.25
	call pressRed
	mov [sounddel], 6 ; 0.5
	call pressYellow
	mov [sounddel], 2 ; 0.25
	call pressRed
	mov [sounddel], 6 ; 0.5
	call pressGreen
	call pressBlue
	mov [sounddel], 2 ; 0.25
	call pressGreen
	mov [sounddel], 6 ; 0.5
	call pressRed
	mov [sounddel], 2 ; 0.25
	call pressGreen
	mov [sounddel], 14 ; 1
	call pressBlue
	mov [sounddel], 2 ; 0.25
	call pressRed
	mov [sounddel], 30 ; 2
	call pressGreen
	pop [sounddel]
	ret
endp

proc doReMi
	push[sounddel]
	mov [sounddel], 10 ; 0.75
	call pressBlue
	mov [sounddel], 2 ; 0.25
	call pressGreen
	mov [sounddel], 10 ; 0.75
	call pressRed
	mov [sounddel], 2 ; 0.25
	call pressBlue
	mov [sounddel], 6 ; 0.5
	call pressRed
	call pressBlue
	mov [sounddel], 14 ; 1
	call pressRed
	mov [sounddel], 10 ; 0.75
	call pressGreen
	mov [sounddel], 2 ; 0.25
	call pressRed
	call pressYellow
	call pressYellow
	call pressRed
	call pressGreen
	mov [sounddel], 30 ; 2
	call pressYellow
	pop [sounddel]
	ret
endp


proc randomNumbers
		mov cx, 10
		mov bx, 1
		mov si, 1
			
generateNum:
		push cx
		xor ah, ah
		mov delaytime, si
		call delay
		
		int 1Ah
		mov ax, dx
		xor dx, dx
		mov cx, 4
		div cx
		inc dl
		add dl, '0'
		mov computerColors[bx], dl
		inc bx
		inc si
		
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
	
	mov dx, offset welcomeToGame4
	mov ah, 9h
	int 21h
	
readInput:
	mov ah, 07
	int 21h
	
	cmp al, 0Dh
	je startGame
	cmp al, 68h
	je showHelp
	cmp al, 65h
	je exitGame
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
	
exitGame:
		mov ax, 03h
		int 10h
		mov ah, 4cH
		int 21h
	
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

proc delay
	push ax
	push bx
	push dx
	
	mov ax, [Clock]
	
firstTick2:
	cmp ax, [Clock]
	je firstTick2
	mov cx, [delaytime]
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

proc addScore
	mov dl, 6
	mov dh, 0
	mov bh, 0
	
	mov ax, currentTurn
	add ax, '0'
	mov ah, 02h
	int 10h
	
	mov bl, 0Ch
	mov bh, 0
	mov ah, 0Eh
	int 10h
	ret
endp


start:  
	mov ax,data
    mov ds,ax
	mov ax, 40h
	mov es, ax
	
	
	mov ax, 13h
    int 10h
         		
resetGame:
	call showMenu
	mov ax, 03h
    int 10h
	
	mov ax, 13h
    int 10h

	call printStart
	call randomNumbers
	
gameLoop:
	call numberSquare
	call userTurn
	cmp correctGuess, 0
	je gameOver
	inc currentTurn
	call addScore
	cmp currentTurn, 11
	je gameWinner
	jmp gameLoop
	
gameOver:

	mov dx, offset gameOverMessage
	mov ah, 9h
	int 21h
	
	mov dx, offset pressAnyKey
	mov ah, 9h
	int 21h
	
	jmp resetGame
	
gameWinner:
	call shaveAndHaircut
	
	mov dx, offset gameWinnerMessage
	mov ah, 9h
	int 21h
	
	mov dx, offset pressAnyKey
	mov ah, 9h
	int 21h
	
	jmp resetGame	

exit:    
	mov ah,4ch
    int 21h

code ends
end start