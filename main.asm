
FILE_BUF 	 equ #1388
DATA_LEN 	 equ #3b83
DATA_PTR 	 equ #4268



PLAYGND_SCR	 equ #e16a	; playground screen origin address
PLAYGND_DIM	 equ #d014	; playground dimensions		20x208
PLAYGND_OFSCR	 equ #2e53	; playground offscreen bitmap

; Dance floor and curtain offscreen buffers 
; are overlapping with playground offscreen buffer.
; They are not used simultaneously.
DANCE_FLR_OFSCR	 equ #2fc9	; Dance floor with columns and Alinka 34x100
CURTAIN_OFSCR 	 equ #3d55	; Curtain 34x8 (with did I use a copy of CURTAIN???) 


PLAYGND_MSK_BUF equ #3ebb	; Playground mask buffer
				; 22 lignes of 12 cells.
				; cell: 0 is empty, otherwise occupied


KOZAK_IN_BMP	 equ #4a9b	; Kozak coming in 4x25
KOZAK_OUT_BMP	 equ #4a3f	; Kozak going out 4x22 (or probably 4x23) 

CURTAIN_BMP	 equ #5bbf	; Curtain 34x8

LFT_COLUMN_BMP	 equ #5f77	; Left dance floor's column (5x100)
RGT_COLUMN_BMP	 equ #616b	; Right danc floor' column with Alinka (10x100)

KOZAK1_BMP	 equ #65e3	; Dancing1 10x32
KOZAK2_BMP	 equ #6723	; Dancing2 10x32
KOZAK3_BMP	 equ #6863	; Dancing3 10x32
KOZAK4_BMP	 equ #69a3	; Dancing4 10x32
KOZAK5_BMP	 equ #6ae3	; Dancing5 10x32
KOZAK6_BMP	 equ #6c23	; Dancing6 10x32
KOZAK7_BMP	 equ #6d63	; Dancing7 10x32
KOZAK8_BMP	 equ #6ea3	; Dancing8 10x32


EMPTY_BLOCK_BMP	 equ #6553	; id = #00
PURPLE_BLOCK_BMP equ #6563	; id = #01
RED_BLOCK_BMP	 equ #6573	; id = #02
ORANGE_BLOCK_BMP equ #6583	; id = #03
YELLOW_BLOCK_BMP equ #6593	; id = #04
GREEN_BLOCK_BMP  equ #65a3	; id = #05
BLUE_BLOCK_BMP   equ #65b3	; id = #06
LBLUE_BLOCK_BMP  equ #65c3	; id = #07
BLINK_BLOCK_BMP  equ #65d3	; id = #08


HSCORE_CHANGED	 equ #71e8	; High score changed

AMANT		 equ #7207	; Lover's Score entry
AMANT_SCORE	 equ #720b	; Lover's score
SOUPIRANT_1 	 equ #7210	; High Score table entry 1
SOUPIRANT_2 	 equ #721d	; High Score table entry 2
SOUPIRANT_3 	 equ #722a	; High Score table entry 3
SOUPIRANT_4 	 equ #7237	; High Score table entry 4
SOUPIRANT_5 	 equ #7244	; High Score table entry 5

P1_NAME		 equ #7282	; Player 1 name:"SOUPIRANT 1"
P2_NAME		 equ #7297	; Player 2 name:"SOUPIRANT 2"

CUR_LEVEL_PTR	 equ #7481	; current player level ptr
P1_LEVEL_PTR	 equ #7483	; P1 level ptr
P2_LEVEL_PTR	 equ #7485	; P2 level ptr
LEVEL_TABLE	 equ #7487	; Level table
				; 31 Level entries
				; 1 entry is 7 bytes long
				;    	0: nb lines ten's
				;    	1: nb lines unit's
				;    	2: ???? related to speed
				;    	3: trick flags, ie reverse rotation, reverse direction, random block, random lines
				;    	4: initial playground setup ptr LSB
				;    	5: initial playground setup ptr HSB
				;    	6: animation at the end: 0 or 1

CUR_SCORE_SCR 	 equ #7561	; Current score screen location

CUR_PLAYER	 equ #7565	; player +1

P1_GAME_OVER	 equ #7566	; True when player 1 is game over
P2_GAME_OVER	 equ #7567	; True when player 2 is game over

CUR_SCORE_X00001 equ #7568	; score X00001 +1
CUR_SCORE_X00010 equ #7569	; score X00010 +1
CUR_SCORE_X00100 equ #756a	; score X00100 +1
CUR_SCORE_X01000 equ #756b	; score X01000 +1
CUR_SCORE_X10000 equ #756c	; score X10000 +1

P1_SCORE_X00001  equ #756d	; player 1 score X00001 +1
P1_SCORE_X00010  equ #756e	; player 1 score X00010 +1
P1_SCORE_X00100  equ #756f	; player 1 score X00100 +1
P1_SCORE_X01000  equ #7570	; player 1 score X01000 +1
P1_SCORE_X10000  equ #7571	; player 1 score X10000 +1

P2_SCORE_X00001  equ #7572	; player 2 score X00001 +1
P2_SCORE_X00010  equ #7573	; player 2 score X00010 +1
P2_SCORE_X00100  equ #7574	; player 2 score X00100 +1
P2_SCORE_X01000  equ #7575	; player 2 score X01000 +1
P2_SCORE_X10000  equ #7576	; player 2 score X10000 +1

CUR_LEVEL_X10 	 equ #7577	; level X10 +1
CUR_LEVEL_X01 	 equ #7578	; level X01 +1

CUR_LIGNES_X10	 equ #7579	; current lignes X10 +1
CUR_LIGNES_X01	 equ #757a	; current lignes X01 +1


CUR_BONUS_X100	 equ #757b	; bonus X100 +1
CUR_BONUS_X010	 equ #757c	; bonus X010 +1
CUR_BONUS_X001	 equ #757d	; bonus X001 +1

PIECE_CUR_MSK_POS equ #757e	; current piece position in mask playground.
PIECE_PRV_MSK_POS equ #7580	; current piece next position in mask playground


PIECE_CUR_OFF_POS equ #758e	; current piece offscreen position
PIECE_PRV_SCR_POS equ #7590	; piece pos before rotating
PIECE_PRV_OFF_POS equ #7592	; previous piece offscreen position
PIECE_PRV_BMP	  equ #7594	; piece bitmap before rotating
PIECE_PRV_DIM	  equ #7596	; piece size (w/h) before rotating

				; Next piece definition

; Next piece definition's buffer
NXT_PIECE_AREA_POS equ #7598	; [0,1]  : piece's area screen addr
NXT_PIECE_SCR_POS  equ #759a	; [2,3]  : piece screen area
NXT_PIECE_CUR_BMP  equ #759c	; [4,5]  : memory bmp source addr
NXT_PIECE_CUR_DIM  equ #759e	; [6,7]  : bmp dimensions: width and height
NXT_PIECE_MSK_O1   equ #75a0	; [8,9]  : mask offset from piece origin of block 1 of the current piece
NXT_PIECE_MSK_O2   equ #75a2	; [10,11]: mask offset from piece origin of block 2 of the current piece
NXT_PIECE_MSK_O3   equ #75a4	; [12,13]: mask offset from piece origin of block 3 of the current piece
NXT_PIECE_MSK_O4   equ #75a6	; [14,15]: mask offset from piece origin of block 4 of the current piece
NXT_PIECE_ROT_OFF_OFST equ #75a8; [16,17]: offset to apply to offscreen position when rotating
NXT_PIECE_ROT_SCR_OFST equ #75aa; [18,19]: offset to apply to screen position when rotating
NXT_PIECE_ROT_BMP  equ #75ac	; [20,11]: bitmap pointer to the rotated piece
NXT_PIECE_ROT_O1   equ #75ae	; [22,13]: mask offset of block 1 of the rotated piece
NXT_PIECE_ROT_O2   equ #75b0	; [24,25]: mask offset of block 2 of the rotated piece
NXT_PIECE_ROT_O3   equ #75b2	; [26,27]: mask offset of block 3 of the rotated piece
NXT_PIECE_ROT_O4   equ #75b4	; [28,29]: mask offset of block 4 of the rotated piece



; Current piece definition's buffer
PIECE_CUR_SCR_POS  equ #75b6	; piece current screen position
PIECE_CUR_BMP	   equ #75b8	; piece bitmap
PIECE_CUR_DIM	   equ #75ba	; piece size (w/h)
PIECE_MSK_O1 	   equ #75bc	; mask offset from piece origin of block 1 of the current piece
PIECE_MSK_O2 	   equ #75be	; mask offset from piece origin of block 1 of the current piece
PIECE_MSK_O3 	   equ #75c0	; mask offset from piece origin of block 1 of the current piece
PIECE_MSK_O4	   equ #75c2	; mask offset from piece origin of block 1 of the current piece
PIECE_ROT_OFF_OFST equ #75c4    ; offset to apply to offscreen position when rotating
PIECE_ROT_SCR_OFST equ #75c6    ; offset to apply to screen position when rotating
PIECE_ROT_BMP 	   equ #75c8	; bitmap pointer to the rotated piece
PIECE_ROT_O1	   equ #75ca	; mask offset of block 1 of the rotated piece
PIECE_ROT_O2	   equ #75cc	; mask offset of block 2 of the rotated piece
PIECE_ROT_O3	   equ #75ce	; mask offset of block 3 of the rotated piece
PIECE_ROT_O4	   equ #75d0	; mask offset of block 4 of the rotated piece




	org #7E65
MAIN:
	; --------------------
	; Set border color
	; --------------------
	ld bc,#0404
	call #bc38

	; --------------------
	; Set pen colors (all the same)
	; to hide on screen data preparation
	; --------------------
	ld a,#10
.hide_loop:
	push af
	ld bc,#0404
	dec a
	call #bc32
	pop af
	dec a
	jr nz,.hide_loop

	; --------------------
	; WAIT FLYBACK
	call #bd19	
	; --------------------
	; SET SCR BASE #C000
	ld a,#c0
	call #bc08	
	; --------------------
	; SET SCR MODE 0
	ld a,#00
	call #bc0e	

	; --------------------
	; Deobfuscate DATA
	; --------------------
	ld hl,DATA_PTR	
	ld bc,DATA_LEN
.dobfuscate_loop:
	ld a,(hl)
	xor c
	ld (hl),a
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,.dobfuscate_loop

	; --------------------
	; replace DRAW_BITMAP NXT_LINE function 
	; by the kernel one (default screen width/height)
	; --------------------
	ld hl,#bc26
	ld (DRAW_ZBMP.nxt_fct),hl
	
	; 'Decompress' data to #C000
	ld hl,#c000
	ld de,#4268
	call DRAW_ZBMP

	; --------------------
	; move decompressed data to #400b
	; --------------------
	ld hl,#c000		
	ld de,#400b
	ld b,#c6
.move_loop1:
	push bc
	push hl
	ld c,#50
.move_loop2:
	ld a,(hl)
	ld (de),a
	inc de
	inc hl
	dec c
	jr nz,.move_loop2
	pop hl
	call #bc26	; kernel NXT LINE
	pop bc
	djnz .move_loop1

	; --------------------
	; restore DRAW_BITMAP NXT_LINE function 
	; for the modified screen width/height
	; --------------------
	ld hl,NXT_SCR_LINE		
	ld (DRAW_ZBMP.nxt_fct),hl


	; --------------------
	; load high socres
	; --------------------
;l7EC4
	ld hl,FILE_TBL
	ld de,FILE_BUF
	ld b,#0a
	call #bc77		; open file for input
	ld hl,AMANT		; destination address
	call #bc83		; read file
	call #bc7a		; close file

; l7ED8:
DISPLAY_LAYOUT:
	; --------------------
	; Configure CRTC - change screen width/height 
	; --------------------
	; BC01 -> #20		H DISPLAYED 32 characters
	; BC02 -> #2A		H SYNC 42
	; BC06 -> #20		V DISPLAYED 32
	; BC07 -> #22		V SYNC 34
	ld b,#04
	ld hl,crtc_conf
.crtc_loop:
	push bc
	ld bc,#00bc
	ld a,(hl)
	inc hl
	out (c),a
	inc b
	ld a,(hl)
	inc hl
	out (c),a
	pop bc
	djnz .crtc_loop

	; --------------------
	; Fill #C040 -> #FFFF with #C0
	; using stack pointer's push (thus going from #FFFF down to #C040)
	; 255*32 words = 16320 bytes 
	; --------------------
	ld (sp_tmp),sp
	ld sp,#0000
	ld hl,#c0c0
	ld b,#ff
.fill_loop:
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	push hl
	djnz .fill_loop
	ld sp,(sp_tmp)	; restore stack pointer.


	; --------------------
	; Draw game title
	; --------------------
	ld hl,#c000
	ld de,#4aff	
	call DRAW_ZBMP

	; --------------------
	; Draw box: playground area 
	; --------------------
	ld hl,#c168
	ld c,#14
	call BOX_TOP
	ld bc,PLAYGND_DIM
	call BOX_SIDES
	ld c,#14
	call BOX_BOTTOM

	; --------------------
	; Draw box: in game score 
	; --------------------
	ld hl,#c140
	ld c,#12
	call BOX_TOP
	ld bc,#2012
	call BOX_SIDES
	ld c,#12
	call BOX_BOTTOM

	; --------------------
	; Draw box: next piece 
	; --------------------
	ld hl,#c158
	ld c,#0a
	call BOX_TOP
	ld bc,#200a
	call BOX_SIDES
	ld c,#0a
	call BOX_BOTTOM

	; --------------------
	; Draw box: players area
	; --------------------
	ld hl,#e280
	ld c,#22
	call BOX_TOP
	ld bc,#2822
	call BOX_SIDES
	ld c,#22
	call BOX_BOTTOM

	; --------------------
	; Draw box: animation/menu area
	; --------------------
	ld hl,#c440
	ld c,#22
	call BOX_TOP
	ld bc,#7022
	call BOX_SIDES
	ld c,#22
	call BOX_BOTTOM

	; --------------------
	; Draw link pattern between next piece box and game box
	; --------------------
	ld hl,#d966
	ld b,#22
	ld de,box_link_pattern
.link_loop:
	push bc
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld (hl),a
	dec hl
	call NXT_SCR_LINE
	pop bc
	djnz .link_loop

	; --------------------------------
	; Set Game Border color	
	; --------------------------------
	ld b,#04
	ld c,b
	call #bc38

	; --------------------------------
	; Set Game Palette color (0-14)
	; --------------------------------
	ld hl,color_values
	ld a,#0f
.color_loop:
	push af
	dec a
	ld b,(hl)
	inc hl
	ld c,b
	push hl
	call #bc32
	pop hl
	pop af
	dec a
	jr nz,.color_loop

	; --------------------------------
	; Set flashing color (pen 15)
	; --------------------------------
	ld a,#0f
	ld b,#01
	ld c,#1a
	call #bc32
	ld hl,#0303
	call #bc3e
	jp CONFIGURATION
; Colors
color_values:	
	DB #1A,#13,#12,#09,#19,#18,#0F,#06
	DB #03,#10,#0B,#02,#01,#04,#00

