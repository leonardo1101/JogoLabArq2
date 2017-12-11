IncludeLib winmm.lib
Include Irvine32.inc

;Funções
setPosNave1 PROTO
setPosNave2 PROTO
desenhaVida PROTO
criaTiro PROTO
adicionarTiro PROTO
mostrarTiros PROTO
retirarTiro PROTO ,  endNodeA : DWORD
bateu PROTO
PlaySound PROTO, pszSound:PTR BYTE, hmod:DWORD, fdwSound:DWORD


;Estruturas
crd STRUCT
	x BYTE 0
	y BYTE 0
crd ENDS

nave STRUCT
	x DWORD 0
	y DWORD 0
	eixo byte 1
	vida byte 3
nave ENDS

tiro STRUCT
	x DWORD 0
	y DWORD 0
	direcao BYTE 1
tiro ENDS

node STRUCT
	tiroIns tiro<0,0,1>
	pointer DWORD 0
node ENDS

.data
NULL = 0
SIZENODE = 16

colisaoDir crd <0,0>,<2,0>,<2,1>,<4,1>,<0,2>,<2,2>
colisaoEsq crd <2,0>,<4,0>,<0,1>,<2,1>,<2,2>,<4,2>
colisaoCim crd <2,0>,<0,1>,<2,1>,<4,1>,<0,2>,<4,2>
colisaoBai crd <0,0>,<4,0>,<0,1>,<2,1>,<4,1>,<2,2>

deviceConnect BYTE "DeviceConnect",0

SND_ALIAS    DWORD 00010000h
SND_RESOURCE DWORD 00040005h
SND_FILENAME DWORD 00020000h

tiroSoundF BYTE "c:\\LabArq2\MASM\shoot.wav",0
bateuSoundF BYTE "c:\\LabArq2\MASM\bateu.wav",0
fimSoundF BYTE "c:\\LabArq2\MASM\fim.wav",0

noRemover DWORD 0 
nodeInicio DWORD 0
hHeap DWORD ?
dwFlags DWORD HEAP_ZERO_MEMORY
nodePai DWORD 0
nodeInst node<>
quantTiros word 0
acertou byte 0
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
nave1 nave <5,5,1,3>
nave2 nave <50,20,3,3>
playerPress byte 0
messageDirections BYTE "Use the arrow keys to move", 0dh, 0ah, 0



tela DWORD 124, 108 dup(00),124
rowSize = ($ - tela)
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(45),124
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
		DWORD 124, 108 dup(00),124
		DWORD 124, 108 dup(00),124
		
		
.code

ClearScreen PROC
	mov ebx, OFFSET tela ;Move the tela 2D array into ebx
	add ebx, 1320
	mov ecx, 330 ;intialize the counter
	mov edx,00
Clear: 
	mov eax, [ebx]
	cmp eax , 124
	je invalido
	mov [ebx], edx ;Move the indirect value of ebx postion 1 into eax
invalido:
	add ebx, 4 ;Move to the next offset position
	inc ecx ;Increment the counter
	cmp ecx, 5610
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
	INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS
	INVOKE GetProcessHeap
	mov hHeap,eax
	mov  eax,lightGray+(black*16)
	call SetTextColor
	mov edx, OFFSET tela
leia:
	call ClearScreen 
	INVOKE mostrarTiros
	INVOKE desenhaVida
	call Draw
	INVOKE setPosNave1
	INVOKE setPosNave2
	call ReadKey
	
	mov playerPress , 2
	cmp al,108
	je Atirou
	
	mov playerPress , 1
	cmp al,104
	je Atirou
	
ControlesP1:
	cmp al,97
	je MudarEsquerdaP1
	cmp al,100
	je MudarDireitaP1
	cmp al,115
	je MudarBaixoP1
	cmp al,119
	je MudarCimaP1
	
ControlesP2:	
	cmp dx,25h
	je MudarEsquerdaP2
	cmp dx,27h
	je MudarDireitaP2
	cmp dx,28h
	je MudarBaixoP2
	cmp dx,26h
	je MudarCimaP2
	cmp dx,1Bh	
	je fim

MovP1:
	movzx eax, Byte PTR nave1.eixo
	cmp eax,1
	je MoverDireitaP1
	cmp eax,2
	je MoverCimaP1
	cmp eax,3
	je MoverEsquerdaP1
	cmp eax,4
	je MoverBaixoP1
	
