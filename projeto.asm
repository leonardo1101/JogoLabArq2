Include Irvine32.inc

.data

rocketSpace BYTE "						ROCKET SPACE", 0Dh,0Ah,0

telaMenu BYTE "1. Jogar", 0Dh, 0Ah,"2. Instrucoes", 0Dh, 0Ah,
              "3. Creditos", 0Dh, 0Ah, "4. Configuracoes",0Dh, 0Ah, "5. Sair", 0Dh, 0Ah, 0

		  
telaCreditos BYTE  "Desenvolvedores: Rodrigo Pesse de Abreu e Leonardo de Oliveira Peralta." ,0Dh, 0Ah, " ",0Dh,0Ah,
			   	   "Disciplica: Laboratorio de Arquitetura e Organizacao de Computadores 2.",0Dh, 0Ah, " ",0Dh,0Ah,
				   "Docente: Luciano de Oliveira Neris.",0Dh,0ah, 0
				   
telaInstrucoes  BYTE "O jogo consiste em uma batalha entre duas naves,",0Dh,0Ah,
					 "cada jogador sera o piloto de sua nave (2 naves)",0Dh,0Ah,
					 "tendo que derrotar seu adversario. ",0Dh,0Ah,
					 " ", 0Dh,0Ah,
					 "As cores das naves serao diferentes para a identificacao dos jogadores.",0Dh,0Ah,
					 " ", 0Dh,0Ah,
					 "As naves possuem um armamento que sera utilizado para atingir o adversario",0Dh,0Ah,0
					


.code
main PROC

    menu:
    CALL Randomize              
    CALL Clrscr
	MOV EDX, OFFSET rocketSpace 
	MOV EAX, green + (black * 16)
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


END main