; CRTC registers config
crtc_conf:
	DB #01,#20,#02,#2A,#06,#20,#07,#22

; Stack pointer backup
sp_tmp 	
	DB #00,#00

box_link_pattern:
	DB #0C,#0C,#CC,#0C,#CC,#CC,#0C,#CC
	DB #CC,#CC,#CC,#CC,#CC,#30,#CC,#CC
	DB #30,#CC,#30,#30,#CC,#30,#30,#30
	DB #30,#30,#0C,#30,#30,#0C,#0C,#30
	DB #0C,#0C

CONFIGURATION:
	; ----------------------------------------
	; Configure flyback callbacks
	; ----------------------------------------
	ld hl,FLBK_l8d63_BLOCK	; frame flyback block - Usage to be determined
	ld de,FLBK_l8d63_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block
	ld hl,FLBK_l8d63_BLOCK
	call #bcdd	; remove/disable block;

	ld hl,FLBK_l8dd0_BLOCK	; frame flyback block - Usage to be determined
	ld de,FLBK_l8dd0_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block
	ld hl,FLBK_l8dd0_BLOCK
	call #bcdd	; remove/disable block

	ld hl,FLBK_DANCE_BLOCK	; frame flyback block - Usage to be determined
	ld de,FLBK_DANCE_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block
	ld hl,FLBK_DANCE_BLOCK
	call #bcdd	; remove/disable block

	ld hl,FLBK_RNDM_BLCK_BLOCK	; frame flyback block - Usage to be determined
	ld de,FLBK_RNDM_BLCK_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block 
	ld hl,FLBK_RNDM_BLCK_BLOCK
	call #bcdd	; remove/disable block

	ld hl,FLBK_MOVE_UP_BLOCK	; frame flyback block	 - Usage to be determined
	ld de,FLBK_MOVE_UP_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM
	call #bcd7	; init block 
	ld hl,FLBK_MOVE_UP_BLOCK
	call #bcdd	; remove/disable block

	ld hl,FLBK_MELODY_BLOCK	; frame flyback block - Melody manager
	ld de,FLBK_MELODY_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM
	call #bcd7	; init block 
	ld hl,FLBK_MELODY_BLOCK
	call #bcdd	; remove/disable block

	ld hl,FLBK_MENU_ANIM_BLOCK ; frame flyback block	- Main screen animation handler
	ld de,FLBK_MENU_ANIM_ISR  ; event routine address
	ld bc,#8100	; B: evt class | C: ROM
	call #bcd7	; init block 
	ld hl,FLBK_MENU_ANIM_BLOCK
	call #bcdd	; remove/disable block

	; ----------------------------------------
	; Reset rotation direction
	; ----------------------------------------
	xor a
	ld (is_rot_reversed),a

	; ----------------------------------------
	; Disable KBD key repeat 
	; ----------------------------------------
	ld a,#50
.kdb_dsbl:
	ld b,#00
	dec a
	push af
	call #bb39
	pop af
	jr nz,.kdb_dsbl

	; ----------------------------------------
	; Set KBD repeat delays
	; ----------------------------------------
	ld hl,#0101
	call #bb3f

	; ----------------------------------------
	; Set KBD key mapping (normal and shift)
	; ----------------------------------------
	ld hl,#73e3
	ld a,#4e
.kbd_map:
	ld b,(hl)
	inc hl
	push hl
	dec a
	push af
	call #bb27
	pop af
	push af
	call #bb2d
	pop af
	pop hl
	jr nz,.kbd_map

	; ----------------------------------------
	; Clear offscreen playing area
	; 20*210
	; ----------------------------------------
	call CLEAR_PLAYGND_OFSCR

	; ----------------------------------------
	; Draw curtain
	; ----------------------------------------
	ld hl,#e442
	ld b,#03
.curt_loop:
	push bc
	push hl
	ld de,CURTAIN_BMP
	ld bc,#0822
	call DRAW_BMP

	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz .curt_loop

	; ----------------------------------------
	; Draw Player 1's head
	; ----------------------------------------
	ld hl,#e303
	ld de,#5eaf
	ld bc,#1405
	call DRAW_BMP

	; ----------------------------------------
	; Draw Player 2's head
	; ----------------------------------------
	ld hl,#c31e
	ld de,#5f13
	ld bc,#1405
	call DRAW_BMP
;#80de
MAIN_START:
	ld a,(HSCORE_CHANGED)
	dec a
	jr nz,MAIN_SCREEN
	ld (HSCORE_CHANGED),a

	; ----------------------------------------
	; Save High Score file	
	; ----------------------------------------
	ld b,#0a
	ld hl,FILE_TBL
	ld de,#1388
	call #bc8c
	ld hl,AMANT
	ld de,#004a
	ld bc,AMANT
	ld a,#05
	call #bc98
	call #bc8f
	jr MAIN_SCREEN
;#8105:
FILE_TBL:
	DB "ALINKA.TBL"

;#810f
MAIN_SCREEN:
	call ENBL_MELODY

	; Display "DEFI  01"
	ld de,#7269
	ld hl,#c183
	ld b,#08
	call DRW_TXT

	; Display "LIGNE 00"
	ld hl,#c1c3
	ld b,#08
	call DRW_TXT

	; Display "BONUS 000"
	ld hl,#c202
	ld b,#09
	call DRW_TXT

	; Display "SOUPIRANT 1"
	ld hl,#c2c4
	ld b,#0b
	call DRW_TXT

	; Display "00000"
	ld hl,#c30a
	ld b,#05
	call DRW_TXT

	; Display "00000"
	ld hl,#c392
	ld b,#05
	call DRW_TXT

	; Display "SOUPIRANT 2"
	ld hl,#c3cc
	ld b,#0b
	call DRW_TXT

	; Display "< ALINKA >"
	ld hl,#c509
	ld b,#0a
	call DRW_TXT

	; Display "L'AMANT:"
	ld hl,#c1ac
	ld de,#71e9
	ld b,#08
	call DRW_TXT

	; Display "<best player initiales and score>"
	ld hl,#c1eb
	ld de,AMANT
	ld b,#09
	call DRW_WTXT

	; Display "LES"
	ld hl,#c2b1
	ld de,#71f1
	ld b,#03
	call DRW_TXT

	; Display "MEILLEURS"
	ld hl,#c2eb
	ld b,#09
	call DRW_TXT

	; Display "SOUPIRANTS"
	ld hl,#c32a
	ld b,#0a
	call DRW_TXT

	; Display "<initiales 1>"
	ld hl,#c3ab
	ld de,SOUPIRANT_1
	ld b,#03
	call DRW_TXT

	; Display "<initiales 2>" 
	ld hl,#c3eb
	ld de,SOUPIRANT_2
	ld b,#03
	call DRW_TXT

	; Display "<initiales 3>" 
	ld hl,#c42b
	ld de,SOUPIRANT_3
	ld b,#03
	call DRW_TXT

	; Display "<initiales 4>" 
	ld hl,#c46b
	ld de,SOUPIRANT_4
	ld b,#03
	call DRW_TXT

	; Display "<initiales 5>" 
	ld hl,#c4ab
	ld de,SOUPIRANT_5
	ld b,#03
	call DRW_TXT

	; Enable high scores animation
	ld a,#03
	ld (HSCORE_DUR),a
	ld hl,FLBK_MENU_ANIM_BLOCK
	call #bcda

; Display main menu
MAIN_MENU:	
	; Display "1-  1 SOUPIRANT"
	ld de,#72ac
	ld hl,#c583
	ld b,#10
	call DRW_TXT
	; Display "2- 2 SOUPIRANTS"
	ld hl,#c5c3
	ld b,#10
	call DRW_TXT
	; Display "3- CHOIX DU DEFI"
	ld hl,#c643
	ld b,#10
	call DRW_TXT
	; Display "4- REDEFINIR LES"
	ld hl,#c683
	ld b,#10
	call DRW_TXT
	; Display "TOUCHES"
	ld hl,#c6cc
	ld b,#07
	call DRW_TXT
	; Display "PROGRAMME  DE"
	ld hl,#c746
	ld b,#0d
	call DRW_TXT
	; Display "ERIC BOUCHER"
	ld hl,#c786
	ld b,#0d
	call DRW_TXT

MAIN_CHOICE:	
	; Read keyboard
	call #bb09
	jr nc,MAIN_CHOICE
	cp #31
	jp z,MENU_1
	cp #32
	jp z,MENU_2
	cp #33
	jr z,MENU_3
	cp #34
	jp z,MENU_4
	jr MAIN_CHOICE

; -------------------
; Menu 3 - Choix du defi
; -------------------
MENU_3:
	ld hl,#c582
	ld bc,#3822
	call CLEAR_SCREEN_AREA
	; Display "TES"
	ld hl,#c5c6
	ld de,#7358
	ld b,#03
	call DRW_TXT
	; Display "INITIALES"
	inc hl
	inc hl
	ld b,#09
	call DRW_TXT
	; Display "..."
	ld hl,#c610
	ld b,#03
	call DRW_TXT
.letter1:
	ld de,custom_name
	ld hl,#c610
	call WAIT_KEY
	cp #7f		; Check Delete key
	jr z,.letter1
	ld (de),a	; Store letter
	call DRW_CHAR
.letter2:
	ld de,custom_name+1
	ld hl,#c612
	call WAIT_KEY
	cp #7f		; Check Delete key
	jr z,.letter1
	ld (de),a	; Store letter
	call DRW_CHAR

	ld de,custom_name+2
	ld hl,#c614
	call WAIT_KEY
	cp #7f		; Check Delete key
	jr z,.letter2
	ld (de),a	; Store letter
	call DRW_CHAR

	; Display "DEFI NUMERO .."
	ld hl,#c645
	ld de,#7251
	ld b,#0e
	call DRW_TXT
.defi1:
	ld de,start_levelX10	; Current defi ten's digit
	ld hl,#c65d
	call WAIT_KEY
	cp #7f		; Check Delete key
	jr z,.defi1
	cp #30		; Check < '0'
	jr c,.defi1
	cp #3a
	jr nc,.defi1	; Check > '9'
	push af
	call DRW_CHAR
	pop af
	or a
	sbc #2f
	ld (de),a	; Store
.defi2:
	ld de,start_levelX01	; Current defi unit's digit
	ld hl,#c65f
	call WAIT_KEY
	cp #7f		; Check Delete key
	jr z,.defi1
	cp #30		; Check < '0'
	jr c,.defi2
	cp #3a		; Check > '9'
	jr nc,.defi2
	push af
	call DRW_CHAR
	pop af
	or a
	sbc #2f
	ld (de),a	; Store 
	
	; Lookup name in high score table
	ld hl,SOUPIRANT_1
	ld b,#05
.check_custom_name:
	push bc
	ld de,custom_name
	ld b,#03
	push hl
.check_next:
	ld c,(hl)
	ld a,(de)
	cp c
	jp nz,.invalid
	inc hl
	inc de
	djnz .check_next
	; Initiales FOUND
	; Check level
	ld de,#0008
	add hl,de
	ld a,(start_levelX10)
	add #2f
	ld c,a
	ld a,(hl)
	cp c
	jp c,.invalid
	jr nz,.check_OK
	inc hl
	ld a,(start_levelX01)
	add #2f
	ld c,a
	ld a,(hl)
	cp c
	jp c,.invalid
.check_OK:
	pop hl
	pop bc
	; Display "OK"
	ld hl,#c691
	ld de,#725f
	ld b,#02
	call DRW_TXT

	call DELAY

	ld hl,LEVEL_TABLE-7	; <- level table ptr - 7
	ld a,(start_levelX10)
	dec a
	jr nz,.level_X10
	ld a,(start_levelX01)
	dec a
	jr z,.level_reset
	; Offset level ptr += 70 * tens
.level_X10:
	ld a,(start_levelX10)
.x10_loop:
	dec a
	jr z,.level_X01
	ld de,#0046
	add hl,de
	jr .x10_loop

	; Offset level ptr +=  7 * units
.level_X01:
	ld a,(start_levelX01)
.x01_loop:
	dec a
	jr z,.level_done
	ld de,#0007
	add hl,de
	jr .x01_loop

.level_done:
	ld (start_level_ptr),hl

	ld hl,#c582
	ld bc,#3822
	call CLEAR_SCREEN_AREA
	; Display level ten's digit in menu
	ld hl,#c18f
	ld a,(start_levelX10)
	add #2f
	call DRW_CHAR
	; Display level unit's digit in menu
	ld a,(start_levelX01)
	add #2f
	call DRW_CHAR
	jp MAIN_MENU

.level_reset:	; revert to level 01
	ld a,#01
	ld (start_levelX10),a
	inc a
	ld (start_levelX01),a
	ld hl,LEVEL_TABLE
	ld (start_level_ptr),hl
	ld hl,#c582
	ld bc,#3822
	call CLEAR_SCREEN_AREA
	ld hl,#c18f
	ld a,(start_levelX10)
	add #2f
	call DRW_CHAR
	ld a,(start_levelX01)
	add #2f
	call DRW_CHAR
	jp MAIN_MENU

.invalid:
	pop hl
	ld de,#000d
	add hl,de
	pop bc
	dec b
	jp nz,.check_custom_name
	ld hl,#c68b
	ld de,#7261
	ld b,#08
	call DRW_TXT
	call DELAY
	jr .level_reset

custom_name:
	DB	#00,#00,#00

; -------------------
; Menu 4 - Redefinir les touches
; -------------------
MENU_4:
	; Clear MENU Area
	ld hl,#c582
	ld bc,#3822
	call CLEAR_SCREEN_AREA
	
	; Display "DROITE:"
	ld hl,#c58a
	ld de,#730d
	ld b,#07
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Draw CHAR
	push af
	call DRW_CHAR
	pop af
	; Get corresponding key code
	call GET_KEY_CODE

	; Insert key code into playing routines
	ld (key_right),a
	ld (KEY.right),a

	; Display "GAUCHE:"
	ld hl,#c5ca
	ld b,#07
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Draw CHAR
	push af
	call DRW_CHAR
	pop af
	; Get corresponding key code
	call GET_KEY_CODE
	; Insert key code into playing routines
	ld (key_left),a
	ld (KEY.left),a

	; Display "ACCELERE:"
	ld hl,#c608
	ld b,#09
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Insert CHAR into routine ??
	ld (key_down),a
	; Draw CHAR
	call DRW_CHAR

	; Display "ROTATION:"
	ld hl,#c648
	ld b,#09
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Insert CHAR into routine ??
	ld (key_rotate),a
	; Draw CHAR
	call DRW_CHAR

	; Clear MENU Area
	ld hl,#c582
	ld bc,#3822
	call CLEAR_SCREEN_AREA
	jp MAIN_MENU

MENU_1:
	xor a
	ld (P1_GAME_OVER),a
	inc a
	ld (P2_GAME_OVER),a
	ld a,(start_levelX10)
	cp #01
	jr nz,.set_flag
	ld a,(start_levelX01)
	cp #02
	ld a,#00
	jr z,START_GAME
.set_flag:
	ld a,#01
	jr START_GAME

custom_game:	
	DB #00		; Whether the player choose a custom level (identified player)

