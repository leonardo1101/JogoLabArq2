Include ..\Irvine32.inc

tela_creditos PROTO

.data
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
    ;JE jogar

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
	
	;jogar:
	
	;configuracoes:

	exit

main ENDP

END main