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
removerTTiros PROTO
bateu PROTO
loopJogo PROTO
Py1Ganhou PROTO
Py2Ganhou PROTO
ClearScreen PROTO
Draw PROTO
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

som Byte 1
cor1 DWORD 0
cor2 DWORD 0

noRemover DWORD 0 
nodeInicio DWORD 0
hHeap DWORD ?
dwFlags DWORD HEAP_ZERO_MEMORY
nodePai DWORD 0
nodeInst node<>
quantTiros word 0
acertou byte 0
nave1 nave <5,5,1,3>
nave2 nave <50,20,3,3>
playerPress byte 0
messageDirections BYTE "Use the arrow keys to move", 0dh, 0ah, 0
perdeu Byte 0


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
		


rocketSpace0   BYTE "            ++++;                      +                          :++++`                                           ",0Dh,0Ah,0                                                     
rocketSpace1   BYTE "            +`  '+                     +               ;'        +;   :,                                           ",0Dh,0Ah,0                                                     
rocketSpace2   BYTE "            +    +.                   .+               +;       .+                                                 ",0Dh,0Ah,0                                                     
rocketSpace3   BYTE "           `+    +.   '+++'    +++++  ;+   +.  ++++'  +++++     ;+        ';++++   ;++++:   `++++,  ,++++          ",0Dh,0Ah,0                                                     
rocketSpace4   BYTE "           ,'    +   ;'   +`  +'      +, `+`  +;   +`  +        ,+;       ++   +,      `+  `+`     .+   '+         ",0Dh,0Ah,0                                                     
rocketSpace5   BYTE "           ';  ,+,   +    +: `+       +`,+   .+    +:  +         :+++'    +.   ''       +  +:      +`    +         ",0Dh,0Ah,0                                                     
rocketSpace6   BYTE "           ++++++   ,'    +, ';       +'+    +++++++, ,+            .++  `+    ''  ,+++++  +      .+++++++         ",0Dh,0Ah,0                                                     
rocketSpace7   BYTE "           +`   +.  ';    +` +`      .+++    +`       '+             `+  :+    +. ;+   :+  +      :+               ",0Dh,0Ah,0                                                     
rocketSpace8   BYTE "           +    +'  ';    +  +`      :' +;   +`       +,             `+  ;+    +  +    +:  +      :+               ",0Dh,0Ah,0                                                     
rocketSpace9   BYTE "          `+    .+  .+   +:  ''      +:  +,  +'       +`       `,    +,  ++   ':  +`  :+.  +`     `+               ",0Dh,0Ah,0                                                     
rocketSpace10  BYTE "          :'     +   ++++;    ++++'  +.  .+`  +++++.  '++'     ,+++++;   +.+++'   ;+++:+`  :++++   '+++++          ",0Dh,0Ah,0                                                     
rocketSpace11  BYTE "                                                                        `+                                         ",0Dh,0Ah,0                                                     
rocketSpace12  BYTE "                                                                        ,+                                         ",0Dh,0Ah,0                                                     
rocketSpace13  BYTE "                                                                        ;;                                         ",0Dh,0Ah,0 
rocketSpace14  BYTE "                                                                                                                   ",0Dh,0Ah,0
rocketSpace15  BYTE "                             * *                                            *   *                                  ",0Dh,0Ah,0
rocketSpace16  BYTE "                               * * - - - - - - - -                          * * *                                  ",0Dh,0Ah,0
rocketSpace17  BYTE "                             * *                                              *                                    ",0Dh,0Ah,0
rocketSpace18  BYTE "                                                                              |                                    ",0Dh,0Ah,0
rocketSpace19  BYTE "                                                                              |                                    ",0Dh,0Ah,0
rocketSpace20  BYTE "    *        ***  **   * ***   ***  ***    *    * *                                                                ",0Dh,0Ah,0
rocketSpace21  BYTE "   **         *   * *  *  *   *      *    * *   *  *                                                               ",0Dh,0Ah,0
rocketSpace22  BYTE "    *         *   *  * *  *   *      *   *   *  *  *                                                               ",0Dh,0Ah,0  
rocketSpace23  BYTE "    *         *   *   **  *   *      *   * * *  * *                                                                ",0Dh,0Ah,0
rocketSpace24  BYTE "   *** *     ***  *    * ***   ***  ***  *   *  *  *                                                               ",0Dh,0Ah,0
space0         BYTE "                                                                                                                   ",0Dh,0Ah,0
space1         BYTE "                                                                              |                                    ",0Dh,0Ah,0
rocketSpace25  BYTE "                                                                                                                   ",0Dh,0Ah,0
rocketSpace26  BYTE "   ****      ***  **   * ***  *****  * *   *  *   ***    *    ***  ***                                             ",0Dh,0Ah,0
rocketSpace27  BYTE "      *       *   * *  * *      *    *  *  *  *  *     *   *  *    *                                               ",0Dh,0Ah,0
rocketSpace28  BYTE "   ****       *   *  * * ***    *    *  *  *  *  *     *   *  **   ***                                             ",0Dh,0Ah,0  
rocketSpace29  BYTE "   *          *   *   **   *    *    * *   *  *  *     *   *  *      *                                             ",0Dh,0Ah,0
rocketSpace30  BYTE "   **** *    ***  *    * ***    *    *  *  ****   ***    *    ***  ***                                             ",0Dh,0Ah,0
space2         BYTE "                                                                              |                                    ",0Dh,0Ah,0
space3         BYTE "                                                                                                                   ",0Dh,0Ah,0
space4         BYTE "                                                                              |                                    ",0Dh,0Ah,0