MENU_2:
	ld a,#01
	ld (start_levelX10),a
	inc a
	ld (start_levelX01),a
	ld hl,#7487
	ld (start_level_ptr),hl
	xor a
	ld (P1_GAME_OVER),a
	ld (P2_GAME_OVER),a

; -----------------------------------------
; Start game
; A: 1 for custom game, 0 otherwise
; -----------------------------------------
START_GAME:
	; a==0 -> new game    :level 0
	; a!=0 -> resume game :custom level
	ld (custom_game),a
	; Disable HSCORE flyback block 
	ld hl,FLBK_MENU_ANIM_BLOCK
	call #bcdd

	; Clear playing area
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA

	call DANCE_FLR_CURTAIN_DOWN

	; Disable sound
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	call DSBL_MELODY
	
	; Setup level
	ld a,(start_levelX10)
	add #2f
	ld (#726f),a
	ld a,(start_levelX01)
	add #2f
	ld (#7270),a
	ld a,#01
	ld (P1_SCORE_X00001),a
	ld (P2_SCORE_X00001),a
	ld (P1_SCORE_X00010),a
	ld (P2_SCORE_X00010),a
	ld (P1_SCORE_X00100),a
	ld (P2_SCORE_X00100),a
	ld (P1_SCORE_X01000),a
	ld (P2_SCORE_X01000),a
	ld (P1_SCORE_X10000),a
	ld (P2_SCORE_X10000),a
start_level_ptr equ $ + 1
	ld hl,LEVEL_TABLE
	ld (P1_LEVEL_PTR),hl
	ld (P2_LEVEL_PTR),hl
start_levelX10 equ $ + 1
	ld a,#01
	ld (CUR_LEVEL_X10),a
start_levelX01 equ $ + 1
	ld a,#02
	ld (CUR_LEVEL_X01),a
	jr START_LEVEL

NEXT_LEVEL:
	ld a,(CUR_LEVEL_X01)
	inc a
	ld (CUR_LEVEL_X01),a
	cp #0b
	jr nz,START_LEVEL
	ld a,#01
	ld (CUR_LEVEL_X01),a
	ld a,(CUR_LEVEL_X10)
	inc a
	ld (CUR_LEVEL_X10),a

START_LEVEL:
	ld a,(CUR_LEVEL_X10)
	cp #04
	jr nz,.player1
	ld a,(CUR_LEVEL_X01)
	cp #03
	; Last level ?? 31
	jp z,GAME_FINISHED

.player1:
	ld a,(P1_GAME_OVER)
	dec a
	jr z,.player2
	jp PLAYER1
.player2:
	ld a,(P2_GAME_OVER)
	dec a
	jr z,NEXT_LEVEL
	jp PLAYER2

PLAYER1:
	ld a,#01
	ld (CUR_PLAYER),a
	ld hl,#c30a
	ld (CUR_SCORE_SCR),hl
	ld hl,P1_SCORE_X00001
	ld de,CUR_SCORE_X00001
	ld b,#05
.init_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .init_score

	ld hl,(P1_LEVEL_PTR)
	ld (CUR_LEVEL_PTR),hl
	ld de,P1_NAME
	
	call PLAY
	
	ld hl,(CUR_LEVEL_PTR)
	ld a,(hl)
	inc hl
	ld (P1_LEVEL_PTR),hl
	dec a

	call z,DANCE_FLR_ANIMATION

	ld de,P1_SCORE_X00001
	ld hl,CUR_SCORE_X00001
	ld b,#05
.store_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .store_score

	call FLBK_RNDM_BLCK_DISABLE
	call FLBK_MOVE_UP_DISABLE
	call SET_ROT_NORMAL
	call SET_DIR_NORMAL
	jp START_LEVEL.player2

PLAYER2:
	ld a,#02
	ld (CUR_PLAYER),a
	ld hl,#c392
	ld (CUR_SCORE_SCR),hl
	ld hl,CUR_SCORE_X00001
	ld de,P2_SCORE_X00001
	ld b,#05
.init_score:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .init_score

	ld hl,(P2_LEVEL_PTR)
	ld (CUR_LEVEL_PTR),hl

	ld de,P2_NAME
	call PLAY

	ld hl,(CUR_LEVEL_PTR)
	ld a,(hl)
	inc hl
	ld (P2_LEVEL_PTR),hl
	dec a
	call z,DANCE_FLR_ANIMATION

	ld de,P2_SCORE_X00001
	ld hl,CUR_SCORE_X00001
	ld b,#05
.store_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .store_score

	call FLBK_RNDM_BLCK_DISABLE
	call FLBK_MOVE_UP_DISABLE
	call SET_ROT_NORMAL
	call SET_DIR_NORMAL
	jp NEXT_LEVEL

PLAY:
	push de
	call CLEAR_PLAYGND_OFSCR
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA
	call DRAW_POPUP_BOX
	pop de
	; Draw "SOUPIRANT"
	ld hl,#c3eb
	ld b,#09
	call DRW_TXT
	; Skip space
	inc de
	; Draw "1/2" depending on value of reg DE
	ld hl,#c433
	ld b,#01
	call DRW_TXT
	; Draw "PRET"
	ld hl,#c470
	ld de,#732d
	ld b,#04
	call DRW_TXT

	call DELAY
	
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA

	ld hl,(CUR_LEVEL_PTR)		; ptr = &level[0]
	ld de,CUR_LIGNES_X10
	ld b,#02
.copy_lignes:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .copy_lignes

	ld (CUR_LEVEL_PTR),hl		; store ptr = &level[2]
	; Draw "DEFI"
	ld de,#73cf
	ld hl,#e36d
	ld b,#04
	call DRW_WTXT

	; Draw Current LEVEL
	inc hl
	inc hl
	ld a,(CUR_LEVEL_X10)
	add #2f
	call DRW_WCHAR
	ld a,(CUR_LEVEL_X01)
	add #2f
	call DRW_WCHAR

	; Draw NB LIGNES
	ld hl,#e3eb
	ld a,(CUR_LIGNES_X10)
	add #2f
	call DRW_WCHAR
	ld a,(CUR_LIGNES_X01)
	add #2f
	call DRW_WCHAR

	; Draw "LIGNES"
	inc hl
	inc hl
	ld b,#06
	call DRW_WTXT

	; Draw "A"
	ld hl,#e473
	ld b,#01
	call DRW_WTXT

	; Draw "COMPLETER"
	ld hl,#e4eb
	ld b,#09
	call DRW_WTXT

	; Display level info
	ld hl,#c18f
	ld a,(CUR_LEVEL_X10)
	add #2f
	call DRW_CHAR
	ld a,(CUR_LEVEL_X01)
	add #2f
	call DRW_CHAR

	ld hl,#c1cf
	ld a,(CUR_LIGNES_X10)
	add #2f
	call DRW_CHAR
	ld a,(CUR_LIGNES_X01)
	add #2f
	call DRW_CHAR

	call DELAY

	ld hl,(CUR_LEVEL_PTR)	; load ptr = &level[2] = speed ?
	ld a,(hl)
	ld (l88f6),a		; set variable (accualy poke the value into instrcution)

	; Update variable l8921 base on l88f6
	call UPDATE_l8921

	inc hl			; ptr = &level[3]
	ld a,(hl)		; 
	inc hl			; ptr = &level[4]
	ld (CUR_LEVEL_PTR),hl	; <- store ptr = &level[4]

	push af
	bit 7,a			; a.7 -> Random blocks
	call nz,FLBK_RNDM_BLCK_ENABLE
	pop af
	push af
	bit 6,a			; a.6 -> Playground move up
	call nz,FLBK_MOVE_UP_ENABLE
	pop af
	push af
	bit 5,a			; a.5 -> Piece rotation inverted
	call nz,SET_ROT_REVERSED
	pop af
	bit 4,a			; a.4 -> direction reversed 
	call nz,SET_DIR_REVERSED

	ld hl,(CUR_LEVEL_PTR)	; ptr = &level[4]
	push hl
	ld e,(hl)		; e = level[4]
	inc hl			
	ld d,(hl)		; d = level[5]
	inc hl			; <-- useless (probably)
	call SETUP_PLAYGROUND_MASK
	pop hl

	ld e,(hl)		; e = level[4]
	inc hl			; 
	ld d,(hl)		; d = level[5]
	inc hl			; ptr = &level[6]
	ld (CUR_LEVEL_PTR),hl 	; store current ptr = &level[6]
	call SETUP_PLAYGND_OFSCR

	; Draw playground
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP

	; Get first piece
	call GET_RNDM_PIECE
	
	; Draw it
	ld hl,(NXT_PIECE_AREA_POS)
	ld de,(NXT_PIECE_CUR_BMP)
	ld bc,(NXT_PIECE_CUR_DIM)
	call DRAW_BMP
	
	call DELAY

	call GAME_LOOP

	; Level terminated
	;

	call DELAY
	
	ld hl,#c34a
	ld bc,#0812
	call CLEAR_SCREEN_AREA
	
	ld hl,#e15a
	ld bc,#200a
	call CLEAR_SCREEN_AREA
	
	call DRAW_POPUP_BOX
	; Draw "DAMNED !!"
	ld hl,#c3eb
	ld de,#7343
	ld b,#09
	call DRW_TXT
	; Draw "DEFI"
	ld hl,#c430
	ld b,#04
	call DRW_TXT
	; Draw "REMPORTE"
	ld hl,#c46c
	ld b,#08
	call DRW_TXT

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "BONUS"
	ld hl,#c3ef
	ld de,#7279
	ld b,#05
	call DRW_TXT
	; Draw "MAESTRIA"
	ld hl,#c42c
	ld de,#7397
	ld b,#08
	call DRW_TXT

	call DELAY

	call COUNT_BONUS_MAESTRIA
	jp DELAY

COUNT_BONUS_MAESTRIA:
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP

	; Setup initial bonus value: 400
	ld a,#05
	ld (CUR_BONUS_X100),a
	ld a,#01
	ld (CUR_BONUS_X010),a
	ld (CUR_BONUS_X001),a
	ld hl,#c1aa
	ld bc,#1014
	call CLEAR_SCREEN_AREA
	jp .not_empty

.next:
	; Display current bonus value
	ld hl,#c20e
	ld a,(CUR_BONUS_X100)
	add #2f
	call DRW_CHAR
	ld a,(CUR_BONUS_X010)
	add #2f
	call DRW_CHAR
	ld a,(CUR_BONUS_X001)
	add #2f
	call DRW_CHAR
	
	; Check last line of mask playground 
	; to determine if it's empty
	ld hl,#3ddf
	ld b,#0a
.check:
	ld a,(hl)
	inc hl
	inc hl
	cp #00
	jp nz,.not_empty
	djnz .check

	; Line is empty
	; Bonus computation is finished.
	; Draw flame ???
	ld de,#5e0f
	ld bc,#0814
	ld hl,#e7aa
	call DRAW_BMP

	; Delay
	ld b,#64
.delay11:
	ld c,#64
.delay12:
	dec c
	jr nz,.delay12
	djnz .delay11

	; Clear line
	ld hl,#e7aa
	ld bc,#0814
	call CLEAR_SCREEN_AREA

	call DELAY

.decrease:
	ld a,(CUR_BONUS_X001)
	dec a
	ld (CUR_BONUS_X001),a

	jr nz,.display
	ld a,#0a
	ld (CUR_BONUS_X001),a
	ld a,(CUR_BONUS_X010)
	dec a
	ld (CUR_BONUS_X010),a
	jr nz,.display
	ld a,#0a
	ld (CUR_BONUS_X010),a
	ld a,(CUR_BONUS_X100)
	dec a
	ld (CUR_BONUS_X100),a
	jr nz,.display
	
	ld a,#01
	ld (CUR_BONUS_X100),a
	ld (CUR_BONUS_X010),a
	ld (CUR_BONUS_X001),a
.display:

	push af
	ld hl,#c20e
	ld a,(CUR_BONUS_X100)
	add #2f
	call DRW_CHAR
	ld a,(CUR_BONUS_X010)
	add #2f
	call DRW_CHAR
	ld a,(CUR_BONUS_X001)
	add #2f
	call DRW_CHAR
	
	ld b,#01
	call SCORE_ADD_UNITS
	
	pop af
	jr nz,.decrease
	ret

.not_empty:
	ld hl,#e7aa
	ld de,#5ccf
	ld bc,#0814
	call DRAW_BMP

	ld b,#64
.delay21:
	ld c,#96
.delay22:
	dec c
	jr nz,.delay22
	djnz .delay21

	; Move offscreen playground 1 line down
	ld hl,#3e93
	ld de,#3df3
	ld b,#c8
.move_h:
	ld c,#14
.move_w:
	ld a,(de)
	ld (hl),a
	dec de
	dec hl
	dec c
	jr nz,.move_w
	djnz .move_h

	; Explosion sound !!
	ld a,#06
	ld c,#1e
	call CFG_AY_SND
	ld a,#07
	ld c,#37
	call CFG_AY_SND
	ld a,#08
	ld c,#10
	call CFG_AY_SND
	ld a,#0b
	ld c,#a0
	call CFG_AY_SND
	ld a,#0c
	ld c,#0f
	call CFG_AY_SND
	ld a,#0d
	ld c,#09
	call CFG_AY_SND

	; Draw playground
	ld hl,#e1ea
	ld de,#2f93
	ld bc,#b814
	call DRAW_BMP

	; Draw burning line 
	ld hl,#e7aa
	ld de,#5d6f	
	ld bc,#0814
	call DRAW_BMP

	; Delay
	ld b,#64
.delay31:
	ld c,#c8
.delay32:
	dec c
	jr nz,.delay32
	djnz .delay31

	; Decrease maestria bonus
	or a
	ld a,(CUR_BONUS_X010)
	sbc #02
	ld (CUR_BONUS_X010),a
	jr nc,.cont
	add #0a
	ld (CUR_BONUS_X010),a
	ld a,(CUR_BONUS_X100)
	dec a
	ld (CUR_BONUS_X100),a
	jr nz,.cont
	ld a,#01
	ld (CUR_BONUS_X100),a
	ld (CUR_BONUS_X010),a
.cont:
	jp .next


GAME_LOOP:
	ld a,(key_down)		;
	call GET_KEY_CODE	;
	ld b,#ff		;
	call #bb39		; Set down key repeat allowed

	ld hl,#7125
	ld (l8d60),hl
	ld a,#01
	ld (l8d62),a
	ld hl,FLBK_l8d63_BLOCK
	call #bcda
	ld a,#07
	ld c,#30
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	call CFG_AY_SND
	xor a
	ld (#7582),a

l8867:

	; Move next piece info to current piece info
	ld hl,PIECE_CUR_SCR_POS
	ld de,NXT_PIECE_SCR_POS
	ld b,#1c
.copy:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz .copy

	; Get the next piece
	call GET_RNDM_PIECE

	ld hl,#2ef9			; reset offscreen1 start address ??
	ld (PIECE_CUR_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call DRAW_MASK_BMP_OFFSCREEN1

	ld hl,(PIECE_CUR_SCR_POS)
	ld de,(PIECE_CUR_OFF_POS)
	ld bc,(PIECE_CUR_DIM)
	call DRAW_BMP_SYNC

	ld hl,(NXT_PIECE_AREA_POS)
	ld de,(NXT_PIECE_CUR_BMP)
	ld bc,(NXT_PIECE_CUR_DIM)
	call DRAW_BMP
	
	ld b,#03
	call SCORE_ADD_UNITS

	ld bc,#61a8	; delay loop
l88ad:			; |
	dec bc		; |
	ld a,b		; |
	or c		; |
	jr nz,l88ad	; -

	ld hl,#3ebf
	ld (PIECE_CUR_MSK_POS),hl
	ld a,#01
	ld (l8d71),a
	ld a,#1a
	ld (#7583),a
	ld hl,#3eea
	ld (#7584),hl
	ld hl,#e22a
	ld (#7586),hl
	ld hl,#30d2
	ld (#7588),hl
	ld a,#18
	ld (#758b),a
	ld a,#03
	ld (#758a),a
l88de:
	ld a,(l8d71)
	dec a
	jr z,l88e9

	ld hl,l88fa
	jr l88ec
l88e9:
	ld hl,l890d
l88ec:
	ld (l890b),hl
	ld hl,l88fa
	ld (l891e),hl
l88f6 equ $ + 1
	ld a,#32
	ld (l8d72),a
l88fa:
	xor a
	call #bb1b
	push af
key_rotate equ $ + 1
	cp #20
	call z,ROTATE
	pop af
key_down equ $ + 1
	cp #0a
	jp z,MOVE_DOWN
l890b equ $ + 1
	jp l890d

key_left equ $ + 1
l890d:
	ld a,#08
	call #bb1e
	jp nz,MOVE_LEFT
key_right equ $ + 1
	ld a,#01		; right key
	call #bb1e		; is right pressed ?
	jp nz,MOMVE_RIGHT	; yes
l891e equ $ + 1
	jp l88fa		; no

l8921 equ $ + 1
l8920:
	ld a,#0c
	ld (l8d71),a
	ld hl,l88fa
	ld (l890b),hl
	jp l88fa

MOVE_DOWN:
	ld b,#01
	call SCORE_ADD_UNITS
l8933:
	ld hl,(PIECE_CUR_MSK_POS)
	ld bc,#000c
	add hl,bc
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_MSK_O1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld bc,(PIECE_MSK_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld bc,(PIECE_MSK_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld bc,(PIECE_MSK_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld hl,(PIECE_PRV_MSK_POS)
	ld (PIECE_CUR_MSK_POS),hl
	
	ld hl,(PIECE_CUR_SCR_POS)
	ld (PIECE_PRV_SCR_POS),hl
	ld bc,#0040
	add hl,bc
	ld (PIECE_CUR_SCR_POS),hl

	ld hl,(PIECE_CUR_OFF_POS)
	ld (PIECE_PRV_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_CUR_OFF_POS)
	ld bc,#00a0
	add hl,bc
	ld (PIECE_CUR_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call DRAW_MASK_BMP_OFFSCREEN1
	
	; draw offscreen playground
	; from previous pos to an extended height (one more line)
	; This will clear the piece from it previous position 
	; and display it at its new position.
	ld hl,(PIECE_PRV_SCR_POS)
	ld de,(PIECE_PRV_OFF_POS)
	ld bc,(PIECE_CUR_DIM)
	ld a,#08
	add b
	ld b,a
	call DRAW_BMP_SYNC
	
	; (#7583) = (#7583)-1
	ld a,(#7583)
	dec a
	ld (#7583),a
	
	; (#7586) = (#7586)+#40
	ld hl,(#7586)
	ld bc,#0040
	add hl,bc
	ld (#7586),hl

	; (#7584) = (#7584) + #0c
	ld hl,(#7584)
	ld bc,#000c
	add hl,bc
	ld (#7584),hl

	; (#7588) = (#7588) + #a0
	ld hl,(#7588)
	ld bc,#00a0
	add hl,bc
	ld (#7588),hl

	; (#758a) = (#758a) + 1
	ld a,(#758a)
	inc a
	ld (#758a),a

	; (#758b) = (#758b) + #08
	ld a,(#758b)
	ld b,#08
	add b
	ld (#758b),a

	jp l88de
l89ec:
	ld d,#08
	ld hl,#75d3
l89f1:
	ld c,(hl)
	inc hl
	ld a,(hl)
	inc hl
	call CFG_AY_SND
	dec d
	jr nz,l89f1
	ld b,#00
l89fd:
	ld c,#28
l89ff:
	dec c
	jr nz,l89ff
	djnz l89fd
	ld hl,(PIECE_CUR_MSK_POS)
	ld bc,(PIECE_MSK_O1)
	add hl,bc
	ld (hl),#01
	ld bc,(PIECE_MSK_O2)
	add hl,bc
	ld (hl),#01
	ld bc,(PIECE_MSK_O3)
	add hl,bc
	ld (hl),#01
	ld bc,(PIECE_MSK_O4)
	add hl,bc
	ld (hl),#01
	ld hl,#73a7
	ld (#758c),hl
	ld a,#00
	ld (#7560),a
	ld a,#d2
	ld (#75d2),a
	ld a,#00
	ld c,#00
	call CFG_AY_SND
	ld a,#06
	ld c,#00
	call CFG_AY_SND
	ld a,#07
	ld c,#38
	call CFG_AY_SND
	ld a,#08
	ld c,#00
	call CFG_AY_SND
	ld b,#04
l8a51:
	push bc
	ld hl,(#7584)
	ld c,#0c
l8a57:
	ld a,(hl)
	cp #01
	jp nz,l8c44
	dec hl
	dec c
	jr nz,l8a57
	ld de,#5ccf
	ld hl,(#7586)
	ld bc,#0814
	call DRAW_BMP
	ld b,#64
l8a6f:
	ld c,#64
l8a71:
	dec c
	jr nz,l8a71
	djnz l8a6f
	or a
	ld hl,(#7588)
	ld de,(#7588)
	ld bc,#ff60
	add hl,bc
	ld a,(#758b)
	ld b,a
l8a86:
	ld c,#14
l8a88:
	ld a,(hl)
	dec hl
	ld (de),a
	dec de
	dec c
	jr nz,l8a88
	djnz l8a86
	ld hl,(#7584)
	ld de,(#7584)
	ld bc,#fff4
	add hl,bc
	ld a,(#758a)
	ld b,a
l8aa0:
	ld c,#0c
l8aa2:
	ld a,(hl)
	dec hl
	ld (de),a
	dec de
	dec c
	jr nz,l8aa2
	djnz l8aa0
	ld de,#5d6f
	ld hl,(#7586)
	ld bc,#0814
	call DRAW_BMP
	ld b,#64
l8ab9:
	ld c,#64
l8abb:
	dec c
	jr nz,l8abb
	djnz l8ab9
	or a
	ld hl,(#7588)
	ld bc,#0028
	add hl,bc
	ld b,#14
l8aca:
	ld a,(hl)
	cp #00
	jr z,l8adb
	and #55
	cp #04
	jr nz,l8ad9
	xor #2a
	jr l8adb
l8ad9:
	ld a,#3f
l8adb:
	ld (hl),a
	dec hl
	djnz l8aca
	ld b,#14
l8ae1:
	ld a,(hl)
	cp #00
	jr z,l8ae8
	ld (hl),#3f
l8ae8:
	dec hl
	djnz l8ae1
	ld b,#14
l8aed:
	ld a,(hl)
	cp #00
	jr z,l8af4
	ld (hl),#0c
l8af4:
	dec hl
	djnz l8aed
	ld b,#14
l8af9:
	ld a,(hl)
	cp #00
	jr z,l8b0a
	and #aa
	cp #2a
	jr nz,l8b08
	xor #04
	jr l8b0a
l8b08:
	ld a,#0c
l8b0a:
	ld (hl),a
	dec hl
	djnz l8af9
	ld de,#5e0f
	ld hl,(#7586)
	ld bc,#0814
	call DRAW_BMP
	ld b,#64
l8b1c:
	ld c,#64
l8b1e:
	dec c
	jr nz,l8b1e
	djnz l8b1c
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP
	ld d,#03
l8b31:
	or a
	ld a,(#75d2)
	ld b,#1e
	sbc b
	ld (#75d2),a
	ld c,a
	ld a,#00
	call #bd34
	ld a,#08
	ld c,#0f
	call #bd34
	ld b,#00
l8b4a:
	ld c,#14
l8b4c:
	dec c
	jr nz,l8b4c
	djnz l8b4a
	ld a,#08
	ld c,#00
	call #bd34
	ld b,#00
l8b5a:
	ld c,#1e
l8b5c:
	dec c
	jr nz,l8b5c
	djnz l8b5a
	dec d
	jr nz,l8b31
	ld a,#08
	ld c,#00
	call #bd34
	ld a,(#75d2)
	ld b,#32
	add b
	ld (#75d2),a
	ld a,#49
	ld (l8dde),a
	ld hl,FLBK_l8dd0_BLOCK
	call #bcda
	ld a,(l88f6)
	dec a
	jr z,l8b8b
	ld (l88f6),a
	call UPDATE_l8921
l8b8b:
	ld b,#0a
	ld hl,#c349
	ld de,(#758c)
	call DRW_TXT
	ld (#758c),de
	ld a,(#7560)
	inc a
	ld (#7560),a
	ld a,(#7583)
	dec a
	ld (#7583),a
	ld a,(#7582)
	dec a
	ld (#7582),a
	ld a,(CUR_LIGNES_X01)
	dec a
	ld (CUR_LIGNES_X01),a
	jr nz,l8bcf
	ld a,#0a
	ld (CUR_LIGNES_X01),a
	ld a,(CUR_LIGNES_X10)
	dec a
	ld (CUR_LIGNES_X10),a
	jr nz,l8bcf
	ld a,#01
	ld (CUR_LIGNES_X10),a
	ld (CUR_LIGNES_X01),a
l8bcf:
	ld hl,#c1cf
	ld a,(CUR_LIGNES_X10)
	add #2f
	call DRW_CHAR
	ld a,(CUR_LIGNES_X01)
	add #2f
	call DRW_CHAR
l8be2:
	pop bc
	dec b
	jp nz,l8a51
	ld a,(#7560)
	cp #00
	jr z,l8c0e
	cp #01
	jr nz,l8bf9
	ld b,#05
	call SCORE_ADD_TENS
	jr l8c0e
l8bf9:
	cp #02
	jr nz,l8c01
	ld b,#01
	jr l8c0b
l8c01:
	cp #03
	jr nz,l8c09
	ld b,#02
	jr l8c0b
l8c09:
	ld b,#04
l8c0b:
	call SCORE_ADD_HDRDS
l8c0e:
	ld a,(CUR_LIGNES_X01)
	dec a
	ld b,a
	ld a,(CUR_LIGNES_X10)
	dec a
	or b
	jr z,l8c75
	ld a,(#7583)
	ld b,a
	ld a,(#7582)
	sbc b
	jp nc,l8c2c
	or a
	ld a,(#7583)
	ld (#7582),a
l8c2c:
	ld a,(#7582)
	cp #18
	jr nc,GAME_OVER
	ld a,(FLBK_RNDM_BLCK_CNT)
	dec a
	call z,INSERT_RNDM_BLCK
	ld a,(FLBK_MOVE_UP_CNT)
	dec a
	call z,PLAYGROUND_MOVE_UP
	jp l8867
l8c44:
	ld hl,(#7586)
	ld bc,#ffc0
	add hl,bc
	ld (#7586),hl
	ld hl,(#7588)
	ld bc,#ff60
	add hl,bc
	ld (#7588),hl
	ld hl,(#7584)
	ld bc,#fff4
	add hl,bc
	ld (#7584),hl
	ld a,(#758a)
	dec a
	ld (#758a),a
	ld a,(#758b)
	ld b,#f8
	add b
	ld (#758b),a
	jp l8be2

l8c75:
	ld a,(key_down)
	call GET_KEY_CODE
	ld b,#00
	call #bb39	; Disable KEY repeat
	ld hl,FLBK_l8d63_BLOCK
	call #bcdd	; Disable Flyback block
	
	ld hl,(l8d60)	; Load note address
	ld a,(hl)	; load note
	ld c,a		; c = note

	ld b,#32	; Loop
.loop:			; |
	push bc		; | 
	ld a,#04	; |  
	call CFG_AY_SND	; | play note
			; |
	ld bc,#07d0	; |  Delay
.delay:			; |  |
	dec bc		; |  |
	ld a,b		; |  |
	or c		; |  |
	jr nz,.delay	; |  -
			; |
	pop bc		; |
	dec c		; |
	djnz .loop	; -

	ld a,#0a	; Sound
	ld c,#00	; |
	jp CFG_AY_SND	; OFF


GAME_OVER:
	ld a,(key_down)
	call GET_KEY_CODE
	ld b,#00	
	call #bb39	; Disable KEY repeat
	ld hl,FLBK_l8d63_BLOCK
	call #bcdd	; Disable Flyback block

	call FLBK_RNDM_BLCK_DISABLE
	call FLBK_MOVE_UP_DISABLE
	call SET_ROT_NORMAL
	call SET_DIR_NORMAL

	ld hl,(l8d60)	; Load note address
	ld a,(hl)	; load note
	ld c,a		;
	ld b,#32	; Loop
l8cca:			; |
	push bc		; |
	ld a,#04	; |
	call CFG_AY_SND	; | play note
			; |
	ld bc,#07d0	; | Delay
l8cd3:			; | |
	dec bc		; | |
	ld a,b		; | |
	or c		; | |
	jr nz,l8cd3	; | -
			; |
	pop bc		; |
	inc c		; |
	djnz l8cca	; -

	ld a,#0a	; sound
	ld c,#00	; |
	call CFG_AY_SND	; OFF

	pop hl		;
	ld a,(CUR_PLAYER);|
	dec a		; |
	jr z,l8cef
	
	ld (P2_GAME_OVER),a	; <- PLAYER 2 GAME OVER
	jr l8cf3

l8cef:
	inc a		
	ld (P1_GAME_OVER),a	; <- PLAYER 1 GAME OVER

l8cf3:
	call DRAW_POPUP_BOX
	; Draw "SOUPIRANT"
	ld hl,#c3eb
	ld de,P1_NAME
	ld b,#09
	call DRW_TXT
	; Draw "<current player>"
	ld hl,#c433
	ld a,(CUR_PLAYER)
	add #30
	call DRW_CHAR
	; Draw "Dommage"
	ld hl,#c46d
	ld de,#7331
	ld b,#07
	call DRW_TXT

	call DELAY
	call DRAW_POPUP_BOX
	; Draw "TU AS"
	ld hl,#c3ef
	ld de,#7338
	ld b,#05
	call DRW_TXT
	; Draw "ECHOUE"
	ld hl,#c42e
	ld de,#733d
	ld b,#06
	call DRW_WTXT

	call DELAY
	call CHECK_HIGH_SCORE

	ld a,(P1_GAME_OVER)
	dec a
	ld b,a
	ld a,(P2_GAME_OVER)
	dec a
	or b
	ret nz 		; Still 1 player alive

	; GAME OVER
	pop hl
	ld hl,#e15a
	ld bc,#200a
	call CLEAR_SCREEN_AREA
	call CLEAR_PLAYGND_OFSCR
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA
	call DANCE_FLR_CURTAIN_UP
	jp MAIN_START
l8d60:
	DB #00
	DB #00
l8d62:
	DB #00
FLBK_l8d63_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00
l8d71:
	DB #00
l8d72:
	DB #00
	DB #00

; ----------------------------
; Automatic move down ISR
; need some work...
; ----------------------------
; #8d74
FLBK_l8d63_ISR:
	di
	push af
	push hl
	push bc
	ld a,(l8d62)
	dec a
	jr nz,l8da1
	ld hl,(l8d60)
l8d81:
	ld a,(hl)
	inc a
	jr nz,l8d8d
	ld hl,#7125
	ld (l8d60),hl
	jr l8d81
l8d8d:
	inc hl
	ld (l8d60),hl
	dec a
	ld c,a
	ld a,#04
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	call CFG_AY_SND
	ld a,#09
l8da1:
	ld (l8d62),a
	ld a,(l8d71)
	dec a
	jp z,l8dc8
	ld (l8d71),a
l8dae:
	ld a,(l8d72)
	dec a
	jp z,l8dbd
	ld (l8d72),a
l8db8:
	pop bc
	pop hl
	pop af
	ei
	ret

l8dbd:
	ld hl,l8933
	ld (l890b),hl
	ld (l891e),hl
	jr l8db8
l8dc8:
	ld hl,l890d
	ld (l890b),hl
	jr l8dae

FLBK_l8dd0_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00
l8dde:
	DB #00

; #8ddf
FLBK_l8dd0_ISR:
	di
	push hl
	push af
	push de
	push bc
	ld a,(l8dde)
	dec a
	ld (l8dde),a
	jr nz,l8dfc
	ld hl,#c349
	ld bc,#0814
	call CLEAR_SCREEN_AREA
	ld hl,FLBK_l8dd0_BLOCK
	call #bcdd
l8dfc:
	pop bc
	pop de
	pop af
	pop hl
	ei
	ret



ROTATE:
	ld hl,(PIECE_CUR_OFF_POS)
	ld (PIECE_PRV_OFF_POS),hl
	ld hl,(PIECE_CUR_SCR_POS)
	ld (PIECE_PRV_SCR_POS),hl
	ld hl,(PIECE_CUR_DIM)
	ld (PIECE_PRV_DIM),hl
	ld hl,(PIECE_CUR_BMP)
	ld (PIECE_PRV_BMP),hl
	ld hl,(PIECE_CUR_MSK_POS)
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_ROT_O1)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	ld bc,(PIECE_ROT_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	ld bc,(PIECE_ROT_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	ld bc,(PIECE_ROT_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	jp l8f1a
l8e4b:
	ld hl,(PIECE_CUR_MSK_POS)
	dec hl
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_ROT_O1)
	ld bc,(PIECE_ROT_O1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8e92
	ld bc,(PIECE_ROT_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e92
	ld bc,(PIECE_ROT_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e92
	ld bc,(PIECE_ROT_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e92
	ld hl,(PIECE_CUR_OFF_POS)
	dec hl
	dec hl
	ld (PIECE_CUR_OFF_POS),hl
	ld hl,(PIECE_CUR_SCR_POS)
	dec hl
	dec hl
	ld (PIECE_CUR_SCR_POS),hl
	jp l8f1a
l8e92:
	ld hl,(PIECE_CUR_MSK_POS)
	inc hl
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_ROT_O1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8ed5
	ld bc,(PIECE_ROT_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld bc,(PIECE_ROT_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld bc,(PIECE_ROT_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld hl,(PIECE_CUR_OFF_POS)
	inc hl
	inc hl
	ld (PIECE_CUR_OFF_POS),hl
	ld hl,(PIECE_CUR_SCR_POS)
	inc hl
	inc hl
	ld (PIECE_CUR_SCR_POS),hl
	jp l8f1a
l8ed5:
	ld hl,(PIECE_CUR_MSK_POS)
	dec hl
	dec hl
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_ROT_O1)
	ld bc,(PIECE_ROT_O1)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(PIECE_ROT_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(PIECE_ROT_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(PIECE_ROT_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld hl,(PIECE_CUR_OFF_POS)
	dec hl
	dec hl
	dec hl
	dec hl
	ld (PIECE_CUR_OFF_POS),hl
	ld hl,(PIECE_CUR_SCR_POS)
	dec hl
	dec hl
	dec hl
	dec hl
	ld (PIECE_CUR_SCR_POS),hl
l8f1a:
	ld hl,(PIECE_PRV_MSK_POS)
	ld (PIECE_CUR_MSK_POS),hl
	ld hl,(PIECE_PRV_OFF_POS)
	ld de,(PIECE_PRV_BMP)
	ld bc,(PIECE_PRV_DIM)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_ROT_BMP)
	ld de,PIECE_CUR_BMP
	ld b,#1a
l8f36:
	ld a,(hl)
	inc hl
	ld (de),a
	inc de
	djnz l8f36
	ld de,(PIECE_ROT_OFF_OFST)
	ld hl,(PIECE_CUR_OFF_POS)
	add hl,de
	ld (PIECE_CUR_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_PRV_SCR_POS)
	ld de,(PIECE_PRV_BMP)
	ld bc,(PIECE_PRV_DIM)
	call DRAW_MASK_BMP
	ld hl,(PIECE_CUR_SCR_POS)
	ld de,(PIECE_ROT_SCR_OFST)
	add hl,de
	ld (PIECE_CUR_SCR_POS),hl
	ld de,(PIECE_CUR_OFF_POS)
	ld bc,(PIECE_CUR_DIM)
	jp DRAW_BMP_SYNC

MOVE_LEFT:
	; Check if move is possible
	ld hl,(PIECE_CUR_MSK_POS)
	dec hl				; move 1 cell left
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_MSK_O1)		; Check if the piece block1 
	add hl,bc			; hits something
	ld a,(hl)
	cp #00
	jp nz,l8920			; Move impossible -> abort
	ld bc,(PIECE_MSK_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(PIECE_MSK_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(PIECE_MSK_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld hl,(PIECE_PRV_MSK_POS)
	ld (PIECE_CUR_MSK_POS),hl
	ld hl,(PIECE_CUR_OFF_POS)
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_CUR_OFF_POS)
	dec hl
	dec hl
	ld (PIECE_CUR_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_CUR_SCR_POS)
	dec hl
	dec hl
	ld (PIECE_CUR_SCR_POS),hl
	ld de,(PIECE_CUR_OFF_POS)
	ld bc,(PIECE_CUR_DIM)
	inc c
	inc c
	call DRAW_BMP_SYNC
	jp l8920

MOMVE_RIGHT:
	ld hl,(PIECE_CUR_MSK_POS)
	inc hl
	ld (PIECE_PRV_MSK_POS),hl
	ld bc,(PIECE_MSK_O1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(PIECE_MSK_O2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(PIECE_MSK_O3)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(PIECE_MSK_O4)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld hl,(PIECE_PRV_MSK_POS)
	ld (PIECE_CUR_MSK_POS),hl
	ld hl,(PIECE_CUR_OFF_POS)
	ld (PIECE_PRV_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_PRV_OFF_POS)
	inc hl
	inc hl
	ld (PIECE_CUR_OFF_POS),hl
	ld de,(PIECE_CUR_BMP)
	ld bc,(PIECE_CUR_DIM)
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,(PIECE_CUR_SCR_POS)
	ld (PIECE_PRV_SCR_POS),hl
	inc hl
	inc hl
	ld (PIECE_CUR_SCR_POS),hl
	ld hl,(PIECE_PRV_SCR_POS)
	ld de,(PIECE_PRV_OFF_POS)
	ld bc,(PIECE_CUR_DIM)
	inc c
	inc c
	call DRAW_BMP_SYNC
	jp l8920

;#9063
UPDATE_l8921:
	ld a,(l88f6)
	cp #03
	jr nc,.nxt1
	ld a,#04
	ld (l8921),a
	ret
.nxt1:
	cp #05
	jr nc,.nxt2
	ld a,#08
	ld (l8921),a
	ret
.nxt2:
	cp #07
	jr nc,.nxt3
	ld a,#09
	ld (l8921),a
	ret
.nxt3:
	ld a,#0c
	ld (l8921),a
	ret

HSCORE_INFO:
	DB #00	; Either <score> or <level>
HSCORE_DUR:
	DB #00
FLBK_MENU_ANIM_BLOCK:
	DB #00,#00,#00,#00,#00
	DB #00,#00,#00,#00,#00

FLBK_MENU_ANIM_ISR:
	push af
	push bc
	push de
	push hl
	ld a,(HSCORE_DUR)
	dec a
	jr nz,.hiscore_done
	ld (HSCORE_DUR),a
	ld a,(HSCORE_INFO)
	dec a
	jr nz,.hscore_levels
	; Display "<score 1>"
	ld hl,#c3b3
	ld de,#7213
	ld b,#05
	call DRW_TXT
	; Display "<score 2>"
	ld hl,#c3f3
	ld de,#7220
	ld b,#05
	call DRW_TXT
	; Display "<score 3>"
	ld hl,#c433
	ld de,#722d
	ld b,#05
	call DRW_TXT
	; Display "<score 4>"
	ld hl,#c473
	ld de,#723a
	ld b,#05
	call DRW_TXT
	; Display "<score 5>"
	ld hl,#c4b3
	ld de,#7247
	ld b,#05
	call DRW_TXT
	ld (HSCORE_INFO),a  ; a!=0
	
	; Display "Kazatchok Dancer"
	ld hl,#e4ea
	ld de,#45e0
	call DRAW_ZBMP
	xor a
.hiscore_done:
	ld (HSCORE_DUR),a
	pop hl
	pop de
	pop bc
	pop af
	ret

.hscore_levels:
	ld a,#01
	ld (HSCORE_INFO),a
	; Display "<level 1>"
	ld hl,#c3b3
	ld de,#7218
	ld b,#05
	call DRW_TXT
	; Display "<level 2>"
	ld hl,#c3f3
	ld de,#7225
	ld b,#05
	call DRW_TXT
	; Display "<level 3>"
	ld hl,#c433
	ld de,#7232
	ld b,#05
	call DRW_TXT
	; Display "<level 4>"
	ld hl,#c473
	ld de,#723f
	ld b,#05
	call DRW_TXT
	; Display "<level 5>"
	ld hl,#c4b3
	ld de,#724c
	ld b,#05
	call DRW_TXT
	
	; Display "Alinka's head"
	ld hl,#e4ea
	ld de,#400b
	call DRAW_ZBMP
	xor a
	jr .hiscore_done

; DRAW MESSAGE GAME FINISHED NO HIGH SCORE ???
NEW_AMANT_MISSED:
	call DRAW_POPUP_BOX
	; Draw "SOUPIRANT"
	ld hl,#c3eb
	ld de,P1_NAME
	ld b,#09
	call DRW_TXT

	; Draw "<cur_player>"
	ld hl,#c433
	ld a,(CUR_PLAYER)
	add #30
	call DRW_CHAR

	; Draw "BRAVO"
	ld hl,#c46f
	ld de,#7367
	ld b,#05
	call DRW_TXT

	call DELAY
	call DRAW_POPUP_BOX

	; Draw "MAIS"
	ld hl,#c3f0
	ld de,#738b
	ld b,#04
	call DRW_TXT

	; Draw "TU N'AS"
	ld hl,#c42d
	ld de,#7381
	ld b,#07
	call DRW_TXT

	; Draw "PAS"
	ld hl,#c471
	ld de,#7388
	ld b,#03
	call DRW_TXT

	call DELAY
	call DRAW_POPUP_BOX

	; Draw "LE TITRE"
	ld hl,#c3ec
	ld de,#7377
	ld b,#08
	call DRW_TXT

	; Draw "D'"
	ld hl,#c42d
	ld de,#737f
	ld b,#02
	call DRW_WTXT

	; Draw "AMANT"
	ld de,#71eb
	ld b,#05
	call DRW_WTXT
	call DELAY
	jp CHECK_HIGH_SCORE



GAME_FINISHED:
	ld a,(key_down)
	call GET_KEY_CODE
	ld b,#00
	call #bb39		; Disable CHAR repeat
	
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA
	
	call DANCE_FLR_ANIMATION
	
	call ENBL_MELODY
	
	ld a,(P1_GAME_OVER)
	dec a
	jr z,P2_FINISHED		; P1 is GAME OVER
	
	ld a,(P2_GAME_OVER)
	dec a
	jr z,P1_FINISHED		; P2 is GAME OVER
	
	; -----------------------
	; Compare player's scores
	; -----------------------
	ld hl,P1_SCORE_X10000
	ld de,P2_SCORE_X10000
	ld b,#05
.cmp_next:
	ld c,(hl)
	ld a,(de)
	cp c
	jr nz,.cmp_diff
	dec hl
	dec de
	djnz .cmp_next
	jr P1_WINS
.cmp_diff:
	jr nc,P2_WINS

P1_WINS:
	; Process P2 first
	ld a,#02
	ld (CUR_PLAYER),a
	ld hl,CUR_SCORE_X00001
	ld de,P2_SCORE_X00001
	ld b,#05
.cpy_P2_score:
	ld a,(de)
	ld (hl),a
	inc hl
	inc de
	djnz .cpy_P2_score

	call NEW_AMANT_MISSED		; Game finished but other player wins

P1_FINISHED:
	ld a,#01
	ld (CUR_PLAYER),a
	ld hl,CUR_SCORE_X00001
	ld de,P1_SCORE_X00001
	ld b,#05
.cpy_score:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .cpy_score
	jp CHECK_NEW_AMANT

P2_WINS:
	; Process P1 first.
	ld a,#01
	ld (CUR_PLAYER),a
	ld hl,CUR_SCORE_X00001
	ld de,P1_SCORE_X00001
	ld b,#05
.cpy_score:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .cpy_score
	call NEW_AMANT_MISSED

P2_FINISHED:
	ld a,#02
	ld (CUR_PLAYER),a
	ld hl,CUR_SCORE_X00001
	ld de,P2_SCORE_X00001
	ld b,#05
l923c:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz l923c

CHECK_NEW_AMANT:
	ld hl,CUR_SCORE_X10000
	ld de,AMANT_SCORE 	; #720b  -> best score
	ld b,#05
.cmp_score:
	ld a,(hl)
	add #2f
	ld c,a
	ld a,(de)
	cp c
	jr nz,.cmp_diff
	dec hl
	inc de
	djnz .cmp_score
	jr NEW_AMANT_WIN
.cmp_diff:
	jr c,NEW_AMANT_WIN
	call NEW_AMANT_MISSED
	jp NEW_AMANT_WIN.finished

	
NEW_AMANT_WIN:
	call DRAW_POPUP_BOX
	; Darw "BRAVO"
	ld hl,#c3ef
	ld de,#7367
	ld b,#05
	call DRW_TXT
	; Draw "SOUPIRANT"
	ld de,P1_NAME
	ld hl,#c42b
	ld b,#09
	call DRW_TXT
	; Draw "<current player>"
	ld a,(CUR_PLAYER)
	add #30
	ld hl,#c473
	call DRW_CHAR

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "TU ES"
	ld hl,#c3ef
	ld de,#736c
	ld b,#05
	call DRW_TXT
	; Draw "DEVENU"
	ld hl,#c42e
	ld b,#06
	call DRW_TXT

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "L'AMANT"
	ld hl,#c3ed
	ld de,#71e9
	ld b,#07
	call DRW_WTXT

	; Draw "EN TITRE"
	ld hl,#c46c
	ld de,#738f
	ld b,#08
	call DRW_TXT

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "TES"
	ld hl,#c3f1
	ld de,#7358
	ld b,#03
	; Draw "INITIALES"
	call DRW_TXT
	ld hl,#c42b
	ld b,#09
	call DRW_TXT
	; Draw "..."
	ld hl,#c471
	ld b,#03
	call DRW_TXT

	; Update Amant
	ld de,AMANT
	ld a,(custom_game)
	dec a
	jr z,.use_custom_name
	call #bb18
.letter1:
	dec de
	ld hl,#c471
	call WAIT_KEY
	inc de
	cp #7f		; delete key
	jr z,.letter1
	ld (de),a
	call DRW_CHAR
	inc de
.letter2:
	dec de
	ld hl,#c473
	call WAIT_KEY
	cp #7f		; delete key
	jr z,.letter1
	inc de
	ld (de),a
	call DRW_CHAR
	ld hl,#c475
	call WAIT_KEY
	cp #7f		; delete key
	jr z,.letter2
	inc de
	ld (de),a
	inc de
	call DRW_CHAR

.update_score:
	ld a,#01
	ld (HSCORE_CHANGED),a
	
	; Update Amant
	inc de
	ld hl,CUR_SCORE_X10000
	ld b,#05
.cpy_score:
	ld a,(hl)
	add #2f
	ld (de),a
	inc de
	dec hl
	djnz .cpy_score
	
	ld b,#05
	ld de,SOUPIRANT_1

.check_soupirants:
	push bc
	push de
	inc de
	inc de
	inc de
	ld hl,CUR_SCORE_X10000
	ld b,#05
.check_soupirant:
	ld a,(hl)
	add #2f
	ld c,a
	ld a,(de)
	cp c
	jr nz,.check_score
	inc de
	dec hl
	djnz .check_soupirant
.next_soupirant:
	pop de
	ld hl,#000d
	add hl,de
	ex de,hl
	pop bc
	djnz .check_soupirants
.finished:
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA
	call CLEAR_PLAYGND_OFSCR
	call DANCE_FLR_CURTAIN_UP
	jp MAIN_START

.use_custom_name:
	ld hl,custom_name
	ld b,#03
.custom_next:
	ld a,(hl)
	ld (de),a
	inc de
	inc hl
	djnz .custom_next
	call DRAW_CUSTOM_NAME
	jp .update_score

.check_score:
	jr nc,.next_soupirant	; Score is smaller
	; Score is bigger
	pop de
	pop bc
	push de
	; Insert entry in table
	; Move remaining entries by 1 down.
	ld hl,#7250
	ld de,#7243
.entry_next:
	ld c,#0d
.entry_move:
	ld a,(de)
	ld (hl),a
	dec hl
	dec de
	dec c
	jr nz,.entry_move
	djnz .entry_next

	pop de
	ld hl,AMANT
	ld b,#03
.copy_name:
	ld a,(hl)
	ld (de),a
	inc de
	inc hl
	djnz .copy_name
	inc hl
	ld b,#05
.copy_score:
	ld a,(hl)
	ld (de),a
	inc de
	inc hl
	djnz .copy_score
	ld a,#2e
	ld (de),a
	inc de
	ld (de),a
	inc de
	ld (de),a
	inc de
	ld a,(CUR_LEVEL_X10)
	add #2f
	ld (de),a
	inc de
	ld a,(CUR_LEVEL_X01)
	add #2f
	ld (de),a
	jp .finished

; ---------------------------------------
; Check if current player's score is a high score
; ---------------------------------------
;#
CHECK_HIGH_SCORE:
	ld b,#05		; nb of high score table's entry.
	ld de,SOUPIRANT_1
.check_entry:
	push bc
	push de
	inc de
	inc de
	inc de
	ld hl,CUR_SCORE_X10000
	ld b,#05
.cmp_score:
	ld a,(hl)
	add #2f
	ld c,a
	ld a,(de)
	cp c
	jr nz,.cmp_diff
	inc de
	dec hl
	djnz .cmp_score

.check_next:
	pop de
	ld hl,#000d
	add hl,de
	ex de,hl
	pop bc
	djnz .check_entry
	ret

.cmp_diff:
	jr nc,.check_next
	; New High Score
	; Insert entry 
	pop de
	pop bc  		; b = nb remaining entries
	push de
	ld de,#7250		; Move entries down
	ld hl,#7243		; |
.move_next:			; |
	ld c,#0d		; | Move entry
.move_entry:			; | |
	ld a,(hl)		; | |
	ld (de),a		; | |
	dec de			; | |
	dec hl			; | |
	dec c			; | |
	jr nz,.move_entry	; | -
	djnz .move_next		; -


	call DRAW_POPUP_BOX

	; Draw "TES"
	ld hl,#c3f1
	ld de,#7358
	ld b,#03
	call DRW_TXT
	; Draw "INITIALES"
	ld hl,#c42b
	ld b,#09
	call DRW_TXT
	; Draw "..."
	ld hl,#c471
	ld b,#03
	call DRW_TXT

	ld a,(key_down)
	call GET_KEY_CODE
	ld b,#00	
	call #bb39	; Disable KBD repeat
	
	pop de
	ld a,(custom_game)
	dec a
	jr z,.insert_custom_name

	call #bb18	; Wait KEY
.letter1:
	dec de
	ld hl,#c471
	call WAIT_KEY
	inc de
	cp #7f
	jr z,.letter1
	ld (de),a
	call DRW_CHAR
	inc de
.letter2:
	dec de
	ld hl,#c473
	call WAIT_KEY
	cp #7f
	jr z,.letter1
	inc de
	ld (de),a
	call DRW_CHAR
	ld hl,#c475
	call WAIT_KEY
	cp #7f
	jr z,.letter2
	inc de
	ld (de),a
	inc de
	call DRW_CHAR

.insert_score:
	ld a,#01
	ld (HSCORE_CHANGED),a
	ld hl,CUR_SCORE_X10000
	ld b,#05
.score_loop:
	ld a,(hl)
	add #2f
	ld (de),a
	dec hl
	inc de
	djnz .score_loop

	ld a,#2e
	ld (de),a
	inc de
	ld (de),a
	inc de
	ld (de),a
	inc de
	ld a,(CUR_LEVEL_X10)
	add #2f
	ld (de),a
	inc de
	ld a,(CUR_LEVEL_X01)
	add #2f
	ld (de),a
	ret

.insert_custom_name:
	ld hl,custom_name
	ld b,#03
.name_loop:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .name_loop
	call DRAW_CUSTOM_NAME
	jp .insert_score

DRAW_CUSTOM_NAME:
	push de
	call DELAY
	ld hl,#c471
	ld de,custom_name
	ld b,#03
.loop:
	push bc
	ld a,(de)
	inc de
	call DRW_CHAR

	ld bc,#9c40
.delay:
	dec bc
	ld a,b
	or c
	jr nz,.delay

	pop bc
	djnz .loop
	pop de
	jp DELAY


WAIT_KEY:
	; Display '.'
	ld a,#2e	
	call DRW_CHAR
	dec hl
	dec hl
	jp #bb18	; wait key

KEY
.right:
	DB #01
.left:
	DB #08

SET_DIR_NORMAL:
	ld a,(KEY.right)
	ld (key_right),a
	ld a,(KEY.left)
	ld (key_left),a
	ret

SET_DIR_REVERSED:
	ld a,(KEY.right)
	ld (key_left),a
	ld a,(KEY.left)
	ld (key_right),a
	ret

;l94d3:
is_rot_reversed:
	DB #00

; -------------------
; Set normal piece's rotation
; -------------------
;#94d4
SET_ROT_NORMAL:
	ld a,(is_rot_reversed)
	dec a
	ret nz
	ld a,#00
	jr SWITCH_ROT_DIRECTION

; -------------------
; Set reversed piece's rotation
; -------------------
;#94dd
SET_ROT_REVERSED:
	ld a,(is_rot_reversed)
	dec a
	ret z
	ld a,#01

SWITCH_ROT_DIRECTION:
	ld (is_rot_reversed),a
	ld hl,#7c5b
	ld de,reversed_rot_buffer
	ld b,#03
l94ef:
	push bc
	inc hl
	inc hl
	inc hl
	inc hl
	ld b,#04
l94f6:
	push bc
	ld b,#0c
l94f9:
	inc hl
	djnz l94f9
	ld c,#0e
l94fe:
	ld a,(de)
	ld b,(hl)
	ld (hl),a
	ld a,b
	ld (de),a
	inc hl
	inc de
	dec c
	jr nz,l94fe
	pop bc
	djnz l94f6
	pop bc
	djnz l94ef
	ret
reversed_rot_buffer:
	db #9e,#00,#3e,#00,#ad,#7c,#00,#00
	db #01,#00,#0c,#00,#0c,#00,#02,#00
	db #02,#00,#5f,#7c,#0c,#00,#01,#00
	db #01,#00,#0a,#00,#00,#00,#00,#00
	db #79,#7c,#01,#00,#0c,#00,#0c,#00
	db #01,#00,#60,#ff,#c0,#ff,#93,#7c
	db #02,#00,#0a,#00,#01,#00,#01,#00
	db #9e,#00,#3e,#00,#19,#7d,#01,#00
	db #0c,#00,#0b,#00,#01,#00,#02,#00
	db #02,#00,#cb,#7c,#0c,#00,#01,#00
	db #01,#00,#0c,#00,#00,#00,#00,#00
	db #e5,#7c,#01,#00,#01,#00,#0b,#00
	db #0c,#00,#60,#ff,#c0,#ff,#ff,#7c
	db #00,#00,#0c,#00,#01,#00,#01,#00
	db #9e,#00,#3e,#00,#85,#7d,#01,#00
	db #0b,#00,#01,#00,#0c,#00,#02,#00
	db #02,#00,#37,#7d,#0c,#00,#01,#00
	db #01,#00,#0b,#00,#00,#00,#00,#00
	db #51,#7d,#01,#00,#0c,#00,#01,#00
	db #0b,#00,#60,#ff,#c0,#ff,#6b,#7d
	db #01,#00,#0b,#00,#01,#00,#01,#00


; -------------------------------------------------------
; Delay loop (2 or 3 seconds... TBD)
; -------------------------------------------------------
;l95b7:
DELAY:
	ld bc,#00c8
.delay1:
	push bc
.delay2:
	push af
	ld a,(ix+#00)
	ld (ix+#00),a
	ld a,(ix+#00)
	ld (ix+#00),a
	pop af
	dec c
	jr nz,.delay2
	pop bc
	djnz .delay1
	ret

; -----------------------------------------------------
; Draw text popup in playing area
; -----------------------------------------------------
DRAW_POPUP_BOX:
	ld hl,#c3aa
	ld b,#14
.top:
	ld (hl),#3f
	inc hl
	djnz .top
	ld hl,#cbaa
	ld b,#26
.middle:
	ld (hl),#2a	; left
	inc hl
	ld c,#12
.bkgd:
	ld (hl),#00	; bkg
	inc hl
	dec c
	jr nz,.bkgd
	ld (hl),#15	; right
	inc hl
	; next line
	ld de,#07ec
	add hl,de
	jr nc,.next
	ld de,#c040
	add hl,de
.next:
	djnz .middle
	ld b,#14
.bottom:
	ld (hl),#3f
	inc hl
	djnz .bottom
	ret

; ----------------------
; Get key code for char
; input:
; A: char
; output:
; A: key code
; ----------------------
GET_KEY_CODE:
	push bc
	push hl
	ld c,a

	; Check without modifier
	ld b,#4e
.loop_nomod:	
	ld a,b
	dec a
	call #bb2a
	cp c
	jr z,.key_found
	djnz .loop_nomod
	
	;Check with shift modifier
	ld b,#4e
.loop_shift:	
	ld a,b
	dec a
	call #bb30
	cp c
	jr z,.key_found
	djnz .loop_shift
	
	; Found
.key_found:
	ld a,b
	dec a
	pop hl
	pop bc
	ret



DRAW_BMP_SYNC:
	push bc
	; Wait flyback signal
	; by reading μPD8255 port B
	ld b,#f5
.wait:
	in a,(c)
	rra
	jr nc,.wait
	; Got flyback signal...
	; Draw bitmap.
	pop bc
.height:
	push bc
	push hl
	push de
.width:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,.width
	pop de
	ld hl,#0014	; <- bmp width seems to be #14 bytes larges
	add hl,de
	ex de,hl	; de = de + #14
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz .height
	ret

; ----------------------------------
; Draw bitmap on screen
; DE: src address
; HL: dst address
; B : height
; C : width
; ----------------------------------
;#9642
DRAW_BMP:
	push bc
	push hl
.width:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,.width
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz DRAW_BMP
	ret

; ----------------------------------
; Draw bitmap to a 20 (#14) bytes wide offscreen buffer 
; Only draw non null bytes.
; HL: dst address
; DE: src address
; B : height
; C : width
; ----------------------------------
;#9653
DRAW_MASK_BMP_OFFSCREEN1:
	push bc
	push hl
.width:
	ld a,(de)
	inc de
	cp #00
	jr z,.skip
	ld (hl),a
.skip:
	inc hl
	dec c
	jr nz,.width
	pop hl
	ld bc,#0014
	add hl,bc
	pop bc
	djnz DRAW_MASK_BMP_OFFSCREEN1
	ret

; ----------------------------------
; Draw bitmap to a 34 (#22) bytes wide offscreen buffer 
; HL: dst address
; DE: src address
; B : height
; C : width
; ----------------------------------
DRAW_BMP_OFSCR_W22:
	push bc
	push hl
.width:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,.width
	pop hl
	ld bc,#0022
	add hl,bc
	pop bc
	djnz DRAW_BMP_OFSCR_W22
	ret

; ----------------------------------
; Draw masked bitmap on screen (only non null bytes)
; DE: src address
; HL: dst address
; B : height
; C : width
; ----------------------------------
DRAW_MASK_BMP:
	push bc
	push hl
.width:
	ld a,(de)
	inc de
	cp #00
	jr z,.skip
	ld (hl),#00
.skip:
	inc hl
	dec c
	jr nz,.width
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz DRAW_MASK_BMP
	ret

; ----------------------------------
; Clear bitmap from a 20 (#14) bytes wide offscreen buffer 
; Only clear non null bytes.
; HL: dst address
; DE: src address
; B : height
; C : width
; ----------------------------------
CLEAR_MASK_BMP_OFFSCREEN1:
	push bc
	push hl
.width:
	ld a,(de)
	inc de
	cp #00
	jr z,.skip
	ld (hl),#00
.skip:
	inc hl
	dec c
	jr nz,.width
	pop hl
	ld bc,#0014
	add hl,bc
	pop bc
	djnz CLEAR_MASK_BMP_OFFSCREEN1
	ret


; ----------------------------
; Clear AREA
; HL: Screen address
; B : height
; C : width
; ----------------------------
CLEAR_SCREEN_AREA:
	push bc
	push hl
.loop_width:
	ld (hl),#00
	inc hl
	dec c
	jr nz,.loop_width
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz CLEAR_SCREEN_AREA
	ret


;l96b8:
SCORE_ADD_HDRDS:
	ld a,(CUR_SCORE_X00100)
	add b
	jp HDRDS
;#96bf:
SCORE_ADD_TENS:
	ld a,(CUR_SCORE_X00010)
	add b
	jp TENS


; #96c6:
SCORE_ADD_UNITS:
	ld a,(CUR_SCORE_X00001)
	add b
	ld (CUR_SCORE_X00001),a
	cp #0b
	jr c,SCORE_DISPLAY
	or a
	sbc #0a
	ld (CUR_SCORE_X00001),a
	ld a,(CUR_SCORE_X00010)
	inc a
TENS:
	ld (CUR_SCORE_X00010),a
	sbc #0b
	jr c,SCORE_DISPLAY
	inc a
	ld (CUR_SCORE_X00010),a
	or a
	sbc #0b
	jr c,.cont
	inc a
	ld (CUR_SCORE_X00010),a
.cont:
	ld a,(CUR_SCORE_X00100)
	inc a
HDRDS:
	ld (CUR_SCORE_X00100),a
	or a
	sbc #0b
	jr c,SCORE_DISPLAY
	inc a
	ld (CUR_SCORE_X00100),a
	ld a,(CUR_SCORE_X01000)
	inc a
	ld (CUR_SCORE_X01000),a
	cp #0b
	jr c,SCORE_DISPLAY
	ld a,#01
	ld (CUR_SCORE_X01000),a
	ld a,(CUR_SCORE_X10000)
	inc a
	ld (CUR_SCORE_X10000),a
	cp #0b
	jr c,SCORE_DISPLAY
	ld a,#01
	ld (CUR_SCORE_X10000),a

;#971f:
SCORE_DISPLAY:
	ld hl,(CUR_SCORE_SCR)
	ld a,(CUR_SCORE_X10000)
	add #2f
	call DRW_CHAR
	ld a,(CUR_SCORE_X01000)
	add #2f
	call DRW_CHAR
	ld a,(CUR_SCORE_X00100)
	add #2f
	call DRW_CHAR
	ld a,(CUR_SCORE_X00010)
	add #2f
	call DRW_CHAR
	ld a,(CUR_SCORE_X00001)
	add #2f
	jp DRW_CHAR

; -------------------------
; Draw text
; HL: screen location
; DE: text address
; B : text len
; -------------------------
DRW_TXT:
	ld a,(de)
	inc de
	call DRW_CHAR
	djnz DRW_TXT
	ret

; -------------------------
; Draw wide text
; HL: screen location
; DE: text address
; B : text len
; -------------------------
DRW_WTXT:
	ld a,(de)
	inc de
	call DRW_WCHAR
	djnz DRW_WTXT
	ret

; -------------------------
; Draw character
; HL: screen address
; A : character
; -------------------------
DRW_CHAR:
	push bc
	push de
	push hl
	ld b,#20
	or a
	sbc b
	ld l,a
	ld h,#00
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	ld e,a
	ld d,#00
	sbc hl,de
	sla l
	rl h
	ld de,#5823
	add hl,de
	ex de,hl
	pop hl
	push hl
	ld b,#07
.loop:
	push bc
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	dec hl
	ld bc,#0800
	add hl,bc
	pop bc
	djnz .loop
	ld (hl),#00
	inc hl
	ld (hl),#00
	pop hl
	inc hl
	inc hl
	pop de
	pop bc
	ret

; --------------------------
; Draw wide character
; HL: screen address
; A : character
; --------------------------
DRW_WCHAR:
	push bc
	push de
	push hl
	ld b,#20
	or a
	sbc b
	ld l,a
	ld h,#00
	sla l
	rl h
	sla l
	rl h
	sla l
	rl h
	ld e,a
	ld d,#00
	sbc hl,de
	sla l
	rl h
	ld de,#5823
	add hl,de
	ex de,hl
	pop hl
	push hl
	ld b,#07
.loop:
	push bc
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	dec de
	ld (hl),a
	dec hl
	ld bc,#0800
	add hl,bc
	jr nc,.cont1
	ld bc,#c040
	add hl,bc
.cont1:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	dec hl
	ld bc,#0800
	add hl,bc
	jr nc,.cont2
	ld bc,#c040
	add hl,bc
.cont2:
	pop bc
	djnz .loop
	pop hl
	inc hl
	inc hl
	pop de
	pop bc
	ret

; ------------------------
; Get Random piece and clear 'next piece' area
; ------------------------
;#97f3:
GET_RNDM_PIECE:
	ld a,r
	ld c,a
	ld a,(random)
	add c
	sla a
	sla a
	add c
	inc a
	ld (random),a
	and #07			; mod 7
	cp #07		
	jp nc,GET_RNDM_PIECE	; if random >= 7 then retry
	sla a			; x2
	ld c,a
	ld b,#00
	ld hl,piece_table
	add hl,bc		; HL = &piece_table[random]
	ld e,(hl)		; 
	inc hl			;
	ld d,(hl)		; DE = piece_table[random]


	ld hl,NXT_PIECE_AREA_POS; Copy piece data into current piece buffer
	ld b,#1e		; piece data is #1E long
.copy:			
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz .copy

	ld hl,#e15a
	ld b,#20
.clear1:
	push bc
	push hl
	ld c,#0a
.clear2:
	ld (hl),#00
	inc hl
	dec c
	jr nz,.clear2
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz .clear1
	ret
;l9838:
random:
	DB #00
piece_table:
	DW #7dd7
	DW #7d33
	DW #7cc7
	DW #7d9f
	DW #7e0f
	DW #7e47
	DW #7c5b

ANIMATION_END:
	; Draw empty dance floor
	ld hl,#fc82
	ld de,DANCE_FLR_OFSCR
	ld bc,#6522
	call DRAW_BMP

	; Draw Kozak going out
	ld hl,#ee45
	ld de,KOZAK_OUT_BMP
	ld bc,#1604		; looking carefully, this should probably be #1704
	call DRAW_BMP

	; Delay
	ld bc,#0000
.delay:
	dec bc
	ld a,b
	or c
	jr nz,.delay

	; Draw empty dance floor
	ld hl,#fc82
	ld de,DANCE_FLR_OFSCR
	ld bc,#6522
	call DRAW_BMP
	; proceed to curtain moving down.

; ------------------------------------------------
; Animate the curtain moving down on the dance floor
; ------------------------------------------------
DANCE_FLR_CURTAIN_DOWN:
	ld hl,#fc42		; upper curtain screen origin
	ld de,DANCE_FLR_OFSCR
	ld b,#65

.loop:
	push bc
	push hl
	push de
	push hl
	; Prepare offscreen bitmap by copying curtain bitmap
	call PREPARE_OFSCR_BMP
	; Add dance floor background behind the curtain
	; Only fill 'empty/black' pixels
	call ADD_DANCEFLOOR_BKG

	; Sync - Wait flyback 
	ld b,#f5
.sync:
	in a,(c)
	rra
	jr nc,.sync

	; Draw offscreen bitmap on screen
	ld bc,#0822
	pop hl
	ld de,CURTAIN_OFSCR
	call DRAW_BMP

	; Move curtain one line down
	pop de
	ld hl,#0022
	add hl,de
	ex de,hl
	pop hl
	call NXT_SCR_LINE

	ld b,#64
.delay1:
	ld c,#0a
.delay2:
	dec c
	jr nz,.delay2
	djnz .delay1
	pop bc
	djnz .loop

	; Draw curtain one more time without back ground
	; We're all the way down.
	ld de,CURTAIN_BMP
	ld bc,#0822
	jp DRAW_BMP

; ------------------------------------------------
; Animate the curtain moving up on the dance floor
; ------------------------------------------------
DANCE_FLR_CURTAIN_UP:
	ld hl,#e782	; lower curtain screen address.
	ld de,#3d33	; revealed background line address while curtain is moving up
	
	ld b,#66
.loop:
	push bc
	push hl
	push de
	call PREPARE_OFSCR_BMP
	call ADD_DANCEFLOOR_BKG

	; Sync - wait flyback
	ld b,#f5
.sync:
	in a,(c)
	rra
	jr nc,.sync

	ld bc,#0822
	ld de,CURTAIN_OFSCR
	call DRAW_BMP

	; Draw revealed background line
	pop de
	ld bc,#0122
	call DRAW_BMP

	; Move curtain one line up
	ld hl,#ffbc
	add hl,de
	ex de,hl
	pop hl
	or a
	call PRV_SCR_LINE
	
	; Delay
	ld b,#64
.delay1:
	ld c,#0a
.delay2:
	dec c
	jr nz,.delay2
	djnz .delay1

	pop bc
	djnz .loop
	ret

; ----------------------------
; Prepare dancefloor offscreen bitmap
; ----------------------------
; #98f4
PREPARE_OFSCR_BMP:
	push hl
	push de
	push bc
	push af
	ld hl,CURTAIN_BMP
	ld de,CURTAIN_OFSCR
	ld b,#08
.height:
	ld c,#22
.width:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	dec c
	jr nz,.width
	djnz .height

	pop af
	pop bc
	pop de
	pop hl
	ret
;
;
; #9910
ADD_DANCEFLOOR_BKG:
	push hl
	push de
	push bc
	push af
	ld hl,#fef0
	add hl,de
	ld de,CURTAIN_OFSCR
	
	ld b,#08
.height:
	ld c,#22
.width:
	push bc
	; Process current bitmap byte
	; One byte is 2 pixels
	; pixel 1: 10101010 -> #aa
	; pixel 2: 01010101 -> #55
	ld a,(de)
	ld b,a
	and #aa		; check if foreground pixel 1 if empty
	jr nz,.skip1	; non empty -> skip
	ld a,(hl)	; copy background pixel 1
	and #aa		;  |
	or b		;  |
	ld (de),a	;  ---
.skip1:
	ld a,(de)	
	ld b,a		
	and #55		; check if foreground pixel 2 if empty
	jr nz,.skip2	; non empty -> skip
	ld a,(hl)	; copy background pixel 2
	and #55		;  |
	or b		;  |
	ld (de),a	;  ---
.skip2:
	inc hl
	inc de
	pop bc
	dec c
	jr nz,.width
	djnz .height
	pop af
	pop bc
	pop de
	pop hl
	ret

; --------------------------------------------
; 
; --------------------------------------------
;#9943
DANCE_FLR_ANIMATION:
	; Prepare dance floor offscreen bitmap.
	; - clear background
	; - paint background collors
	; - add left column
	; - Add right column with Alinka
	
	call CLEAR_PLAYGND_OFSCR
	
	ld hl,PLAYGND_OFSCR
	
	ld a,#3f
	ld b,#0c
.white_h:
	ld c,#22
.white_w:
	ld (hl),a
	inc hl
	dec c
	jr nz,.white_w
	djnz .white_h


	ld a,#30
	ld b,#22
.lblue1:
	ld (hl),a
	inc hl
	djnz .lblue1
	
	ld a,#0c
	ld b,#3f
.dblue_h:
	ld c,#22
.dblue_w:
	ld (hl),a
	inc hl
	dec c
	jr nz,.dblue_w
	djnz .dblue_h
	
	ld a,#30
	ld b,#22
.lblue2:
	ld (hl),a
	inc hl
	djnz .lblue2

	ld hl,DANCE_FLR_OFSCR	
	ld de,LFT_COLUMN_BMP
	ld bc,#6405		; 5x100
	call DRAW_BMP_OFSCR_W22
	ld hl,#2fe1
	ld de,RGT_COLUMN_BMP
	ld bc,#640a		; 10x100
	call DRAW_BMP_OFSCR_W22

	call DANCE_FLR_CURTAIN_UP

	ld hl,#d605
	ld de,KOZAK_IN_BMP
	ld bc,#1904
	call DRAW_BMP

	ld a,#28		; tempo
	ld (dance_tempo),a
	ld hl,#7431		; <- dance animation data
	ld (dance_ptr),hl
	ld hl,FLBK_DANCE_BLOCK	
	call #bcda		; Enable dance flyback

	; First FLYBACK tempo is longer than the following delay
	; delay
	ld bc,#0000
.delay:
	dec bc
	ld a,b
	or c
	jr nz,.delay

	; Enable melody
	call ENBL_MELODY

	; Draw empty dance floor
	ld hl,#fc82
	ld de,DANCE_FLR_OFSCR
	ld bc,#6522
	call DRAW_BMP

	; Add Kozak ready to dance
	ld hl,#ee0e
	ld de,KOZAK7_BMP
	ld bc,#200a
	call DRAW_BMP

.wait:
	ld a,(dance_tempo)
	cp #00
	jr z,.done	; Animation terminated.
	jr .wait

.done:
	call ANIMATION_END
	jp DSBL_MELODY

;
; Flyback block
; Which one ???
; #99dd
FLBK_DANCE_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00,#00  
dance_tempo:
	DB #00
dance_ptr:
	DB #00,#00

; #99ef
FLBK_DANCE_ISR:
	push af
	ld a,(dance_tempo)
	dec a
	ld (dance_tempo),a
	jr nz,.skip
	di
	push hl
	push de
	push bc
	ld a,#0a
	ld (dance_tempo),a
	ld hl,(dance_ptr)
	ld a,(hl)
	cp #ff
	jr nz,.anim
	ld a,#00		; <- indicate animation's done
	ld (dance_tempo),a
	ld hl,FLBK_DANCE_BLOCK
	call #bcdd
	jp .done
.anim:
	ld e,a
	inc hl
	ld a,(hl)
	inc hl
	ld (dance_ptr),hl
	ld d,a
	ld hl,#ee0e		; screen address
	ld bc,#200a		; dimensions 10x32
	call DRAW_BMP
.done:
	pop bc
	pop de
	pop hl
.skip:
	pop af
	ei
	ret

; ---------------------------
; Enable sound melody
; ---------------------------
ENBL_MELODY:
	ld hl,#6fe3
	ld (NOTE_PTR),hl
	ld a,#01
	ld (NOTE_DUR),a
	
	ld a,#04
	ld c,#00
	call CFG_AY_SND

	ld a,#05
	ld c,#00
	call CFG_AY_SND

	ld hl,FLBK_MELODY_BLOCK
	call #bcda	; add/enable flyback block

	ld a,#07
	ld c,#30
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	jp CFG_AY_SND

; ---------------------------
; Disable sound melody
; ---------------------------
DSBL_MELODY:
	ld a,#04
	ld c,#00
	call CFG_AY_SND
	ld a,#05
	ld c,#00
	call CFG_AY_SND
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	ld hl,FLBK_MELODY_BLOCK
	jp #bcdd	; disable/remove SND_FLBK block


NOTE_PTR:		; Address  HL=#6fe3  <- beginning of melody notes
	DB #00,#00	; Current note address

NOTE_DUR:		; Compteur ?? A=1
	DB #00		; Music note duration

FLBK_MELODY_BLOCK:		; Music flyback block
	DB #00,#00	; Chain
	DB #00		; Count
	DB #00		; Class
	DB #00,#00	; Routine address
	DB #00		; ROM select byte
	DB #00,#00,#00	; User field

; ---------------------
; Sound Flyback routine
; ---------------------
;#9a84:		
FLBK_MELODY_ISR:
	di
	push af
	push bc
	push hl
	ld a,(NOTE_DUR)
	dec a
	ld (NOTE_DUR),a
	jr nz,.cont	; if duration!=0 then keep playing same note
	; else program next note	
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	ld hl,(NOTE_PTR)
.next:
	ld a,(hl)	; new note duration
	inc a		 
	jr nz,.play	; if duration != #FF then play note
	; else start over again
	ld hl,#6fe3	
	ld (NOTE_PTR),hl
	jr .next
.play:
	dec a
	ld (NOTE_DUR),a
	inc hl
	ld c,(hl)
	inc hl
	ld a,#05
	call CFG_AY_SND
	ld c,(hl)
	inc hl
	ld a,#04
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	call CFG_AY_SND
	ld (NOTE_PTR),hl
.cont:
	pop hl
	pop bc
	pop af
	ei
	ret



; ---------------------------
; Random block flyback's block
; ---------------------------
;#9ac9
FLBK_RNDM_BLCK_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00
;#9ad3
FLBK_RNDM_BLCK_CNT:
	DB #00


;
; ---------------------------
; Random block flyback ISR
; ---------------------------
;#9ad4
FLBK_RNDM_BLCK_ISR:
	push af
	; Decrease 'counter'
	ld a,(FLBK_RNDM_BLCK_CNT)
	dec a
	jr nz,.cont
	; Disable flyback
	ld hl,FLBK_RNDM_BLCK_BLOCK
	call #bcdd
	ld a,#01
.cont:
	ld (FLBK_RNDM_BLCK_CNT),a
	pop af
	ret

; ---------------------------
; Enable random block flyback
; ---------------------------
;#9ae8
FLBK_RNDM_BLCK_ENABLE:
	xor a
	ld (FLBK_RNDM_BLCK_CNT),a
	ld hl,FLBK_RNDM_BLCK_BLOCK
	jp #bcda

; ---------------------------
; Disable random block flyback
; ---------------------------
;#9af2
FLBK_RNDM_BLCK_DISABLE:
	ld a,#ff
	ld (FLBK_RNDM_BLCK_CNT),a
	ld hl,FLBK_RNDM_BLCK_BLOCK
	jp #bcdd


; ---------------------------
; Insert a random block into playground area
; ---------------------------
;#9afd
INSERT_RNDM_BLCK:
	ld a,(random)
	and #03
	inc a
	ld (l9b2f),a
	ld ix,#3ff1
	ld hl,#3e05
	ld b,#0f
l9b0f:
	ld c,#0a
	ld d,#00
l9b13:
	ld a,(ix+#00)
	or a
	jr z,l9b2c
l9b19:
	dec ix
	dec hl
	dec hl
	dec c
	jr nz,l9b13
	dec ix
	dec ix
	or a
	ld de,#ff74
	add hl,de
	djnz l9b0f
	ret
l9b2c:
	ld a,d
	inc d
l9b2f equ $ + 1
	cp #03
	jr nz,l9b19
	ld a,(ix+#0c)
	dec a
	jr nz,l9b19
	ld a,(ix-#0c)
	dec a
	jr z,l9b19
	ld a,(ix-#18)
	dec a
	jr z,l9b19
	ld (ix+#00),#01
	ld de,BLINK_BLOCK_BMP
	ld bc,#0802
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP

	ld a,#c8
	ld (FLBK_RNDM_BLCK_CNT),a
	ld hl,FLBK_RNDM_BLCK_BLOCK
	jp #bcda		; Enable Flyback block

; ---------------------------
; Playground move up Flyback's block
; ---------------------------
;#9b68
FLBK_MOVE_UP_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00
;#9b72
FLBK_MOVE_UP_CNT:
	DB #00
;#9b73
l9b73:
	DB #00

; ---------------------------
; Playground move up Flyback's ISR
; ---------------------------
;#9b74
FLBK_MOVE_UP_ISR:
	push af
	ld a,(FLBK_MOVE_UP_CNT)
	dec a
	jr nz,.cont
	; Disable flyback block
	ld hl,FLBK_MOVE_UP_BLOCK
	call #bcdd
	ld a,#01
.cont:
	ld (FLBK_MOVE_UP_CNT),a
	pop af
	ret

; ---------------------------
; Playground move up Flyback enable
; ---------------------------
;#9b88
FLBK_MOVE_UP_ENABLE:
	xor a
	ld (FLBK_MOVE_UP_CNT),a		; reset variable. Usage TBD
	ld hl,FLBK_MOVE_UP_BLOCK
	jp #bcda

; ---------------------------
; Playground move up Flyback disable
; ---------------------------
;#9b92
FLBK_MOVE_UP_DISABLE:
	ld a,#ff
	ld (FLBK_MOVE_UP_CNT),a
	ld hl,FLBK_MOVE_UP_BLOCK
	jp #bcdd

; ---------------------------------
; Move playground one line up !!!
; ---------------------------------
PLAYGROUND_MOVE_UP:
	ld a,(#7582)
	cp #0f
	ret nc
	inc a
	ld (#7582),a
	ld hl,PLAYGND_MSK_BUF
	ld de,PLAYGND_MSK_BUF+#C
	ld b,#19
.buf_h:
	ld c,#0c
.buf_w:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,.buf_w
	djnz .buf_h

	ld hl,PLAYGND_OFSCR
	ld de,PLAYGND_OFSCR+#A0
	ld b,#c8
.bmp_h:
	ld c,#14
.bmp_w:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,.bmp_w
	djnz .bmp_h

	ld ix,#3fe8

	; Randomly choose empty block position on the new line.
	ld a,r
	ld c,a
	ld a,(random)
	add c
	sla a
	sla a
	add c
	inc a
	ld (random),a
	and #1f
	add #07
	sra a
	sra a
	ld (l9b73),a	; <- store position

	ld b,#09
l9bee:
	push bc
	ld a,(l9b73)
	dec a
	jr z,l9c25
l9bf5:
	ld (l9b73),a
	push hl
	ld de,ORANGE_BLOCK_BMP
	ld bc,#0802
	call DRAW_MASK_BMP_OFFSCREEN1
	pop hl
	inc hl
	inc hl
	ld (ix+#00),#01
	inc ix
	pop bc
	djnz l9bee
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP
	ld a,#fa
	ld (FLBK_MOVE_UP_CNT),a
	ld hl,FLBK_MOVE_UP_BLOCK
	jp #bcda
l9c25:
	push hl
	ld de,EMPTY_BLOCK_BMP
	ld b,#08
l9c2b:
	push bc
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	ld bc,#0013
	add hl,bc
	pop bc
	djnz l9c2b
	inc hl
	pop hl
	inc hl
	inc hl
l9c40 equ $ + 2
	ld (ix+#00),#00
	inc ix
	ld a,#00
	jr l9bf5

;
; Set up playing area mask (either 0 or 1) 
; 28 lines of 12 blocks
;
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
;	100000000001
; DE -> ????????????	
;	????????????
;	????????????
;	????????????
;	????????????
;	????????????
;	222222222222
;       222222222222
;#9c48
SETUP_PLAYGROUND_MASK:
	ld b,#14		
	ld hl,PLAYGND_MSK_BUF		; <- probably playing area mask array address
.fill1:
	ld (hl),#01		; left border
	inc hl
	ld c,#0a		; 10 zeros
.fill2:
	ld (hl),#00
	inc hl
	dec c
	jr nz,.fill2
	ld (hl),#01		; right border
	inc hl
	djnz .fill1

	ld b,#48
.pattern:
	ld a,(de)
	inc de
	cp #00
	jr z,.copy	; empty
	ld a,#01	; occupied
.copy:
	ld (hl),a
	inc hl
	djnz .pattern
	ld b,#18
.bottom:
	ld (hl),#02
	inc hl
	djnz .bottom
	ret

; ----------------------------------
; Clear play ground bitmap
; ----------------------------------
;#9c73
CLEAR_PLAYGND_OFSCR:

	ld hl,PLAYGND_OFSCR
	ld b,#d2
.loop_y:
	ld c,#14
.loop_x:
	ld (hl),#00
	inc hl
	dec c
	jr nz,.loop_x
	djnz .loop_y
	ret

;
; Setup playing area bitmap
;
;#9c83
SETUP_PLAYGND_OFSCR:
	ld hl,PLAYGND_OFSCR	; <- playing area bitmap buffer
	; Clear 20 first lines of 10 blocks
	ld b,#a0
.clear1:
	ld c,#14
.clear2:
	ld (hl),#00
	inc hl
	dec c
	jr nz,.clear2
	djnz .clear1
	
	; Setup last 6 line with level's initial pattern
	ld b,#06
.next_line:
	; skip level pattern's left border
	inc de		
	; setup line (10 blocks)
	ld c,#0a
.next_block:
	push bc
	push de
	push hl
	ld b,#08
	ld a,(de)
	cp #00
	jr z,.empty
	cp #01
	jr z,.block1
	cp #02
	jr z,.block2
	cp #03
	jr z,.block3
	cp #04
	jr z,.block4
	cp #05
	jr z,.block5
	cp #06
	jr z,.block6
	cp #07
	jr z,.block7
	ld de,BLINK_BLOCK_BMP	; <- single block 8
	jr .copy_block
.empty:
	ld de,EMPTY_BLOCK_BMP	; empty block
	jr .copy_block
.block1:
	ld de,PURPLE_BLOCK_BMP	; single block color 1
	jr .copy_block
.block2:
	ld de,RED_BLOCK_BMP	; single block color 2
	jr .copy_block
.block3:
	ld de,ORANGE_BLOCK_BMP	; single block color 3
	jr .copy_block
.block4:
	ld de,YELLOW_BLOCK_BMP	; single block color 4
	jr .copy_block
.block5:
	ld de,GREEN_BLOCK_BMP	; single block color 5
	jr .copy_block
.block6:
	ld de,BLUE_BLOCK_BMP	; single block color 6
	jr .copy_block
.block7:
	ld de,LBLUE_BLOCK_BMP	; single block color 7
.copy_block:
	push bc
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	ld bc,#0013
	add hl,bc
	pop bc
	djnz .copy_block

	pop hl
	inc hl
	inc hl
	pop de
	inc de
	pop bc
	dec c
	jr nz,.next_block
	; skip level pattern's right border
	inc de
	push bc
	ld bc,#008c
	add hl,bc
	pop bc
	djnz .next_line
	ret

; -----------------------------------
; NEXT SCR LINE (with new screen dimensions)
; -----------------------------------
NXT_SCR_LINE:
	ld bc,#0800
	add hl,bc
	ret nc
	ld bc,#c040
	add hl,bc
	ret

; -----------------------------------
; PREV SCR LINE (with screen dimensions)
; -----------------------------------
PRV_SCR_LINE:
	ld bc,#f800
	add hl,bc
	ld a,h
	sub #c0
	ret nc
	ld bc,#3fc0
	add hl,bc
	ret

; -----------------------------------
; Configure AY-3-8912 Sound generator  
; -----------------------------------
CFG_AY_SND:
	di
	push bc
	push af
	ld b,#f4
	out (c),a
	ld b,#f6
	in a,(c)
	or #c0
	out (c),a
	and #3f
	out (c),a
	ld b,#f4
	out (c),c
	ld b,#f6
	ld c,a
	or #80
	out (c),a
	out (c),c
	pop af
	pop bc
	ei
	ret


; *****************************
; * Draw 'compressed' bitmap 
; *****************************
; DE: compressed bitmap's address
; HL: destination address
;
; bitmap format:
; bmp[0] = number of line
; bmp[n] = block len
;      	len   == #FF -> end of line
;      	len.7 == 0 -> copy block
;		scr[...] = bmp[n+1 .. n+1+len]
;       len.7 == 1 -> fill block
;		scr[...] = bmp[n+1] * (len&7F)
;               
;
; #9d45
DRAW_ZBMP:
	ld a,(de)
	inc de
	ld b,a
.line_loop:			
	push bc
	push hl
.block_loop:			
	ld a,(de)
	inc de
	cp #ff
	jp z,.nxt_line
	bit 7,a
	jr z,.copy
	res 7,a
.fill:
	ld b,a
	ld a,(de)
	inc de
.fill_loop:
	ld (hl),a
	inc hl
	djnz .fill_loop
	jr .block_loop

.copy:
	ld b,a
.copy_loop:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz .copy_loop

.nxt_line:
	pop hl
.nxt_fct equ $ + 1
	call NXT_SCR_LINE
	pop bc
	djnz .line_loop
	
	ret

; ------------------------------
; DRAW Box Top border 
; HL = scr address
; C  = box inner width 
; ------------------------------
;
;#9d6f:
BOX_TOP:
	ld de,box_top_pattern
	ld b,#04
.line:
	push bc
	push hl
	; left pattern
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	; middle pattern
	ld a,(de)
	inc de
.middle:
	ld (hl),a
	inc hl
	dec c
	jr nz,.middle
	; right pattern
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz .line
	ret
; Box Top border pattern
box_top_pattern:	
	DB	#C0,#0C,#0C,#0C,#C0
	DB	#84,#CC,#CC,#CC,#48
	DB	#4C,#98,#30,#64,#8c
	DB	#4C,#30,#3C,#30,#8C

; ------------------------------
; DRAW Box bottom border 
; HL = screen address
; C  = box inner width
; ------------------------------
; l9da8:
BOX_BOTTOM:
	ld de,box_bottom_pattern
	ld b,#04
.line:
	push bc
	push hl
	; left pattern
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	; middle pattern
	ld a,(de)
	inc de
.middle:
	ld (hl),a
	inc hl
	dec c
	jr nz,.middle
	; right pattern
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz .line
	ret
; Botton Horizontal  border pattern
box_bottom_pattern:	
	DB	#4C,#30,#3C,#30,#8C
	DB	#4C,#98,#30,#64,#8c
	DB	#84,#CC,#CC,#CC,#48
	DB	#C0,#0C,#0C,#0C,#C0


; ------------------------------
; DAW Box side (Vertical) borders
; HL: screen address
; C : inner width 
; B : height
; ------------------------------
;
; pattern #4C,#34, #00... , #38,#8C
; l9de1:
BOX_SIDES:
	push bc
	push hl
	; left side
	ld a,#4c
	ld (hl),a
	inc hl
	ld a,#34
	ld (hl),a
	inc hl
	; middle
	xor a
.side:
	ld (hl),a
	inc hl
	dec c
	jr nz,.side
	; right side
	ld a,#38
	ld (hl),a
	inc hl
	ld a,#8c
	ld (hl),a
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz BOX_SIDES
	ret
