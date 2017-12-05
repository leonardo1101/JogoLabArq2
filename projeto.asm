Include Irvine32.inc

setPosNave PROTO,x: PTR Byte, y: PTR byte

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
					 
posNave1 BYTE 0,0
posNave2 BYTE 20,20
messageDirections BYTE "Use the arrow keys to move", 0dh, 0ah, 0



tela DWORD 124, 108 dup(45),124
rowSize = ($ - tela)
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124		
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(45),124
		
		
.code

Draw PROC
	mov dh, 0 ;Set tela position X
	mov dl, 0 ;Set tela position Y
	call Gotoxy ;Call Go to X Y
	mov ebx, OFFSET tela ;Move the tela 2D array into ebx
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
	jmp PrintLoop
Print:
	call Crlf
	mov edx,OFFSET MessageDirections
	call WriteString ;Call Write String procdure
	ret
	
Draw ENDP

main PROC


	INVOKE setPosNave, 10, 10,
    call Draw 
	;configuracoes:

	exit

main ENDP

setPosNave PROC	USES eax ebx ecx ebx,
	x: PTR Byte,
	y: PTR Byte
	
	mov ecx,4
	mov eax,110
	mov ebx, y
	mul ebx
	mul ecx
	mov ebx,eax
	mov eax, x
	mul ecx
	add eax,ebx
	mov ebx, OFFSET tela 
	add ebx, eax
	mov eax,ebx
	mov edx,254
	mov ecx,0
	mov DWORD PTR [ebx],edx
	add ebx, 4
	mov DWORD PTR [ebx],ecx
	add ebx, 4
	mov DWORD PTR [ebx],edx
	mov ebx,eax
	add ebx,448
	mov DWORD PTR [ebx],edx
	add ebx, 4
	mov DWORD PTR [ebx],ecx
	add ebx, 4
	mov DWORD PTR [ebx],edx
	mov ebx,eax
	add ebx,880
	mov DWORD PTR [ebx],edx
	add ebx, 4
	mov DWORD PTR [ebx],ecx
	add ebx, 4
	mov DWORD PTR [ebx],edx
	
	ret 
setPosNave ENDP
	
END main