rocketSpace31  BYTE "   ***       ***    *    **   *  ****   ***  * * *  *   *  * *     *    ***    *    ***  ***                       ",0Dh,0Ah,0
rocketSpace32  BYTE "      *     *     *   *  * *  *  *       *   *      *   *  *  *   * *  *     *   *  *    *                         ",0Dh,0Ah,0
rocketSpace33  BYTE "   ***      *     *   *  *  * *  ***     *   * * *  *   *  *  *  *   * *     *   *  **   ***                       ",0Dh,0Ah,0
rocketSpace34  BYTE "      *     *     *   *  *   **  *       *   *   *  *   *  * *   * * * *     *   *  *      *                       ",0Dh,0Ah,0
rocketSpace35  BYTE "   ***  *    ***    *    *    *  *      ***  * * *  * * *  *  *  *   *  ***    *    ***  ***                       ",0Dh,0Ah,0
space5         BYTE "                                                                              *                                    ",0Dh,0Ah,0
space6         BYTE "                                                                            * * *                                  ",0Dh,0Ah,0
space7         BYTE "                                                                            *   *                                  ",0Dh,0Ah,0
rocketSpace37  BYTE "   *  *      ***  * *   ***  ***   *** *****   *   ***                                                             ",0Dh,0Ah,0
rocketSpace38  BYTE "   *  *     *     *  *  *    *  *   *    *   *   * *                                                               ",0Dh,0Ah,0
rocketSpace39  BYTE "   ****     *     *  *  **   *  *   *    *   *   * ***                                                             ",0Dh,0Ah,0
rocketSpace40  BYTE "      *     *     * *   *    *  *   *    *   *   *   *                                                             ",0Dh,0Ah,0
rocketSpace41  BYTE "      * *    ***  *  *  ***  ***   ***   *     *   ***                                                             ",0Dh,0Ah,0
space8         BYTE "                                                                                                      *            ",0Dh,0Ah,0
space9         BYTE "                                                                                                    * * *          ",0Dh,0Ah,0
space10        BYTE "                                                                                                    *   *          ",0Dh,0Ah,0
rocketSpace44  BYTE "   ****     ***    *    ***  * *                                                                                   ",0Dh,0Ah,0
rocketSpace45  BYTE "   *        *     * *    *   *  *                                                                                  ",0Dh,0Ah,0
rocketSpace46  BYTE "   ****     ***  *   *   *   *  *                                                                                  ",0Dh,0Ah,0
rocketSpace47  BYTE "      *       *  * * *   *   * *                                                                                   ",0Dh,0Ah,0
rocketSpace48  BYTE "   **** *   ***  *   *  ***  *  *                                                                                  ",0Dh,0Ah,0