MovP2:
	movzx eax, Byte PTR nave2.eixo
	cmp eax,1
	je MoverDireitaP2
	cmp eax,2
	je MoverCimaP2
	cmp eax,3
	je MoverEsquerdaP2
	cmp eax,4
	je MoverBaixoP2
	jmp leia
	
Atirou:	
    INVOKE PlaySound, OFFSET tiroSoundF, NULL, SND_FILENAME
	INVOKE criaTiro
	jmp MovP1
	
MudarDireitaP1:
	mov al , 1
	mov Byte PTR nave1.eixo , al
	jmp MovP1
	
MudarDireitaP2:
	mov al , 1
	mov Byte PTR nave2.eixo , al
	jmp MovP1

MudarEsquerdaP1:
	mov al , 3
	mov Byte PTR nave1.eixo , al
	jmp MovP1
	
MudarEsquerdaP2:
	mov al , 3
	mov Byte PTR nave2.eixo , al
	jmp MovP1
	
MudarCimaP1:
	mov al , 2
	mov Byte PTR nave1.eixo , al
	jmp MovP1
MudarCimaP2:
	mov al , 2
	mov Byte PTR nave2.eixo , al
	jmp MovP1

MudarBaixoP1:
	mov al , 4
	mov Byte PTR nave1.eixo , al
	jmp MovP1
	
MudarBaixoP2:
	mov al , 4
	mov Byte PTR nave2.eixo , al
	jmp MovP1

MoverDireitaP1:
	mov dx , WORD PTR nave1.x
	inc dx
	cmp dx, 104
	ja teleMovDP1
	jb incMovDP1
teleMovDP1:
	mov dx,1
incMovDP1:
	mov WORD PTR nave1.x , dx
	jmp MovP2
	
MoverDireitaP2:
	mov dx , WORD PTR nave2.x
	inc dx
	cmp dx, 104
	ja teleMovDP2
	jb incMovDP2
teleMovDP2:
	mov dx,1
incMovDP2:
	mov WORD PTR nave2.x , dx
	jmp leia
	
	
MoverEsquerdaP1:
	mov dx ,  WORD PTR nave1.x
	dec dx
	cmp dx, 0
	jb teleMovEP1
	ja decMovEP1
teleMovEP1:
	mov dx,104
decMovEP1:
	mov WORD PTR nave1.x , dx
	jmp MovP2
	
MoverEsquerdaP2:
	mov dx ,  WORD PTR nave2.x
	dec dx
	cmp dx, 0
	jb teleMovEP2
	ja decMovEP2
teleMovEP2:
	mov dx,104
decMovEP2:
	mov WORD PTR nave2.x , dx
	jmp leia

MoverCimaP1:
	mov dx ,  WORD PTR nave1.y
	dec dx
	cmp dx, 3
	jb teleMovCP1
	ja decMovCP1
teleMovCP1:
	mov dx,46
decMovCP1:
	mov WORD PTR nave1.y , dx
	jmp MovP2
	
MoverCimaP2:
	mov dx ,  WORD PTR nave2.y
	dec dx
	cmp dx, 2
	jb teleMovCP2
	ja decMovCP2
teleMovCP2:
	mov dx,50
decMovCP2:
	mov WORD PTR nave2.y , dx
	jmp leia

MoverBaixoP1:
	mov dx , WORD PTR nave1.y
	inc dx
	cmp dx, 50
	ja teleMovBP1
	jb incMovBP1
teleMovBP1:
	mov dx,3
incMovBP1:
	mov WORD PTR nave1.y , dx
	jmp MovP2
	
MoverBaixoP2:
	mov dx , WORD PTR nave2.y
	inc dx
	cmp dx, 50
	ja teleMovBP2
	jb incMovBP2
teleMovBP2:
	mov dx,3
incMovBP2:
	mov WORD PTR nave2.y , dx
	jmp leia
	
fim:
	exit

main ENDP

setPosNave1 PROC	USES eax ebx ecx ebx
	mov  eax,green+(black*16)
	
    call SetTextColor
	mov  dl,byte PTR nave1.x  ;column
    mov  dh,byte PTR nave1.y  ;row
	mov bh,dl
	mov ah,dh
	mov al,254
	movzx  ecx,Byte PTR  nave1.eixo
	cmp ecx, 1
	je NaveDireita
	cmp ecx, 2
	je NaveCima
	cmp ecx, 3
	je NaveEsquerda
	cmp ecx,4
	je NaveBaixo
		
NaveEsquerda:
	add dl,2
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	dec dl
	dec dl
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	jmp fim
	
NaveDireita:
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	dec dl
	dec dl
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	jmp fim

