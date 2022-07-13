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
	colorsnum db 9, 10, 12, 14
	welcomeToGame1 db "Simon Says!"
	welcomeToGame2 db "start the game"
	welcomeToGame3 db "help"
	welcomeToGame4 db "levels"
	welcomeToGame5 db "exit"
	level1 db "easy"
	level2 db "nurmal"
	level3 db "hard"
	level4 db "extreme!"
	win1 db "you win!"
	lose1 db "you lose"
	lose2 db "your score is:"
	gameHelp1 db "The game has 4 colores squares",10,13,'$'
	gameHelp2 db "Click the same sequence as the computer without making any mistakes to win.",10,13,'$' 
	gameHelp3 db "Click to go back to the main menu...",10,13,'$'
	pressAnyKey db "Press any key to continue...",10,13,'$'
	score db 10, 13, " Score:$"
	userClickX dw ?
	userClickY dw ?
	currentTurn dw ?
	turnLimit dw 4
	correctGuess db -1
	Clock equ es:6Ch
	xtext db ?
	ytext db ?
	colortext db ?
	tempbx dw ?
	letter db ?
	minX dw ?
	minY dw ?
	maxX dw ?
	maxY dw ?
	booleanclick db ?
	
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
		call DrawSqure
		
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
		call DrawSqure
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
		call DrawSqure
		
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
		call DrawSqure
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
		call DrawSqure	
		
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
		call DrawSqure	
		
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
		call DrawSqure	
		
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
		call DrawSqure
		
		pop dx
		pop cx
		pop ax
		ret
endp

proc DrawSqure
		
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
		call clear
		mov dx, offset score
		mov ah, 09h
		int 21h
		
		mov [colortext], 12
		mov [xtext], 8
		mov [ytext], 1
		call printscore
	
		mov [color], 69h ;dark blue
		mov [locx], 80
		mov [locy], 10
		call DrawSqure
		 
		mov [color], 79h ;dark green
		mov [locx], 170
		mov [locy], 10
		call DrawSqure	
		
		mov [color], 70h ;dark red
		mov [locx], 80
		mov [locy], 100
		call DrawSqure	
		
		mov [color], 74h ;dark yellow
		mov [locx], 170
		mov [locy], 100
		call DrawSqure
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
		mov bx, 1
		mov si, currentTurn
		
		mov ax, [Clock]
		mov ah, [byte ptr cs:bx]
		xor al, ah
		and al, 00000011b
		inc al
		add al, '0'
		mov computerColors[si], al
		inc bx
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
			
		test bx, 3 
		je click
click2:
		mov ax, 3h 
		int 33h	
			
		test bx, 3 
		jne click2
				
		shr cx, 1 ; divide cx by 2
		
		mov userClickX, cx
		mov userClickY, dx
	
		ret
endp


proc getSquareNumber
	pressonblack:	
	call handleMouse
	mov [minX], 170
	mov [maxX], 250
	mov [minY], 10
	mov [maxY], 90
	call checkrange
	cmp [booleanclick], 1
	je greenClick
	
	mov [minX], 80
	mov [maxX], 160
	call checkrange
	cmp [booleanclick], 1
	je blueclick
	
	mov [minY], 100
	mov [maxY], 180
	call checkrange
	cmp [booleanclick], 1
	je redclick
	
	mov [minX], 170
	mov [maxX], 250
	call checkrange
	cmp [booleanclick], 1
	je yellowclick
	
	jmp pressonblack
	
blueclick:
	call pressBlue
	mov userGuess[si], '1'
	jmp sofp	
	
redclick:	
	call pressRed
	mov userGuess[si], '3'
	jmp sofp
	
greenClick:	
	call pressGreen
	mov userGuess[si], '2'
	jmp sofp

yellowclick:	
	call pressYellow
	mov userGuess[si], '4'

sofp:
	ret
	
endp


proc printLetter
		push ax
		push bx
		push dx
		xor bh,bh
		mov ah, 2
		mov dl, [xtext]
		mov dh, [ytext]	;y
		mov al, [letter]
		int 10h
		mov bl, [colortext]	;color
		mov ah, 0Eh
		int 10h
		pop dx
		pop bx
		pop ax
		ret