instrucoes0   BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes00  BYTE "       *****  *** *** *     *    ***    **   /*\    *****  /*\   ****  /*\            *   *       ",0Dh,0Ah,0
instrucoes01  BYTE "         *    *_  *   *    * *   *_     * * *   *     *   *   *  *__  *   *   *       * * *       ",0Dh,0Ah,0
instrucoes02  BYTE "         *    *   *   *   * * *    *    * * *   *   * *   *   *  *  * *   *             *         ",0Dh,0Ah,0
instrucoes03  BYTE "         *    *** *** *** *   *  ***    **   \*/    ***    \*/   ****  \*/    *         |         ",0Dh,0Ah,0
instrucoes04  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes05  BYTE "             *****  /*\  ****     *                                                               ",0Dh,0Ah,0
instrucoes06  BYTE "               *   *   * *__     **   *                                                           ",0Dh,0Ah,0
instrucoes07  BYTE "             * *   *   * *  *     *                                                               ",0Dh,0Ah,0
instrucoes08  BYTE "             ***    \*/  **** *   *   *                                                           ",0Dh,0Ah,0
instrucoes09  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes10  BYTE "                 *     *   /*\   *   * ***         *      ****    **    *       *                 ",0Dh,0Ah,0
instrucoes11  BYTE "                 **   **  *   *  *   * *_   *     * *     *__     * *    *  *  *                  ",0Dh,0Ah,0
instrucoes12  BYTE "                 * * * *  *   *   * *  *         * * *       *    * *     ** **                   ",0Dh,0Ah,0
instrucoes13  BYTE "                 *  *  *   \*/     *   ***  *    *   *    ****    **       * *                    ",0Dh,0Ah,0
instrucoes14  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes15  BYTE "                  ***  *   *   /*\   /*\  ***        ****                                         ",0Dh,0Ah,0
instrucoes16  BYTE "                 *__   * _ *  *   * *   *  *    *    *__                                          ",0Dh,0Ah,0
instrucoes17  BYTE "                    *  *   *  *   * *   *  *         *  *                                         ",0Dh,0Ah,0
instrucoes18  BYTE "                 ***   *   *   \*/   \*/   *    *    ****                                         ",0Dh,0Ah,0
instrucoes19  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes20  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes21  BYTE "             *****  /*\  ****    ****                                                  |          ",0Dh,0Ah,0
instrucoes22  BYTE "               *   *   * *__      __* *                                                *          ",0Dh,0Ah,0
instrucoes23  BYTE "             * *   *   * *  *    *                                                   * * *        ",0Dh,0Ah,0
instrucoes24  BYTE "             ***    \*/  **** *  **** *                                              *   *        ",0Dh,0Ah,0
instrucoes25  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes26  BYTE "                  *     *   /*\   *   * ***      /    \     /     \       \                       ",0Dh,0Ah,0
instrucoes27  BYTE "                  **   **  *   *  *   * *_   *  /      \   /       \     / \                      ",0Dh,0Ah,0
instrucoes28  BYTE "                  * * * *  *   *   * *  *       \       \ /        /    /   \                     ",0Dh,0Ah,0
instrucoes29  BYTE "                  *  *  *   \*/     *   ***  *   \       \        /    /     \                    ",0Dh,0Ah,0
instrucoes30  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes31  BYTE "                   *** *   *   /*\   /*\  ***        *                                            ",0Dh,0Ah,0
instrucoes32  BYTE "                  *__  * _ *  *   * *   *  *    *    *                                            ",0Dh,0Ah,0
instrucoes33  BYTE "                     * *   *  *   * *   *  *         *                                            ",0Dh,0Ah,0
instrucoes34  BYTE "                  ***  *   *   \*/   \*/   *    *    ****                                         ",0Dh,0Ah,0
espaco00      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco01      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco02      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco03      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco04      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco05      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco06      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco07      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco08      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco09      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco10      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco11      BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes35  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes36  BYTE "               /            *                                                                **          \   ",0Dh,0Ah,0
instrucoes37  BYTE "              < ----       * *                                                               * *   -----  >  ",0Dh,0Ah,0
instrucoes38  BYTE "               \          * * *                                                              * *         /   ",0Dh,0Ah,0
instrucoes39  BYTE "                          *   *                                                              **              ",0Dh,0Ah,0
instrucoes40  BYTE "            *     ***** *** **** *     *     * ***   ***  **** *     ***  ***  ***   *            ",0Dh,0Ah,0
instrucoes41  BYTE "           * *      *   *_  *    *    * *    * *_   *__   *    *    *__   *_   * *  * *           ",0Dh,0Ah,0
instrucoes42  BYTE "          * * *     *   *   *    *   * * *     *       *  *            *  *    **  * * *          ",0Dh,0Ah,0
instrucoes43  BYTE "          *   *     *   *** **** *** *   *     ***  ***   ****      ***   ***  * * *   *          ",0Dh,0Ah,0
instrucoes44  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes45  BYTE "          *   * ***** *** *   ***  ****   *    **    *       * *    *    ***    *                 ",0Dh,0Ah,0
instrucoes46  BYTE "          *   *   *    *  *    *     *   * *   * *  * *      *  *  * *   * *   * *                ",0Dh,0Ah,0
instrucoes47  BYTE "          *   *   *    *  *    *    *   * * *  * * * * *     * *  * * *  **   * * *               ",0Dh,0Ah,0
instrucoes48  BYTE "          *_ _*   *   *** *** ***  **** *   *  **  *   *     *    *   *  * *  *   *               ",0Dh,0Ah,0
instrucoes49  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes50  BYTE "           ***   *   *** **     **   /*\    ***** /*\   ****  /*\                                 ",0Dh,0Ah,0
instrucoes51  BYTE "          *__   * *   *  * *    * * *   *     *  *   *  *__  *   *                                ",0Dh,0Ah,0
instrucoes52  BYTE "             * * * *  *  **     * * *   *   * *  *   *  *  * *   *                                ",0Dh,0Ah,0
instrucoes53  BYTE "          ***  *   * *** * *    **   \*/    ***   \*/   ****  \*/                                 ",0Dh,0Ah,0
instrucoes54  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes55  BYTE "               _                                                                                  ",0Dh,0Ah,0
instrucoes56  BYTE "        /*\   *  \  *****  ***  *****  ***  *   *   /*\                                |          ",0Dh,0Ah,0
instrucoes57  BYTE "       *   *  * _/    *    *_     *     *   *   *  *   *   *                           *          ",0Dh,0Ah,0
instrucoes58  BYTE "       *   *  *  \  * *    *      *     *    * *   *   *                              ***         ",0Dh,0Ah,0
instrucoes59  BYTE "        \*/   *_ /  ***    ***    *    ***    *     \*/    *                          * *         ",0Dh,0Ah,0
instrucoes60  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes61  BYTE "                **   ***  *** ***** **  *   * *** **     /*\    *** **  * *** *   * *** ****  /*\ ",0Dh,0Ah,0
instrucoes62  BYTE "                * *  *_   *_    *   * * *   *  *  * *   *   *    *  * * *  *  ** **  *  *__  *   *",0Dh,0Ah,0
instrucoes63  BYTE "                * *  *      *   *   **  *   *  *  **    *   *    *  *  **  *  * * *  *  *  * *   *",0Dh,0Ah,0
instrucoes64  BYTE "                **   ***  ***   *   * * * _ * *** * *    \*/    *** *   * *** *   * *** ****  \*/ ",0Dh,0Ah,0
instrucoes65  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes66  BYTE "                 *   ***** ***  **     *   **  *  **    /*\     **  * ***  *   ***                ",0Dh,0Ah,0
instrucoes67  BYTE "                * *    *    *   * *   * *  * * *  * *  *   *    * * * *_   *   *_                 ",0Dh,0Ah,0
instrucoes68  BYTE "               * * *   *    *   **   * * * *  **  * *  *   *    *  ** *    *   *                  ",0Dh,0Ah,0
instrucoes69  BYTE "               *   *   *   ***  * *  *   * *   *  **    \*/     *   * ***  *** ***                ",0Dh,0Ah,0
espaco12      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco13      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco14      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco15      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco16      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco17      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco18      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco19      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco20      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco21      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco22      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco23      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco24      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco25      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco26      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco27      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco28      BYTE "                                                                                                  ",0Dh,0Ah,0
espaco29      BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes70  BYTE "                                                                                                  ",0Dh,0Ah,0
instrucoes71  BYTE "               /            *                                                                **          \   ",0Dh,0Ah,0
instrucoes72  BYTE "              < ----       * *                                                               * *   -----  >  ",0Dh,0Ah,0
instrucoes73  BYTE "               \          * * *                                                              * *         /   ",0Dh,0Ah,0
instrucoes74  BYTE "                          *   *                                                              **              ",0Dh,0Ah,0


		  
pula        BYTE "                                                                                              ",0Dh,0Ah,0
creditos00  BYTE "    **   ***  ***  ***  *  *  *   *  /*\  *   *   *  ***  **    /*\   ***  *** ***  *   * *   ",0Dh,0Ah,0                                                     
creditos01  BYTE "    * *  *_   *_   *_   ** *  *   * *   * *   *   *  *_   * *  *   *  * *  *_  *_       ***   ",0Dh,0Ah,0                                                     
creditos02  BYTE "    * *  *      *  *    * **   * *  *   * *    * *   *    * *  *   *  **   *     *  *    *    ",0Dh,0Ah,0                                                     
creditos03  BYTE "    **   ***  ***  ***  *  *    *    \*/  ***   *    ***  **    \*/   * *  *** ***       |    ",0Dh,0Ah,0 
creditos04  BYTE "                                                                                              ",0Dh,0Ah,0
creditos05  BYTE "           *    ***   /*\   **  *    *    ***  **    /*\      * *                             ",0Dh,0Ah,0
creditos06  BYTE "           *    *_   *   *  * * *   * *   * *  * *  *   *     *  *                            ",0Dh,0Ah,0
creditos07  BYTE "           *    *    *   *  *  **  * * *  **   * *  *   *     * *                             ",0Dh,0Ah,0
creditos08  BYTE "           * *  ***   \*/   *   *  *   *  * *  **    \*/      *    *                          ",0Dh,0Ah,0
creditos09  BYTE "                                                                                              ",0Dh,0Ah,0
creditos10  BYTE "           ***   /*\   **   ***  ***  ***   /*\        *                                      ",0Dh,0Ah,0
creditos11  BYTE "           * *  *   *  * *  * *   *   *_   *   *      * *                                     ",0Dh,0Ah,0
creditos12  BYTE "           **   *   *  * *  **    *   * *  *   *     * * *                                    ",0Dh,0Ah,0
creditos13  BYTE "           * *   \*/   **   * *  ***  ***   \*/      *   *  *                                 ",0Dh,0Ah,0
creditos14  BYTE "                                                                                              ",0Dh,0Ah,0
creditos15  BYTE "    **   /*\  *** *** **  * ***** ***  *               * *                               |    ",0Dh,0Ah,0
creditos16  BYTE "    * * *   * *   *_  * * *   *   *_                     * * - - - -                          ",0Dh,0Ah,0
creditos17  BYTE "    * * *   * *   *   *  **   *   *    *               * *                               |    ",0Dh,0Ah,0
creditos18  BYTE "    **   \*/  *** *** *   *   *   ***                                                         ",0Dh,0Ah,0
creditos19  BYTE "                                                                                              ",0Dh,0Ah,0
creditos20  BYTE "           *    *   *  ***  ***   *    **  *  /*\     **  *                                   ",0Dh,0Ah,0
creditos21  BYTE "           *    *   *  *     *   * *   * * * *   *    * * *                                   ",0Dh,0Ah,0
creditos22  BYTE "           *    *   *  *     *  * * *  *  ** *   *    *  **                                   ",0Dh,0Ah,0
creditos23  BYTE "           * *  * * *  ***  *** *   *  *   *  \*/     *   *  *                                ",0Dh,0Ah,0

