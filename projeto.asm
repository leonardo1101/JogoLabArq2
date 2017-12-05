Include ..\Irvine32.inc

.data

a WORD 1920 DUP(0)  ; Framebuffer (24x80)

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
    MOV EDX, OFFSET telaMenu       
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
	CALL inicializaNave2
    CALL Paint
	CALL startGame 
	MOV EAX, white + (black * 16)
    CALL SetTextColor           ; Gave was exited, reset screen color
    ;JMP menu 
	
	;configuracoes:

	exit

main ENDP

inicializaNave1 PROC USES EBX EDX

    MOV DH, 3      ; Set row number to 13
    MOV DL, 50      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 2      ; Set row number to 13
    MOV DL, 52      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 2      ; Set row number to 13
    MOV DL, 48      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
    MOV DH, 5      ; Set row number to 14
    MOV DL, 50      ; Set column number to 47
    MOV BX, 2       ; Second segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 4      ; Set row number to 13
    MOV DL, 52      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 4      ; Set row number to 13
    MOV DL, 48      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer

    MOV DH, 6      ; Set row number to 15
    MOV DL, 50      ; Set column number to 47
    MOV BX, 3       ; Third segment of snake
    CALL saveIndex  ; Write to framebuffer

    RET

inicializaNave1 ENDP

inicializaNave2 PROC USES EBX EDX

    MOV DH, 13      ; Set row number to 13
    MOV DL, 3      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 12      ; Set row number to 13
    MOV DL, 5      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 12      ; Set row number to 13
    MOV DL, 1      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
    MOV DH, 15      ; Set row number to 14
    MOV DL, 3      ; Set column number to 47
    MOV BX, 2       ; Second segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 14      ; Set row number to 13
    MOV DL, 5      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer
	
	MOV DH, 14      ; Set row number to 13
    MOV DL, 1      ; Set column number to 47
    MOV BX, 1       ; First segment of snake
    CALL saveIndex  ; Write to framebuffer

    MOV DH, 16      ; Set row number to 15
    MOV DL, 3      ; Set column number to 47
    MOV BX, 3       ; Third segment of snake
    CALL saveIndex  ; Write to framebuffer

    RET

inicializaNave2 ENDP

saveIndex PROC USES EAX ESI EDX


    PUSH EBX        ; Save EBX on stack
    MOV BL, DH      ; Copy row number to BL
    MOV AL, 80      ; Copy multiplication constant for row number
    MUL BL          ; Multiply row index by 80 to get framebuffer segment
    PUSH DX         ; Push DX onto stack
    MOV DH, 0       ; Clear DH register, to access the column number
    ADD AX, DX      ; Add column offset to get the array index
    POP DX          ; Pop old address off of stack
    MOV ESI, 0      ; Clear indexing register
    MOV SI, AX      ; Move generated address into ESI register
    POP EBX         ; Pop EBX off of stack
    SHL SI, 1       ; Multiply address by two, because elements
                    ; are of type WORD
    MOV a[SI], BX   ; Save BX into array

    RET

saveIndex ENDP


Paint PROC USES EAX EDX EBX ESI

    MOV EAX, blue + (white * 16)    ; Set text color to blue on white
    CALL SetTextColor

    MOV DH, 0                       ; Set row number to 0

    loop1:                          ; Loop for indexing of the rows
        CMP DH, 24                  ; Check if the indexing has arrived
        JGE endLoop1                ; at the bottom of the screen

        MOV DL, 0                   ; Set column number to 0

        loop2:                      ; Loop for indexing of the columns
            CMP DL, 80              ; Check if the indexing has arrived
            JGE endLoop2            ; at the right side of the screen
            CALL GOTOXY             ; Set cursor to current pixel position

            MOV BL, DH              ; Generate the framebuffer address from
            MOV AL, 80              ; the row value stored in DH
            MUL BL
            PUSH DX                 ; Save DX on stack
            MOV DH, 0               ; Clear upper bite of DX
            ADD AX, DX              ; Add offset to row address (column adress)
            POP DX                  ; Restore old value of DX
            MOV ESI, 0              ; Clear indexing register
            MOV SI, AX              ; Move pixel address into indexing register
            SHL SI, 1               ; Multiply indexing address by 2, since
                                    ; we're using elements of type WORD in the
                                    ; framebuffer
            MOV BX, a[SI]           ; Get the pixel

            CMP BX, 0               ; Check if pixel is empty space,
            JE NoPrint              ; and don't print it if is

            CMP BX, 0FFFFh          ; Check if pixel is part of a wall
            JE printHurdle          ; Jump to segment for printing walls

            MOV AL, ' '             ; Pixel is part of the snake, so print
            CALL WriteChar          ; whitespace
            JMP noPrint             ; Jump to end of loop

            PrintHurdle:            ; Segment for printing the walls
            MOV EAX, blue + (gray * 16) ; Change the text color to blue on gray
            CALL SetTextColor

            MOV AL, ' '             ; Print whitespace
            CALL WriteChar

            MOV EAX, blue + (white * 16)    ; Change the text color back to
            CALL SetTextColor               ; blue on white

            NoPrint:
            INC DL                  ; Increment the column number
            JMP loop2               ; Continue column indexing

    endLoop2:                       ; End of column loop
        INC DH                      ; Increment the row number
        JMP loop1                   ; Continue row indexing

endLoop1:                           ; End of row loop

RET

Paint ENDP

startGame PROC USES EAX EBX ECX EDX
    RET
startGame ENDP

END main