endp
proc printtextcolor
	mov dx, offset [colorsnum]
	mov [tempbx], dx
	add dx, 4
	xor ax, ax
	
textstartcolor:
	mov al, [bx]
	mov [letter], al
	push bx
	mov bx, [tempbx]
	mov al, [bx]
	mov [colortext], al
	inc [tempbx]
	cmp [tempbx], dx
	jne resetcolor
	sub [tempbx], 4
resetcolor:	
	pop bx
	call printLetter
	inc [xtext]
	inc bx
	loop textstartcolor
	ret
endp
proc printtext
	
	xor ax, ax
	
textstart:
	mov al, [bx]
	mov [letter], al
	call printLetter
	inc [xtext]
	inc bx
	loop textstart
	ret
endp
proc printwin
	push ax
	push bx
	push cx
	push dx
	mov bx, offset [win1]
	mov cx, 8
	mov [xtext], 16
	mov [ytext], 23
	call printtextcolor
	pop dx
	pop cx
	pop bx
	pop ax
	ret
endp
proc printscore
	xor ax, ax
	mov ax, [currentTurn]
	
	cmp al, 10
	jbe onedig
	
	add al, 37
	mov [letter], al
	call printLetter
	mov [letter], 49
	dec [xtext]
	call printLetter
	jmp endprintscore
onedig:	
	add al, 47
	mov [letter], al
	call printLetter
endprintscore:	
	ret
endp
proc printMenu
	call clear
	mov bx, offset [welcomeToGame1]
	mov cx, 11
	mov [xtext], 15
	mov [ytext], 3
	call printtextcolor
	mov bx, offset [welcomeToGame2]
	mov cx, 14
	mov [xtext], 13
	mov [ytext], 9
	mov [colortext], 9
	call printtext
	mov bx, offset [welcomeToGame3]
	mov cx, 4
	mov [xtext], 18
	mov [ytext], 12
	mov [colortext], 10
	call printtext
	mov bx, offset [welcomeToGame4]
	mov cx, 6
	mov [xtext], 17
	mov [ytext], 15
	mov [colortext], 12
	call printtext
	mov bx, offset [welcomeToGame5]
	mov cx, 4
	mov [xtext], 18
	mov [ytext], 18
	mov [colortext], 14
	call printtext
	ret
endp
proc printlevels
	call clear
	mov bx, offset [level1]
	mov cx, 4
	mov [xtext], 18
	mov [ytext], 5
	mov [colortext], 12
	call printtext
	mov bx, offset [level2]
	mov cx, 6
	mov [xtext], 17
	mov [ytext], 9
	mov [colortext], 14
	call printtext
	mov bx, offset [level3]
	mov cx, 4
	mov [xtext], 18
	mov [ytext], 13
	mov [colortext], 10
	call printtext
	mov bx, offset [level4]
	mov cx, 8
	mov [xtext], 16
	mov [ytext], 17
	mov [colortext], 9
	call printtext
	ret
endp
proc printlose
	call clear
	mov bx, offset [lose1]
	mov cx, 8
	mov [xtext], 16
	mov [ytext], 5
	mov [colortext], 12
	call printtext
	mov bx, offset [lose2]
	mov cx, 14
	mov [xtext], 13
	mov [ytext], 10
	mov [colortext], 10
	call printtext
	mov bx, offset [pressAnyKey]
	mov cx, 28
	mov [xtext], 6
	mov [ytext], 20
	mov [colortext], 9
	call printtext
	mov [xtext], 20
	mov [ytext], 14
	mov [colortext], 14
	call printscore
	ret
endp

proc showMenu
startMenu:
	call printMenu
	