venceu1     BYTE "    ______        __           __    ______     _______      ___       _______   ______   .______ ",0Dh,0Ah,0
venceu2     BYTE "   /  __  \      /_ |         |  |  /  __  \   /  _____|    /   \     |       \ /  __  \  |   _  \ ",0Dh,0Ah,0
venceu3     BYTE "  |  |  |  |      | |         |  | |  |  |  | |  |  __     /  ^  \    |  .--.  |  |  |  | |  |_)  |   ",0Dh,0Ah,0
venceu4     BYTE "  |  |  |  |      | |   .--.  |  | |  |  |  | |  | |_ |   /  /_\  \   |  |  |  |  |  |  | |      /  ",0Dh,0Ah,0
venceu5     BYTE "  |  `--'  |      | |   |  `--'  | |  `--'  | |  |__| |  /  _____  \  |  '--'  |  `--'  | |  |\  \-.",0Dh,0Ah,0
venceu6     BYTE "   \______/       |_|    \______/   \______/   \______| /__/     \__\ |_______/ \______/  | _| `.__| ",0Dh,0Ah,0
venceu7     BYTE "                                                                                                   ",0Dh,0Ah,0
venceu8     BYTE "                                                                                                   ",0Dh,0Ah,0
venceu9     BYTE "                                                                                                   ",0Dh,0Ah,0
venceu10    BYTE "                                                                                                   ",0Dh,0Ah,0