NaveCima:

	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	add dl,4
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	dec dl
	dec dl
	inc dh
	call Gotoxy
	call WriteChar
	add dl,4
	call Gotoxy
	call WriteChar
	jmp fim
	
NaveBaixo:
	call Gotoxy
	call WriteChar
	add dl,4
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	inc dh
	add dl,2
	call Gotoxy
	call WriteChar
	
	jmp fim
fim:
	mov  eax,lightGray+(black*16)
	call SetTextColor
	
	ret 
setPosNave1 ENDP


setPosNave2 PROC	USES eax ebx ecx ebx
	mov  eax,blue+(black*16)
	
    call SetTextColor
	mov  dl,byte PTR nave2.x  ;column
    mov  dh,byte PTR nave2.y  ;row
	mov bh,dl
	mov ah,dh
	mov al,254
	movzx  ecx,Byte PTR  nave2.eixo
	cmp ecx, 1
	je NaveDireita
	cmp ecx, 2
	je NaveCima
	cmp ecx, 3
	je NaveEsquerda
	cmp ecx,4
	je NaveBaixo
		
NaveEsquerda:
	add dl,2
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	dec dl
	dec dl
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	jmp fim
	
NaveDireita:
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	dec dl
	dec dl
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	add dl,2
	call Gotoxy
	call WriteChar
	jmp fim

NaveCima:

	add dl,2
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	add dl,4
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	dec dl
	dec dl
	inc dh
	call Gotoxy
	call WriteChar
	add dl,4
	call Gotoxy
	call WriteChar
	jmp fim
	
NaveBaixo:
	call Gotoxy
	call WriteChar
	add dl,4
	call Gotoxy
	call WriteChar
	inc dh
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	dec dl
	dec dl
	call Gotoxy
	call WriteChar
	inc dh
	add dl,2
	call Gotoxy
	call WriteChar
	
	jmp fim
fim:
	mov  eax,lightGray+(black*16)
	call SetTextColor
	ret
setPosNave2 ENDP

adicionarTiro PROC

	mov ecx,nodeInicio
	mov DWORD PTR nodeInst.pointer, ecx
	INVOKE HeapAlloc,hHeap,dwFlags,SIZENODE
	mov nodeInicio,eax
	mov ebx,DWORD PTR nodeInst.tiroIns.x
	mov [eax],ebx
	mov ebx, DWORD PTR nodeInst.tiroIns.y
	mov [eax + 4],ebx
	mov ebx,DWORD PTR nodeInst.tiroIns.direcao
	mov [eax + 8],ebx
	mov ebx,DWORD PTR nodeInst.pointer
	mov [eax + 0ch],ebx
	
	ret
adicionarTiro ENDP

retirarTiro PROC ,
	endNodeA : DWORD
	push ebx
	push eax
	push edx

	mov ebx, endNodeA
	mov edx, nodeInicio
	cmp ebx,edx
	je nodeInicioDel
	add ebx,0Ch
	mov eax, [ebx]
	cmp eax, 0
	je UmNode
	add eax,0Ch
	mov eax, [eax]
	mov edx, [ebx]
	mov [ebx] , eax
	jmp Desaloca

UmNode:
	mov edx, endNodeA 
	jmp Desaloca
nodeInicioDel:
	mov eax, [edx + 0ch]
	mov nodeInicio,eax
	jmp Desaloca
Desaloca:
	
	INVOKE HeapFree,hHeap,dwFlags,edx
	pop edx
	pop eax
	pop ebx
	ret
retirarTiro ENDP

criaTiro PROC
	mov ah, playerPress
	cmp ah,2
	je setTiro2
	mov eax, nave1.x
	mov ebx, nave1.y
	mov  dh,Byte PTR  nave1.eixo
	jmp adiciona
setTiro2:
	mov eax, nave2.x
	mov ebx, nave2.y
	mov  dh,Byte PTR  nave2.eixo
	
adiciona:
	mov cx, WORD PTR quantTiros
	inc cx
	mov WORD PTR quantTiros,cx
	cmp dh, 1
	je TiroDireita
	cmp dh, 2
	je TiroCima
	cmp dh, 3
	je TiroEsquerda
	cmp dh,4
	je TiroBaixo
	
TiroDireita:
	add eax,7
	add ebx,1
	mov dh, 1
	mov nodeInst.tiroIns.x,eax
	mov nodeInst.tiroIns.y,ebx
	mov nodeInst.tiroIns.direcao,dh
	jmp fim
	
