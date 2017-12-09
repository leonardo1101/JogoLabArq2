Include Irvine32.inc

;Funções
setPosNave PROTO

;Estruturas
nave STRUCT
	x DWORD 0
	y DWORD 0
	eixo byte 1
nave ENDS

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
nave1 nave <0,0,1>
nave2 nave <>
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

ClearScreen PROC
	mov ebx, OFFSET tela ;Move the tela 2D array into ebx
	mov ecx, 0 ;intialize the counter
	mov eax,00
Clear: 
	
	mov [ebx], eax ;Move the indirect value of ebx postion 1 into eax
	add ebx, 4 ;Move to the next offset position
	inc ecx ;Increment the counter
	cmp ecx, 6050
	jne Clear

	ret
ClearScreen ENDP

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

	mov edx, OFFSET tela
leia:
	call ClearScreen
	INVOKE setPosNave
	call Draw
	call ReadKey
	cmp al,97
	je MudarEsquerda
	cmp al,100
	je MudarDireita
	cmp al,115
	je MudarBaixo
	cmp al,119
	je MudarCima
	cmp al,113
	je fim
	movzx eax, Byte PTR [nave1+8]
	cmp eax,1
	je MoverDireita
	cmp eax,2
	je MoverCima
	cmp eax,3
	je MoverEsquerda
	cmp eax,4
	je MoverBaixo
	jmp leia
	
MudarDireita:
	mov al , 1
	mov Byte PTR [nave1+8] , al
	jmp leia

MudarEsquerda:
	mov al , 3
	mov Byte PTR [nave1+8] , al
	jmp leia
MudarCima:
	mov al , 2
	mov Byte PTR [nave1+8] , al
	jmp leia

MudarBaixo:
	mov al , 4
	mov Byte PTR [nave1+8] , al
	jmp leia

MoverDireita:
	mov dx , WORD PTR [nave1]
	inc dx
	inc dx
	mov  WORD PTR [nave1] , dx
	jmp leia
	
MoverEsquerda:
	mov dx ,  WORD PTR [nave1]
	dec dx
	dec dx
	mov  WORD PTR [nave1] , dx
	jmp leia

MoverCima:
	mov dx ,  WORD PTR [nave1 + 4]
	dec dx
	dec dx
	mov WORD PTR [nave1 + 4] , dx
	jmp leia

MoverBaixo:
	mov dx , WORD PTR [nave1 + 4]
	inc dx
	mov WORD PTR [nave1 + 4] , dx
	jmp leia
	
fim:
	exit

main ENDP

setPosNave PROC	USES eax ebx ecx ebx
	mov ecx,4
	mov eax,110
	mov  ebx, DWORD PTR [nave1 + 4]
	mul ebx
	mul ecx
	mov ebx,eax
	mov  eax, DWORD PTR [nave1]
	mul ecx
	add eax,ebx
	mov ebx, OFFSET tela 
	add ebx, eax
	mov eax,ebx
	
	movzx  edx,Byte PTR  [nave1 + 8]
	cmp edx, 1
	je NaveDireita
	cmp edx, 2
	je NaveCima
	cmp edx, 3
	je NaveEsquerda
	cmp edx,4
	je NaveBaixo
	
NaveEsquerda:
	mov edx,254
	mov ecx,0
	add ebx, 8
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	add ebx, 8
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	jmp fim
	
NaveDireita:
	mov edx,254
	mov ecx,0
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	mov ebx,eax
	add ebx,448
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	jmp fim

NaveCima:
	mov edx,254
	mov ecx,0
	mov [ebx],ecx
	add ebx, 4
	add ebx, 4
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	mov [ebx],edx
	add ebx, 16
	mov [ebx],edx
	jmp fim
	
NaveBaixo:
	mov edx,254
	mov ecx,0
	mov [ebx],edx
	add ebx, 16
	mov [ebx],edx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	add ebx, 4
	mov [ebx],ecx
	add ebx, 4
	mov [ebx],edx
	mov ebx,eax
	add ebx,888
	mov [ebx],edx
	jmp fim
fim:
	ret 
setPosNave ENDP
	
END main