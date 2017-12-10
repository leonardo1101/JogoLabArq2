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

noRemover DWORD 0 
nodeInicio DWORD 0
hHeap DWORD ?
dwFlags DWORD HEAP_ZERO_MEMORY
nodeInst node<>
quantTiros word 0

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
	INVOKE GetProcessHeap
	mov hHeap,eax
	
	mov edx, OFFSET tela
leia:
	call ClearScreen 
	INVOKE desenhaVida
	INVOKE setPosNave1
	INVOKE setPosNave2
	INVOKE mostrarTiros
	call Draw
	call ReadKey
	mov playerPress , 2
	cmp al,48
	je Atirou
	mov playerPress , 1
	cmp al,106
	je Atirou
	cmp al,97
	je MudarEsquerda
	cmp al,100
	je MudarDireita
	cmp al,115
	je MudarBaixo
	cmp al,119
	je MudarCima
	mov playerPress , 2
	cmp al,52
	je MudarEsquerda
	cmp al,54
	je MudarDireita
	cmp al,53
	je MudarBaixo
	cmp al,56
	je MudarCima
	cmp al,113	
	je fim

Controles:
	mov playerPress , 2
	movzx eax, Byte PTR nave2.eixo
	cmp eax,1
	je MoverDireita
	cmp eax,2
	je MoverCima
	cmp eax,3
	je MoverEsquerda
	cmp eax,4
	je MoverBaixo
	
MoverJogador1:
	mov playerPress , 1
	movzx eax, Byte PTR nave1.eixo
	cmp eax,1
	je MoverDireita
	cmp eax,2
	je MoverCima
	cmp eax,3
	je MoverEsquerda
	cmp eax,4
	je MoverBaixo
	jmp leia
	
Atirou:	
	INVOKE criaTiro
	jmp Controles
MudarDireita:
	mov al , 1
	mov bh, playerPress
	cmp bh,2
	je p2MD
	mov Byte PTR nave1.eixo , al
	jmp leia
p2MD:
	mov Byte PTR nave2.eixo , al
	jmp leia

MudarEsquerda:
	mov al , 3
	mov bh, playerPress
	cmp bh,2
	je p2ME
	mov Byte PTR nave1.eixo , al
	jmp leia
p2ME:
	mov Byte PTR nave2.eixo , al
	jmp leia
MudarCima:
	mov al , 2
	mov bh, playerPress
	cmp bh,2
	je p2MC
	mov Byte PTR nave1.eixo , al
	jmp leia
p2MC:
	mov Byte PTR nave2.eixo , al
	jmp leia

MudarBaixo:
	mov al , 4
	mov bh, playerPress
	cmp bh,2
	je p2MB
	mov Byte PTR nave1.eixo , al
	jmp leia
p2MB:
	mov Byte PTR nave2.eixo , al
	jmp leia

MoverDireita:
	mov bh, playerPress
	cmp bh,2
	mov dx , WORD PTR nave1.x
	inc dx
	inc dx
	je p2MOD
	mov WORD PTR nave1.x , dx
	jmp leia
p2MOD:
	mov dx , WORD PTR nave2.x
	inc dx
	inc dx
	mov WORD PTR nave2.x , dx
	jmp MoverJogador1
	
	
MoverEsquerda:
	mov bh, playerPress
	cmp bh,2
	je p2MOE
	mov dx ,  WORD PTR nave1.x
	dec dx
	dec dx
	mov WORD PTR nave1.x , dx
	jmp leia
p2MOE:
	mov dx ,  WORD PTR nave2.x
	dec dx
	dec dx
	mov WORD PTR nave2.x , dx
	jmp MoverJogador1

MoverCima:
	mov bh, playerPress
	cmp bh,2
	je p2MOC
	mov dx ,  WORD PTR nave1.y
	dec dx
	dec dx
	mov WORD PTR nave1.y , dx
	jmp leia
p2MOC:
	mov dx ,  WORD PTR nave2.y
	dec dx
	dec dx
	mov WORD PTR nave2.y , dx
	jmp MoverJogador1

MoverBaixo:
	mov bh, playerPress
	cmp bh,2
	je p2MOB
	mov dx , WORD PTR nave1.y
	inc dx
	inc dx
	mov WORD PTR nave1.y , dx
	jmp leia
