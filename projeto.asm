Include Irvine32.inc

.data

rocketSpace0 BYTE  "             _ _    ____     ___         ____   _______      _____    _____     ___    _____   ____   ", 0Dh,0Ah,0
rocketSpace1 BYTE  "            |   |  /    \   /     |  /  |          |        |        |     |   /   \  /       |       ", 0Dh,0Ah,0
rocketSpace2 BYTE  "            |   |  |    |  |      | /   |          |        |        |     |  |     | |       |       ", 0Dh,0Ah,0
rocketSpace3 BYTE  "            |_ _|  |    |  |      |/    |___       |        |_____   |_____|  |_ _ _| |       |___    ", 0Dh,0Ah,0
rocketSpace4 BYTE  "            |\     |    |  |      |\    |          |              |  |        |     | |       |       ", 0Dh,0Ah,0
rocketSpace5 BYTE  "            | \    |    |  |      | \   |          |              |  |        |     | |       |       ", 0Dh,0Ah,0
rocketSpace6 BYTE  "            |  \   \____/   \___  |  \  |____      |         _____|  |        |     | \_____  |____   ", 0Dh,0Ah,0

;rocketSpace7  BYTE "    ^       _ _         _ _   ___  _ _    ___    _ _      ",0Dh,0Ah,0
;rocketSpace8  BYTE "   /|        |   |\   |  |   /      |    /   \  |   |     ",0Dh,0Ah,0
;rocketSpace9  BYTE "    |        |   | \  |  |   |      |   |     | |_ _|     ",0Dh,0Ah,0
;rocketSpace10 BYTE "    |  -     |   |  \ |  |   |      |   |_ _ _| |\        ",0Dh,0Ah,0  
;rocketSpace11 BYTE "    |        |   |   \|  |   |      |   |     | | \       ",0Dh,0Ah,0
;rocketSpace12 BYTE "   _|_      _|_  |    \ _|_  \___  _|_  |     | |  \      ",0Dh,0Ah,0

;telaGanhador1a BYTE "        _______  ____    _____   ____	                    ", 0Dh,0Ah,0
;telaGanhador1b BYTE "           |    /    \  /       /    \           ", 0Dh,0Ah,0
;telaGanhador1c BYTE "           |    |    |  | _ _  |______|          ", 0Dh,0Ah,0
;telaGanhador1d BYTE "           |    |    |  |    | |      |         ", 0Dh,0Ah,0
;telaGanhador1e BYTE "        |  |    |    |  |    | |      |        ", 0Dh,0Ah,0
;telaGanhador1f BYTE "        |__|    \____/  \____/ |      |            ", 0Dh,0Ah,0


telaMenu BYTE "1. Jogar", 0Dh, 0Ah,"2. Instrucoes", 0Dh, 0Ah,
              "3. Creditos", 0Dh, 0Ah, "4. Configuracoes",0Dh, 0Ah, "5. Sair", 0Dh, 0Ah, 0

		  
telaCreditos BYTE  "Desenvolvedores: Rodrigo Pesse de Abreu e Leonardo de Oliveira Peralta." ,0Dh, 0Ah, " ",0Dh,0Ah,
			   	   "Disciplica: Laboratorio de Arquitetura e Organizacao de Computadores 2.",0Dh, 0Ah, " ",0Dh,0Ah,
				   "Docente: Luciano de Oliveira Neris.",0Dh,0Ah, 0
				   
telaInstrucoes  BYTE "O jogo consiste em uma batalha entre duas naves,",0Dh,0Ah,
					 "cada jogador sera o piloto de sua nave (2 naves)",0Dh,0Ah,
					 "tendo que derrotar seu adversario. ",0Dh,0Ah,
					 " ", 0Dh,0Ah,
					 "As cores das naves serao diferentes para a identificacao dos jogadores.",0Dh,0Ah,
					 " ", 0Dh,0Ah,
					 "As naves possuem um armamento que sera utilizado para atingir o adversario",0Dh,0Ah,0
					

telaGanhador1 BYTE "Jogador 1 venceu a partida", 0Dh, 0Ah,0

telaGanhador2 BYTE "Jogador 1 venceu a partida", 0Dh, 0Ah,0

.code
main PROC

    menu:
	CALL Randomize              
    CALL Clrscr
	MOV EDX, OFFSET rocketSpace0  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace1  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace2  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace3  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace4  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace5  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace6  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 	
	
	MOV EDX, OFFSET telaMenu  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 		
	
    centralMenu:                      
    CALL ReadChar

    CMP AL, '1'                 
    JE jogar

    CMP AL, '2'                 
    JE instrucoes

    CMP AL, '3'                 
    JE creditos
	
	CMP AL, '4'                 
    ;JE configuracoes

    CMP AL, '5'                 
    ;sai do jogo
                                
    EXIT
	
	creditos:
    CALL Clrscr    
    MOV EDX, OFFSET telaCreditos       
    CALL WriteString 
	CALL ReadChar
	JMP menu
	
	instrucoes:
    CALL Clrscr                 
    MOV EDX, OFFSET telaInstrucoes       
    CALL WriteString 
	CALL ReadChar
	JMP menu	
	
	jogar:
    MOV EAX, 0                  ; Clear registers
    MOV EDX, 0
	CALL Clrscr                 
    CALL inicializaNave1
    ;JMP menu 
	
	;configuracoes:

	exit

main ENDP

inicializaNave1 PROC USES EBX EDX

    MOV DH, 3      ; Set row number to 13
    MOV DL, 50      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    ;CALL saveIndex  ; Write to framebuffer 
	
	MOV DH, 2      ; Set row number to 13
    MOV DL, 52      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    ;CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 2      ; Set row number to 13
    MOV DL, 48      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    ;CALL saveIndex  ; Write to framebuffer

	
    MOV DH, 5      ; Set row number to 14
    MOV DL, 50      ; Set column number to 47
    MOV BX, 2       ; Second segment of snake
    ;CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 4      ; Set row number to 13
    MOV DL, 52      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    ;CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 4      ; Set row number to 13
    MOV DL, 48      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    ;CALL saveIndex  ; Write to framebuffer
	
    MOV DH, 6      ; Set row number to 15
    MOV DL, 50      ; Set column number to 47
    MOV BX, 3       ; Third segment of snake
    ;CALL saveIndex  ; Write to framebuffer
	
	RET

inicializaNave1 ENDP

Draw PROC
	mov dh, 0 ;Set tela position X
	mov dl, 0 ;Set tela position Y
	call Gotoxy ;Call Go to X Y
	;mov ebx, OFFSET tela ;Move the tela 2D array into ebx
	mov ecx, 0 ;intialize the counter	
	mov edx, 110
PrintLoop: 
	mov eax, [ebx] ;Move the indirect value of ebx postion 1 into eax
	add ebx, 4 ;Move to the next offset position
	inc ecx ;Increment the counter
	
	call WriteChar ;Write Character
	cmp ecx, edx ;Compare for end of row for each 20 positions
	je NextLine
	cmp edx, 6050
	jne PrintLoop
	jmp Print

NextLine:
	add edx,110	
	call Crlf
	mov edx,OFFSET MessageDirections
	call WriteString ;Call Write String procdure
	ret
Print:
	call Crlf
	mov edx,OFFSET MessageDirections
	call WriteString ;Call Write String procdure
	ret
MessageDirections:
	call WriteString ;Call Write String procdure
	ret
	
Draw ENDP	


END main