TiroCima:
	add eax,2
	dec ebx
	dec ebx
	dec ebx
	mov dh, 2
	mov nodeInst.tiroIns.x,eax
	mov nodeInst.tiroIns.y,ebx
	mov nodeInst.tiroIns.direcao, dh
	jmp fim

TiroEsquerda:
	dec eax
	dec eax
	dec eax
	add ebx,1
	mov dh, 3
	mov nodeInst.tiroIns.x,eax
	mov nodeInst.tiroIns.y,ebx
	mov nodeInst.tiroIns.direcao, dh
	jmp fim
	
TiroBaixo:
	add eax,2
	add ebx,5
	mov dh, 4
	mov nodeInst.tiroIns.x,eax
	mov nodeInst.tiroIns.y,ebx
	mov nodeInst.tiroIns.direcao, dh
	jmp fim
fim:
	INVOKE adicionarTiro
	ret 
	
criaTiro ENDP

bateu PROC
	LOCAL temp : DWORD
Nv1RDano:	
	mov ah,Byte PTR  nave1.eixo
	mov ecx,6
	cmp ah, 1
	je Nv1ColDir
	cmp ah, 2
	je Nv1ColCim
	cmp ah, 3
	je Nv1ColEsq
	cmp ah, 4
	je Nv1ColBai

Nv1ColDir:
	mov ebx, OFFSET colisaoDir
	jmp Nv1TestCol
Nv1ColCim:
	mov ebx, OFFSET colisaoCim
	jmp Nv1TestCol
Nv1ColEsq:
	mov ebx, OFFSET colisaoEsq
	jmp Nv1TestCol
Nv1ColBai:
	mov ebx, OFFSET colisaoBai
	jmp Nv1TestCol
	
Nv1TestCol:
	movzx eax,byte PTR  [ebx] 
	mov temp, ecx
	add eax, nave1.x
	mov ecx,[edx]
	cmp eax, ecx
	je Nv1XIgual
	mov ecx,temp
	add ebx,2
	loop Nv1TestCol
	jmp Nv2RDano
Nv1XIgual:
	movzx eax,byte PTR  [ebx + 1] 
	add eax, nave1.y
	mov temp,ecx
	mov ecx,[edx + 4]
	cmp eax,ecx
	je Nv1YIgual
	mov ecx, temp
	add ebx,2
	loop Nv1TestCol
	jmp Nv2RDano
Nv1YIgual:
	INVOKE PlaySound, OFFSET bateuSoundF, NULL, SND_FILENAME
	mov ah,nave1.vida
	mov acertou,1
	cmp ah,0
	je morreuP1
	dec ah
morreuP1:
	mov nave1.vida , ah
	jmp Nv2RDano

Nv2RDano:	
	mov ah,Byte PTR  nave2.eixo
	mov ecx,6
	cmp ah, 1
	je Nv2ColDir
	cmp ah, 2
	je Nv2ColCim
	cmp ah, 3
	je Nv2ColEsq
	cmp ah, 4
	je Nv2ColBai

Nv2ColDir:
	mov ebx, OFFSET colisaoDir
	jmp Nv2TestCol
Nv2ColCim:
	mov ebx, OFFSET colisaoCim
	jmp Nv2TestCol
Nv2ColEsq:
	mov ebx, OFFSET colisaoEsq
	jmp Nv2TestCol
Nv2ColBai:
	mov ebx, OFFSET colisaoBai
	jmp Nv2TestCol
	
Nv2TestCol:
	movzx eax,byte PTR  [ebx] 
	mov temp, ecx
	add eax, nave2.x
	mov ecx,[edx]
	cmp eax, ecx
	je Nv2XIgual
	mov ecx,temp
	add ebx,2
	loop Nv2TestCol
	jmp Fim
Nv2XIgual:
	movzx eax,byte PTR  [ebx + 1] 
	add eax, nave2.y
	mov temp,ecx
	mov ecx,[edx + 4]
	cmp eax,ecx
	je Nv2YIgual
	mov ecx, temp
	add ebx,2
	loop Nv2TestCol
	jmp Fim
Nv2YIgual:
	INVOKE PlaySound, OFFSET bateuSoundF, NULL, SND_FILENAME
	mov ah,nave2.vida
	mov acertou,1
	cmp ah,0
	je morreuP2
	dec ah
morreuP2:
	mov nave2.vida , ah
	jmp Fim
Fim:
	ret
bateu ENDP

mostrarTiros PROC
	LOCAL temp:DWORD, countShoot: DWORD, tempNode: DWORD
	;int 3
	movzx ecx , WORD PTR quantTiros
	cmp ecx, 0
	je NenhumTiro
	mov edx, nodeInicio
	mov nodePai,edx