venceu11     BYTE "               ____    ____  _______ .__   __.   ______  _______  __    __      __ ",0Dh,0Ah,0
venceu12     BYTE "               \   \  /   / |   ____||  \ |  |  /      ||   ____||  |  |  |    |  |",0Dh,0Ah,0
venceu13     BYTE "                \   \/   /  |  |__   |   \|  | |  ,----'|  |__   |  |  |  |    |  | ",0Dh,0Ah,0
venceu14     BYTE "                 \      /   |   __|  |  . `  | |  |     |   __|  |  |  |  |    |  | ",0Dh,0Ah,0
venceu15     BYTE "                  \    /    |  |____ |  |\   | |  `----.|  |____ |  `--'  |    |__| ",0Dh,0Ah,0
venceu16     BYTE "                   \__/     |_______||__| \__|  \______||_______| \______/     (__) ",0Dh,0Ah,0

venceu17     BYTE "                             _                                       _ ",0Dh,0Ah,0
venceu18     BYTE "                            |     _ _          _ _ _ _   _ _    _ _   |",0Dh,0Ah,0
venceu19     BYTE "                            |    |      |\   |    |     |      |   |  |",0Dh,0Ah,0
venceu20     BYTE "                            |    |_ _   | \  |    |     |_ _   |   |  |",0Dh,0Ah,0
venceu21     BYTE "                            |    |      |  \ |    |     |      | --   |" ,0Dh,0Ah,0
venceu22     BYTE "                            |    |_ _   |   \|    |     |_ _   |  \   |",0Dh,0Ah,0
venceu23     BYTE "                            |_                                       _|",0Dh,0Ah,0

venceu24     BYTE "    ______        ___            __    ______     _______      ___       _______   ______   .______ ",0Dh,0Ah,0
venceu25     BYTE "   /  __  \      |__ \          |  |  /  __  \   /  _____|    /   \     |       \ /  __  \  |   _  \ ",0Dh,0Ah,0
venceu26     BYTE "  |  |  |  |        ) |         |  | |  |  |  | |  |  __     /  ^  \    |  .--.  |  |  |  | |  |_)  |   ",0Dh,0Ah,0
venceu27     BYTE "  |  |  |  |       / /    .--.  |  | |  |  |  | |  | |_ |   /  /_\  \   |  |  |  |  |  |  | |      /  ",0Dh,0Ah,0
venceu28     BYTE "  |  `--'  |      / /_    |  `--'  | |  `--'  | |  |__| |  /  _____  \  |  '--'  |  `--'  | |  |\  \-.",0Dh,0Ah,0
venceu29     BYTE "   \______/      |____|    \______/   \______/   \______| /__/     \__\ |_______/ \______/  | _| `.__| ",0Dh,0Ah,0
	 		 