p2MOB:
	mov dx , WORD PTR nave2.y
	inc dx
	inc dx
	mov WORD PTR nave2.y , dx
	jmp MoverJogador1
	
fim:
	exit

main ENDP

setPosNave1 PROC	USES eax ebx ecx ebx
	mov ecx,4
	mov eax,110
	mov  ebx, DWORD PTR nave1.y
	mul ebx
	mul ecx
	mov ebx,eax
	mov  eax, DWORD PTR nave1.x
	mul ecx
	add eax,ebx
	mov ebx, OFFSET tela 
	add ebx, eax
	mov eax,ebx
	
	movzx  edx,Byte PTR  nave1.eixo
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
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,448
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	jmp fim

NaveCima:
	mov edx,254
	add ebx, 12
	mov [ebx],edx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	mov [ebx],edx
	add ebx, 16
	mov [ebx],edx
	jmp fim
	
NaveBaixo:
	mov edx,254
	mov [ebx],edx
	add ebx, 16
	mov [ebx],edx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,888
	mov [ebx],edx
	jmp fim
fim:
	ret 
setPosNave1 ENDP


setPosNave2 PROC	USES eax ebx ecx ebx
	mov ecx,4
	mov eax,110
	mov  ebx, DWORD PTR nave2.y
	mul ebx
	mul ecx
	mov ebx,eax
	mov  eax, DWORD PTR nave2.x
	mul ecx
	add eax,ebx
	mov ebx, OFFSET tela 
	add ebx, eax
	mov eax,ebx
	
	movzx  edx,Byte PTR  nave2.eixo
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
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,448
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	jmp fim

NaveCima:
	mov edx,254
	add ebx, 12
	mov [ebx],edx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,880
	mov [ebx],edx
	add ebx, 16
	mov [ebx],edx
	jmp fim
	
NaveBaixo:
	mov edx,254
	mov [ebx],edx
	add ebx, 16
	mov [ebx],edx
	mov ebx,eax
	add ebx,440
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	add ebx, 8
	mov [ebx],edx
	mov ebx,eax
	add ebx,888
	mov [ebx],edx
	jmp fim
fim:
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

	mov ebx, endNodeA
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

Desaloca:
	
	INVOKE HeapFree,hHeap,dwFlags,edx

	ret
retirarTiro ENDP

criaTiro PROC
	mov ah, playerPress
	cmp ah,2
	je setTiro2
	mov eax, nave1.x
	mov ebx, nave1.y
	mov  dh,Byte PTR  nave1.eixo
setTiro2:
	mov eax, nave2.x
	mov ebx, nave2.y
	mov  dh,Byte PTR  nave2.eixo
	
	
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
	inc ebx
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
	add ebx,4
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
	movzx eax,byte PTR  [ebx + 4] 
	add eax, nave1.y
	mov temp,ecx
	mov ecx,[edx + 4]
	cmp eax,ecx
	je Nv1YIgual
	mov ecx,temp
	add ebx,2
	loop Nv1TestCol
	jmp Nv2RDano
Nv1YIgual:
	mov ecx,temp
	mov ah,nave1.vida
	dec ah
	;cmp ebx, 0  quando uma nave morre
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
	mov ah,nave2.vida
	cmp ah,0
	je perdeu
	dec ah
perdeu:
	mov nave2.vida , ah
	jmp Fim
Fim:
	ret
bateu ENDP

mostrarTiros PROC
	LOCAL temp:DWORD, countShoot: DWORD
	;int 3
	movzx ecx , WORD PTR quantTiros
	cmp ecx, 0
	je NenhumTiro
	mov edx, nodeInicio
desenhaTiro:
	mov countShoot,ecx
	INVOKE bateu
	mov eax,110
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
	mov DWORD PTR [edx],eax
	jmp fim
MTiroCima:
	mov eax, DWORD PTR [edx + 4]
	dec eax
	mov DWORD PTR [edx + 4],eax
	jmp fim
MTiroEsquerda:
	mov eax, DWORD PTR [edx]
	dec eax
	mov DWORD PTR [edx],eax
	jmp fim
MTiroBaixo:
	mov eax, DWORD PTR [edx + 4]
	inc eax
	mov DWORD PTR [edx + 4],eax
	jmp fim
fim:
	add edx,0Ch
	mov edx, [edx]
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
	dec edx
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