desenhaTiro:
	mov countShoot,ecx
	mov tempNode, edx
	INVOKE bateu
	mov eax,110
	mov edx,tempNode
	mov ebx, DWORD PTR [edx+4]
	mov  temp,edx
	mul ebx
	mov ebx, 4
	mul ebx
	mov ebx,eax
	mov ebx,eax
	mov  edx,temp
	mov  eax, DWORD PTR [edx]
	push ecx
	mov temp,edx
	mov ecx,4
	mul ecx
	mov edx,temp
	pop ecx
	add eax,ebx
	mov ebx, OFFSET tela 
	add ebx, eax
	mov eax,42
	mov [ebx],eax
	mov ah, byte PTR [edx+8]
	cmp ah ,1	
	je MTiroDireita
	cmp ah ,2 
	je MTiroCima
	cmp ah ,3 
	je MTiroEsquerda
	cmp ah ,4 
	je MTiroBaixo
MTiroDireita:
	mov eax, DWORD PTR [edx]
	inc eax
	inc eax
	cmp eax, 109
	ja teleD
	jb incD
teleD:
	mov eax,1
incD:
	mov DWORD PTR [edx],eax
	jmp fim
MTiroCima:
	mov eax, DWORD PTR [edx + 4]
	dec eax
	dec eax
	cmp eax, 3
	jb teleC
	ja decC
teleC:
	mov eax,50
decC:
	mov DWORD PTR [edx + 4],eax
	jmp fim
MTiroEsquerda:
	mov eax, DWORD PTR [edx]
	dec eax
	dec eax
	cmp eax, 0
	JLE  teleE
	JGE  decE
teleE:
	mov eax,108
decE:
	mov DWORD PTR [edx],eax
	jmp fim
MTiroBaixo:
	mov eax, DWORD PTR [edx + 4]
	inc eax
	inc eax
	cmp eax, 51
	ja teleB
	jb incB
teleB:
	mov eax,4
incB:
	mov DWORD PTR [edx + 4],eax
	jmp fim
fim:
	mov nodePai, edx
	add edx,0Ch
	mov edx, [edx]
	mov bh, acertou
	cmp bh,1
	je retTiro
	jne nRetTiro
retTiro:
	mov acertou,0
	mov bx , WORD PTR quantTiros
	dec bx
	mov quantTiros , bx
	mov ebx, nodePai
	INVOKE retirarTiro,ebx
nRetTiro:	
	mov ecx,countShoot
	dec ecx
	cmp ecx , 0
	jne desenhaTiro
NenhumTiro:
	ret
mostrarTiros ENDP

desenhaVida PROC
	mov ebx, OFFSET tela
	add ebx,800
	mov eax, 80
	mov [ebx], eax
	mov eax, 108
	mov [ebx + 4], eax
	mov eax, 97
	mov [ebx + 8], eax
	mov eax, 121
	mov [ebx + 12], eax
	mov eax, 101
	mov [ebx + 16], eax
	mov eax, 114
	mov [ebx + 20], eax
	mov eax, 49
	mov [ebx + 28], eax
	mov eax, 58
	mov [ebx + 36], eax
	add ebx,44
	mov ecx,3 
	movzx edx, nave1.vida
vida1:
	cmp edx, 0
	je zera1
	jne tem1
zera1:
	mov eax,0
	jmp imprime1
tem1:
	mov eax,254
	dec edx
imprime1:
	mov [ebx],eax
	add ebx , 8
	loop vida1
	
Ply2:
	mov ebx, OFFSET tela
	add ebx,22900
	mov eax, 80
	mov [ebx], eax
	mov eax, 108
	mov [ebx + 4], eax
	mov eax, 97
	mov [ebx + 8], eax
	mov eax, 121
	mov [ebx + 12], eax
	mov eax, 101
	mov [ebx + 16], eax
	mov eax, 114
	mov [ebx + 20], eax
	mov eax, 50
	mov [ebx + 28], eax
	mov eax, 58
	mov [ebx + 36], eax
	add ebx,44
	mov ecx,3 
	movzx edx, nave2.vida
vida2:
	cmp edx, 0
	je zera2
	jne tem2
zera2:
	mov eax,0
	jmp imprime2
tem2:
	mov eax,254
	dec edx
imprime2:
	mov [ebx],eax
	add ebx , 8
	loop vida2
fim:
	
	ret
desenhaVida ENDP

END main