config00   BYTE "                                                                                   ",0Dh,0Ah,0 
config01   BYTE "          ***   /*\   **   **                                                          | ",0Dh,0Ah,0   
config02   BYTE "         *__   *   *  * * * *    *                                                 ",0Dh,0Ah,0   
config03   BYTE "            *  *   *  * * * *                                                      ",0Dh,0Ah,0   
config04   BYTE "         ***    \*/   *  *  *    *                                                 ",0Dh,0Ah,0   
config05   BYTE "                                                          * *                      ",0Dh,0Ah,0  
config06   BYTE "                                                            * *   -       -          ",0Dh,0Ah,0 
config07   BYTE "                                                          * *                      ",0Dh,0Ah,0   
config08   BYTE "                     /*\  **  *   *       *  *                                     ",0Dh,0Ah,0   
config09   BYTE "                    *   * * * *           *__*                                     ",0Dh,0Ah,0   
config10   BYTE "                    *   * *  **   *       *  *                                     ",0Dh,0Ah,0   
config11   BYTE "                     \*/  *   *           *  *                                     ",0Dh,0Ah,0   
config12   BYTE "                                                                                   ",0Dh,0Ah,0   
config13   BYTE "                                                                                   ",0Dh,0Ah,0   
config14   BYTE "                     /*\  **** **** *       *                                        ",0Dh,0Ah,0   
config15   BYTE "                    *   * *_   *_           *                                        ",0Dh,0Ah,0   
config16   BYTE "                    *   * *    *    *       *                                        ",0Dh,0Ah,0   
config17   BYTE "                     \*/  *    *            ***                                      ",0Dh,0Ah,0   
config18   BYTE "                                                                                       |         ",0Dh,0Ah,0   
config19   BYTE "                                                                                                ",0Dh,0Ah,0   
config20   BYTE "                                                                                       *        ",0Dh,0Ah,0   
config21   BYTE "                                                                                     * * *         ",0Dh,0Ah,0   
config22   BYTE "                                                                                     *   *     ",0Dh,0Ah,0 

.code
main PROC
	
	INVOKE PlaySound, OFFSET deviceConnect, NULL, SND_ALIAS

    menu:
	CALL Randomize              
    CALL Clrscr
	MOV EDX, OFFSET rocketSpace0  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace1  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace2  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace3  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace4  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace5  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace6  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace7  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace8  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace9  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace10  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace11  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace12  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	MOV EDX, OFFSET rocketSpace13  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET rocketSpace14  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET rocketSpace15  
	MOV EAX, green + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET rocketSpace16  
	MOV EAX, green + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET rocketSpace17  
	MOV EAX, green + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET rocketSpace18  
	MOV EAX, green + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET rocketSpace19  
	MOV EAX, green + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET rocketSpace20  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET rocketSpace21  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET rocketSpace22  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

		MOV EDX, OFFSET rocketSpace23  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

		MOV EDX, OFFSET rocketSpace24  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
 	
		MOV EDX, OFFSET space0  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET space1  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET rocketSpace25  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET rocketSpace26  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET rocketSpace27  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET rocketSpace28  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET rocketSpace29  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET rocketSpace30  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET space2  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET space3  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET space4  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	
			MOV EDX, OFFSET rocketSpace31  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace32  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace33  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace34 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace35  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET space5  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET space6  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET space7  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	
				MOV EDX, OFFSET rocketSpace37  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace38  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace39  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace40  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace41  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET space8  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET space9  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET space10  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace44  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
				MOV EDX, OFFSET rocketSpace45  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET rocketSpace46  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET rocketSpace47  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET rocketSpace48  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	
    centralMenu:                      
    CALL ReadChar

    CMP AL, '1'                 
    JE Jogo
	jne OutrasOpcoes
Jogo:
	CALL Clrscr
	INVOKE loopJogo
	movzx eax, Byte PTR perdeu
	cmp eax,1
	je Jogador2G
	cmp eax,2
	je Jogador1G
	jne Encerrado
Jogador2G:
	Invoke Py2Ganhou
	jmp Encerrado
Jogador1G:
	Invoke Py1Ganhou	
Encerrado:
	mov perdeu,0
	jmp menu

OutrasOpcoes:

    CMP AL, '2'                 
    JE instrucoes

    CMP AL, '4'                 
    JE creditos
	
	CMP AL, '3'                 
    JE configuracoes

    CMP AL, '5'                 
    JE sair
	JNE centralMenu
	
	configuracoes:
	CALL Clrscr
	mov ebx, green
	mov ecx , white
	movzx eax,som
	cmp eax, 1
	je ligado
	jne desligado
	
ligado:
	mov cor1,ebx
	mov cor2,ecx
	jmp mostrarConf
desligado:
	mov cor1,ecx
	mov cor2,ebx
	
mostrarConf:
	MOV EDX, OFFSET config00  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET config01  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config02 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config03  
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config04 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config05  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config06  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config07 
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config08  
	MOV EAX, cor1 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config09 
	MOV EAX, cor1 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config10 
	MOV EAX, cor1 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config11 
	MOV EAX, cor1 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config12 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config13
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET config14
	MOV EAX, cor2 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config15
	MOV EAX, cor2 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config16
	MOV EAX, cor2 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config17
	MOV EAX, cor2 + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config18
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config19
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config20
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET config21 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET config22 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	CALL ReadChar
	CMP AL,'h'
	JE ligar
	CMP AL,'l'
	JE desligar
ligar:
	mov som,1
	jmp loopConf
desligar:
	mov som,2