readInput:
	
	call handleMouse
	
	mov [minX], 104
	mov [maxX], 216
	mov [minY], 72
	mov [maxY], 80
	call checkrange
	cmp [booleanclick], 1
	je startGame
	
	mov [minX], 144
	mov [maxX], 176
	mov [minY], 96
	mov [maxY], 104
	call checkrange
	cmp [booleanclick], 1
	je showHelp
	
	mov [minY], 144
	mov [maxY], 152
	call checkrange
	cmp [booleanclick], 1
	je exitGame
	
	mov [minX], 136
	mov [maxX], 184
	mov [minY], 120
	mov [maxY], 128
	call checkrange
	cmp [booleanclick], 1
	je levels
	
	jmp readInput

startGame:
	ret
	
levels:	
		call printlevels
		call checkLevel
		jmp startMenu
		
showHelp:
		call clear
		mov delaytime, 2
		call delay
		
		mov dx, offset gameHelp1
		mov ah, 9h
		int 21h
		
		mov dx, offset gameHelp2
		mov ah, 9h
		int 21h
		
		mov dx, offset gameHelp3
		mov ah, 9h 
		int 21h
		
		call handleMouse
		jmp startMenu
	
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
	dec ax
	add ax, '0'
	mov ah, 02h
	int 10h
	
	mov bl, 0Ch
	mov bh, 0
	mov ah, 0Eh
	int 10h
	ret
endp
proc clear
	mov ax, 03h
	int 10h
	
	mov ax, 13h
    int 10h
	ret
endp

proc checkrange
	push ax
	mov ax, [userClickX]
	cmp ax, [minX]
	jb clickfalse
	cmp ax, [maxX]
	ja clickfalse
	mov ax, [userClickY]
	cmp ax, [minY]
	jb clickfalse
	cmp ax, [maxY]
	ja clickfalse
	mov [booleanclick], 1
	jmp endclickrange
clickfalse:
	mov [booleanclick], 0
endclickrange:	
	pop ax
	ret
endp

proc checkLevel
pressback:
	call handleMouse
	mov [minX], 144
	mov [maxX], 176
	mov [minY], 40
	mov [maxY], 48
	call checkrange
	cmp [booleanclick], 1
	je easyDiff

	mov [minY], 104
	mov [maxY], 112
	call checkrange
	cmp [booleanclick], 1
	je hardDiff
	
	mov [minX], 136
	mov [maxX], 184
	mov [minY], 72
	mov [maxY], 80
	call checkrange
	cmp [booleanclick], 1
	je normalDiff
	
	mov [minX], 128
	mov [maxX], 192
	mov [minY], 136
	mov [maxY], 144
	call checkrange
	cmp [booleanclick], 1
	je extremeDiff
	jmp pressback
	
extremeDiff:
	mov turnLimit, 17
	jmp endDiff
	
hardDiff:
	mov turnLimit, 13
	jmp endDiff
	
normalDiff:
	mov turnLimit, 9
	jmp endDiff
	
easyDiff:
	mov turnLimit, 5	

endDiff:
		ret

endp


proc randomMusic
		mov bx, 1
		mov si, currentTurn
		
		mov ax, [Clock]
		mov ah, [byte ptr cs:bx]
		xor al, ah
		and al, 2
		inc al
		
		cmp al, 1
		je song1
		cmp al, 2
		je song2
		call inTheJungle
		jmp stopMusic
song1:
		call shaveAndHaircut
		jmp stopMusic
song2:
		call doReMi
		jmp stopMusic
				
		
stopMusic:
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
	xor si, si
	xor cx, cx
	mov currentTurn, 1
	mov correctGuess, -1
	call showMenu
	call clear

	call printStart
	call randomNumbers
	
gameLoop:
	call numberSquare
	call userTurn
	cmp correctGuess, 0
	je gameOver
	inc currentTurn
	call randomNumbers
	mov [colortext], 12
	mov [xtext], 8
	mov [ytext], 1
	call printscore
	mov dx, turnLimit
	cmp currentTurn, dx
	je gameWinner
	jmp gameLoop
	
gameOver:
	call clear
	call printlose
	call handleMouse
	jmp resetGame
	
gameWinner:
	mov delaytime, 2
	call delay
	call printwin
	call randomMusic
	
	call clear
	
	jmp resetGame	

exit:    
	mov ah,4ch
    int 21h

code ends
end start