loopConf:
	JE configuracoes
	JNE menu
	
	creditos:
	
    CALL Clrscr    

    MOV EDX, OFFSET pula     
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
    
    MOV EDX, OFFSET creditos00     
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	    MOV EDX, OFFSET creditos01     
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	    MOV EDX, OFFSET creditos02     
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

		
    MOV EDX, OFFSET creditos03     
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
 
    MOV EDX, OFFSET creditos04    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos05     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos06     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos07     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos08     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos09     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos10     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos11     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

    MOV EDX, OFFSET creditos12     
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 	
    
	MOV EDX, OFFSET creditos13    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET creditos14    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos15    
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos16    
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos17    
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos18    
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos19    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos20    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos21    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos22    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET creditos23    
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	CALL ReadChar
	JMP menu
	
	instrucoes:
	
    CALL Clrscr                 

		MOV EDX, OFFSET instrucoes0 
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

		MOV EDX, OFFSET instrucoes00 
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

	MOV EDX, OFFSET instrucoes01  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes02  
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 

		MOV EDX, OFFSET instrucoes03
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 	
	
		MOV EDX, OFFSET instrucoes04  
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes05 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes06 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes07 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes08 
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes09 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes10 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes11 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes12 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes13 
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes14
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes15
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes16
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes17
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes18
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes19
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes20
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes21
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes22
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes23
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes24
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes25
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes26
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
		MOV EDX, OFFSET instrucoes27
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes28
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes29
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes30
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes31
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes32
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes33
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString 
	
	MOV EDX, OFFSET instrucoes34
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET espaco00
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	MOV EDX, OFFSET espaco01
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	MOV EDX, OFFSET espaco02
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	MOV EDX, OFFSET espaco03
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco04
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco05
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco06
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco07
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco08
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco09
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco10
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco11
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	
		MOV EDX, OFFSET instrucoes35
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes36
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes37
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes38
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes39
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	CALL ReadChar
	CMP AL,'d'
	JE instrucoes1
	CMP AL, 'a'
	JE menu
	JNE instrucoes
	
	
	instrucoes1:
	
	CALL Clrscr
	
		MOV EDX, OFFSET instrucoes40
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes41
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes42
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes43
	MOV EAX, blue + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes44
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes45
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes46
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes47
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes48
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes49
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes50
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
		MOV EDX, OFFSET instrucoes51
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes52
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes53
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes54
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes55
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes56
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
		MOV EDX, OFFSET instrucoes57
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes58
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes59
	MOV EAX, red + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes60
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes61
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes62
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes63
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes64
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes65
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes66
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes67
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes68
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET instrucoes69
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET espaco12
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET espaco13
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET espaco14
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	MOV EDX, OFFSET espaco15
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco16
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco17
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco18
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco19
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco20
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco21
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco22
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString

	MOV EDX, OFFSET espaco23
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET espaco24
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET espaco25
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET espaco26
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET espaco27
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET espaco28
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
			MOV EDX, OFFSET espaco29
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	
		MOV EDX, OFFSET instrucoes70
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes71
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes72
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes73
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
		MOV EDX, OFFSET instrucoes74
	MOV EAX, white + (black * 16)
    CALL SetTextColor 	
    CALL WriteString
	
	CALL ReadChar
	CMP AL,'d'
	JE menu
	CMP AL, 'a'
	JE instrucoes
	JNE instrucoes1
	
	;configuracoes:

sair:
	exit

main ENDP	


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

loopJogo PROC
	INVOKE GetProcessHeap
	mov hHeap,eax
	mov  eax,lightGray+(black*16)
	call SetTextColor
	mov edx, OFFSET tela
repita:
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
	jmp repita
	
Atirou:	
	cmp som,0
	je semSomTiro
    INVOKE PlaySound, OFFSET tiroSoundF, NULL, SND_FILENAME
semSomTiro:
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
	jmp repita
	
	
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
	jmp repita

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
	jmp repita

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
	jmp repita
	
fim:
	INVOKE removerTTiros
	cmp som,0
	je semSomF
	INVOKE PlaySound, OFFSET fimSoundF, NULL, SND_FILENAME
semSomF:
	ret
	

loopJogo ENDP


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
	cmp  som,0
	je Nv1SemSom
	INVOKE PlaySound, OFFSET bateuSoundF, NULL, SND_FILENAME
Nv1SemSom:
	mov ah,nave1.vida
	mov acertou,1
	cmp ah,0
	je morreuP1
	dec ah
morreuP1:
	mov perdeu,1
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
	cmp som,0
	je Nv2SemSom
	INVOKE PlaySound, OFFSET bateuSoundF, NULL, SND_FILENAME
Nv2SemSom:	
	mov ah,nave2.vida
	mov acertou,1
	cmp ah,0
	je morreuP2
	dec ah
morreuP2:
	mov perdeu,2
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

removerTTiros PROC
	mov edx,nodeInicio
	cmp edx, 0
	jne Apagando
	je Vazio
Apagando:	
	mov ebx,[edx + 0ch]
	INVOKE HeapFree,hHeap,dwFlags,edx
	mov edx,ebx
	cmp edx, 0
	jne Apagando
	mov quantTiros,0	
	mov nodeInicio,0
Vazio:
	ret
removerTTiros ENDP
Py1Ganhou PROC
	MOV EAX, lightCyan + (black * 16)
    CALL SetTextColor 	
	MOV EDX, OFFSET venceu7
    CALL WriteString 
	MOV EDX, OFFSET venceu8
    CALL WriteString 
	MOV EDX, OFFSET venceu9 
    CALL WriteString 
	MOV EDX, OFFSET venceu10
    CALL WriteString 
	MOV EDX, OFFSET venceu1  
    CALL WriteString 
	MOV EDX, OFFSET venceu2  
    CALL WriteString 
	MOV EDX, OFFSET venceu3  
    CALL WriteString 
	MOV EDX, OFFSET venceu4
    CALL WriteString 
	MOV EDX, OFFSET venceu5
    CALL WriteString 
	MOV EDX, OFFSET venceu6  
    CALL WriteString 
	MOV EDX, OFFSET venceu7
    CALL WriteString 
	MOV EDX, OFFSET venceu8
    CALL WriteString 
	MOV EDX, OFFSET venceu9 
    CALL WriteString 
	MOV EDX, OFFSET venceu10
    CALL WriteString 
	MOV EDX, OFFSET venceu11
    CALL WriteString 
	MOV EDX, OFFSET venceu12 
    CALL WriteString 
	MOV EDX, OFFSET venceu13  
    CALL WriteString 
	MOV EDX, OFFSET venceu14  
    CALL WriteString 
	MOV EDX, OFFSET venceu15 
    CALL WriteString 
	MOV EDX, OFFSET venceu16  
    CALL WriteString 
	MOV EDX, OFFSET venceu7
    CALL WriteString 
	MOV EDX, OFFSET venceu8
    CALL WriteString 
	MOV EDX, OFFSET venceu9 
    CALL WriteString 
	MOV EDX, OFFSET venceu10
    CALL WriteString 
	MOV EDX, OFFSET venceu17
    CALL WriteString 
	MOV EDX, OFFSET venceu18
    CALL WriteString 
	MOV EDX, OFFSET venceu19 
    CALL WriteString 
	MOV EDX, OFFSET venceu20
    CALL WriteString 
	MOV EDX, OFFSET venceu21
    CALL WriteString 
	MOV EDX, OFFSET venceu22
    CALL WriteString 
	MOV EDX, OFFSET venceu23
    CALL WriteString 
	INVOKE sleep, 6000
	ret 

Py1Ganhou ENDP
Py2Ganhou PROC
	MOV EAX, lightCyan + (black * 16)
    CALL SetTextColor 	
	MOV EDX, OFFSET venceu7
    CALL WriteString 
	MOV EDX, OFFSET venceu8
    CALL WriteString 
	MOV EDX, OFFSET venceu9 
    CALL WriteString 
	MOV EDX, OFFSET venceu10
    CALL WriteString 
	MOV EDX, OFFSET venceu24  
    CALL WriteString 
	MOV EDX, OFFSET venceu25  
    CALL WriteString 
	MOV EDX, OFFSET venceu26 
    CALL WriteString 
	MOV EDX, OFFSET venceu27
    CALL WriteString 
	MOV EDX, OFFSET venceu28
    CALL WriteString 
	MOV EDX, OFFSET venceu29 
    CALL WriteString 
	MOV EDX, OFFSET venceu7
    CALL WriteString 
	MOV EDX, OFFSET venceu8
    CALL WriteString 
	MOV EDX, OFFSET venceu9 
    CALL WriteString 
	MOV EDX, OFFSET venceu10
    CALL WriteString 
	MOV EDX, OFFSET venceu11
    CALL WriteString 
	MOV EDX, OFFSET venceu12 
    CALL WriteString 
	MOV EDX, OFFSET venceu13  
    CALL WriteString 
	MOV EDX, OFFSET venceu14  
    CALL WriteString 
	MOV EDX, OFFSET venceu15 
    CALL WriteString 
	MOV EDX, OFFSET venceu16  
    CALL WriteString 
	MOV EDX, OFFSET venceu7
    CALL WriteString 
	MOV EDX, OFFSET venceu8
    CALL WriteString 
	MOV EDX, OFFSET venceu9 
    CALL WriteString 
	MOV EDX, OFFSET venceu10
    CALL WriteString 
	MOV EDX, OFFSET venceu17
    CALL WriteString 
	MOV EDX, OFFSET venceu18
    CALL WriteString 
	MOV EDX, OFFSET venceu19 
    CALL WriteString 
	MOV EDX, OFFSET venceu20
    CALL WriteString 
	MOV EDX, OFFSET venceu21
    CALL WriteString 
	MOV EDX, OFFSET venceu22
    CALL WriteString 
	MOV EDX, OFFSET venceu23
    CALL WriteString 
	INVOKE sleep, 6000
	ret 

Py2Ganhou ENDP
END main