


FILE_BUF 	 equ #1388
DATA_LEN 	 equ #3b83
DATA_PTR 	 equ #4268


GAME_TITLE_SCR	 equ #c000

L_AMANT_SCR1	 equ #c1ac
L_AMANT_SCR2	 equ #c3ed

KOZAK_DANCER_SCR equ #e4ea
ALINKA_HEAD_SCR	 equ #e4ea

HSCORE1_SCR	 equ #c3ab	; Screen address to display the name of soupirant 1
HSCORE2_SCR	 equ #c3eb	; Screen address to display the name of soupirant 2
HSCORE3_SCR	 equ #c42b	; Screen address to display the name of soupirant 3
HSCORE4_SCR	 equ #c46b	; Screen address to display the name of soupirant 4
HSCORE5_SCR	 equ #c4ab	; Screen address to display the name of soupirant 5

DEFI_CHOICE_SCR	 equ #c645	;

INVALID_SCR	 equ #c68b
OK_SCR		 equ #c691

INFO_DEFI_SCR	 equ #c183
INFO_LINES_SCR	 equ #c1c3
INFO_BONUS_SCR	 equ #c202
SOUPIRANT_1_SCR	 equ #c2c4
SCORE1_SCR	 equ #c30a
SCORE2_SCR	 equ #c392
SOUPIRANT_2_SCR	 equ #c3cc
ALINKA_SCR	 equ #c509

MENU1_SCR	 equ #c583	; Screen address to display menu 1
MENU2_SCR	 equ #c5c3	; Screen address to display menu 2
MENU3_SCR	 equ #c643	; Screen address to display menu 3
MENU4_SCR1	 equ #c683	; Screen address to display menu 4
MENU4_SCR2 	 equ #c6cc	; Screen address to display menu 5

COPYRIGHT1_SCR	 equ #c746
COPYRIGHT2_SCR	 equ #c786

DROITE_SCR	 equ #c58a
GAUCHE_SCR	 equ #c5ca
ACCELERE_SCR	 equ #c608
ROTATION_SCR	 equ #c648

SOUPIRANT_SCR 	 equ #c3eb
SOUPIRANT_LEN	 equ 9
SOUPIRANT_NUM_SCR equ #c433
SOUPIRANT_NUM_LEN equ 1

PRET_SCR 	 equ #c470
DOMMAGE_SCR	 equ #c46d
TU_AS_SCR	 equ #c3ef
ECHOUE_SCR	 equ #c42e
DAMNED_SCR	 equ #c3eb
DEFI_SCR 	 equ #c430
REMPORTE_SCR	 equ #c46c
TES_SCR		 equ #c5c6
INITIALES_SCR	 equ #c5ce
DOTS_SCR	 equ #c610
BRAVO_SCR	 equ #c46f
TU_ES_SCR	 equ #c3ef
DEVENU_SCR	 equ #c42e
LE_TITRE_SCR	 equ #c3ec
D_SCR 		 equ #c42d
TU_N_AS_SCR 	 equ #c42d
PAS_SCR 	 equ #c471
MAIS_SCR 	 equ #c3f0
EN_TITRE_SCR 	 equ #c46c
MAESTRIA_SCR 	 equ #c42c
COMBO_SCR	 equ #c349
COMBO_DIM	 equ #0814
DEFI2_SCR	 equ #e36d
LIGNES_SCR 	 equ #e3eb
A_SCR		 equ #e473
COMPLETER_SCR	 equ #e4eb

PLAYGND_SCR	 equ #e16a	  ; playground screen address
PLAYGND_BOTTOM_LINE_SCR equ #e7aa ; playground bottom line screen address
PLAYGND_LINE_DIM equ #0814
PLAYGND_DIM	 equ #d014	  ; playground dimensions		20x208
PLAYGND_OFSCR	 equ #2e53	  ; playground offscreen bitmap

; Dance floor and curtain offscreen buffers 
; are overlapping with playground offscreen buffer.
; They are not used simultaneously.
DANCEFLR_OFSCR	 equ #2fc9	; Dance floor with columns and Alinka 34x100
CURTAIN_OFSCR 	 equ #3d55	; Curtain 34x8  


PLAYGND_MSK_BUF equ #3ebb	; Playground mask buffer
				; 22 lignes of 12 cells.
				; cell: 0 is empty, otherwise occupied
		
	include 'data.asm'
		

	org #7E65
;#7e65
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
;#7e86
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
;#7e95
	ld hl,#bc26
	ld (DRAW_ZBMP.nxt_fct),hl
	
	; 'Decompress' data to #C000
	ld hl,#c000
	ld de,#4268
	call DRAW_ZBMP

	; --------------------
	; move decompressed data to DATA_START
	; --------------------
	ld hl,#c000		
	ld de,DATA_START
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
;#7ec4
	ld hl,FILE_TBL
	ld de,FILE_BUF
	ld b,#0a
	call #bc77		; open file for input
	ld hl,AMANT		; destination address
	call #bc83		; read file
	call #bc7a		; close file

;#7ed8:
LAYOUT_SCREEN:
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


;#7f1f
	; --------------------
	; Draw game title
	; --------------------
	ld hl,GAME_TITLE_SCR	;#c000
	ld de,GAME_TITLE_ZBMP	
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
	jp SETUP
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

SETUP:
	; ----------------------------------------
	; Configure flyback callbacks
	; ----------------------------------------
	ld hl,FLBK_GAME_MELODY_BLOCK	; frame flyback block - Manage game melody and speed
	ld de,FLBK_GAME_MELODY_ISR	; event routine address
	ld bc,#8100			; B: evt class | C: ROM select address of the routine
	call #bcd7			; init block
	ld hl,FLBK_GAME_MELODY_BLOCK
	call #bcdd			; remove/disable block;

	ld hl,FLBK_CLEAR_COMBO_BLOCK	; frame flyback block - Clear combo text on screen
	ld de,FLBK_CLEAR_COMBO_ISR	; event routine address
	ld bc,#8100			; B: evt class | C: ROM select address of the routine
	call #bcd7			; init block
	ld hl,FLBK_CLEAR_COMBO_BLOCK
	call #bcdd			; remove/disable block

	ld hl,FLBK_DANCE_BLOCK		; frame flyback block - Kozak Dance
	ld de,FLBK_DANCE_ISR		; event routine address
	ld bc,#8100			; B: evt class | C: ROM select address of the routine
	call #bcd7			; init block
	ld hl,FLBK_DANCE_BLOCK
	call #bcdd			; remove/disable block

	ld hl,FLBK_RNDM_BLCK_BLOCK	; frame flyback block - Random blocks 
	ld de,FLBK_RNDM_BLCK_ISR	; event routine address
	ld bc,#8100			; B: evt class | C: ROM select address of the routine
	call #bcd7			; init block 
	ld hl,FLBK_RNDM_BLCK_BLOCK
	call #bcdd			; remove/disable block

	ld hl,FLBK_MOVE_UP_BLOCK	; frame flyback block - Move playground UP
	ld de,FLBK_MOVE_UP_ISR		; event routine address
	ld bc,#8100			; B: evt class | C: ROM
	call #bcd7			; init block 
	ld hl,FLBK_MOVE_UP_BLOCK
	call #bcdd			; remove/disable block

	ld hl,FLBK_KAZATCHOK_BLOCK	; frame flyback block - Kazatchok Melody
	ld de,FLBK_KAZATCHOK_ISR	; event routine address
	ld bc,#8100			; B: evt class | C: ROM
	call #bcd7			; init block 
	ld hl,FLBK_KAZATCHOK_BLOCK
	call #bcdd			; remove/disable block

	ld hl,FLBK_MENU_ANIM_BLOCK 	; frame flyback block - Main menu animation
	ld de,FLBK_MENU_ANIM_ISR  	; event routine address
	ld bc,#8100			; B: evt class | C: ROM
	call #bcd7			; init block 
	ld hl,FLBK_MENU_ANIM_BLOCK
	call #bcdd			; remove/disable block

	; ----------------------------------------
	; Default rotation direction
	; ----------------------------------------
	xor a
	ld (rot_reversed),a

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
	ld hl,KBD_MAP	;#73e3
	ld a,KBD_MAP_LEN 	;#4e
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
	ld de,P1_HEAD_BMP
	ld bc,#1405
	call DRAW_BMP

	; ----------------------------------------
	; Draw Player 2's head
	; ----------------------------------------
	ld hl,#c31e
	ld de,P2_HEAD_BMP
	ld bc,#1405
	call DRAW_BMP
;#80de
START:
	ld a,(hscore_changed)
	dec a
	jr nz,MAIN_SCREEN
	ld (hscore_changed),a

	; ----------------------------------------
	; Save High Score file	
	; ----------------------------------------
	ld b,#0a
	ld hl,FILE_TBL
	ld de,#1388
	call #bc8c
	ld hl,HSCORE_TABLE
	ld de,#004a
	ld bc,HSCORE_TABLE
	ld a,#05
	call #bc98
	call #bc8f
	jr MAIN_SCREEN
;#8105:
FILE_TBL:
	DB "ALINKA.TBL"

;#810f
MAIN_SCREEN:
	call START_KAZATCHOK

	; Display "DEFI  01"
	ld de,INFO_DEFI_STR	;#7269
	ld hl,INFO_DEFI_SCR	;#c183
	ld b,INFO_DEFI_LEN 	;#08
	call DRW_TXT

	; Display "LIGNE 00"
	ld hl,INFO_LINES_SCR;	#c1c3
	ld b,INFO_LINES_LEN;	#08
	call DRW_TXT

	; Display "BONUS 000"
	ld hl,INFO_BONUS_SCR	;#c202
	ld b,INFO_BONUS_LEN 	;#09
	call DRW_TXT

	; Display "SOUPIRANT 1"
	ld hl,SOUPIRANT_1_SCR	;#c2c4
	ld b,SOUPIRANT1_LEN	;#0b
	call DRW_TXT

	; Display "00000"
	ld hl,SCORE1_SCR	;#c30a
	ld b,SCORE1_LEN	;#05
	call DRW_TXT

	; Display "00000"
	ld hl,SCORE2_SCR	;#c392
	ld b,SCORE2_LEN	;#05
	call DRW_TXT

	; Display "SOUPIRANT 2"
	ld hl,SOUPIRANT_2_SCR	;#c3cc
	ld b,SOUPIRANT2_LEN	;#0b
	call DRW_TXT

	; Display "< ALINKA >"
	ld hl,ALINKA_SCR	;#c509
	ld b,ALINKA_LEN		;#0a
	call DRW_TXT

	; Display "L'AMANT:"
	ld hl,L_AMANT_SCR1
	ld de,L_AMANT_STR
	ld b,L_AMANT_LEN
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
	ld hl,HSCORE1_SCR	;#c3ab
	ld de,HSCORE1	;#7210
	ld b,#03
	call DRW_TXT

	; Display "<initiales 2>" 
	ld hl,HSCORE2_SCR	;#c3eb
	ld de,HSCORE2
	ld b,#03
	call DRW_TXT

	; Display "<initiales 3>" 
	ld hl,HSCORE3_SCR	;#c42b
	ld de,HSCORE3
	ld b,#03
	call DRW_TXT

	; Display "<initiales 4>" 
	ld hl,HSCORE4_SCR	;#c46b
	ld de,HSCORE4
	ld b,#03
	call DRW_TXT

	; Display "<initiales 5>" 
	ld hl,HSCORE5_SCR	;#c4ab
	ld de,HSCORE5
	ld b,#03
	call DRW_TXT

	; Enable high scores animation
	ld a,#03
	ld (menu_dur),a
	ld hl,FLBK_MENU_ANIM_BLOCK
	call #bcda

; Display main menu
MENU:	
	; Display "1-  1 SOUPIRANT"
	ld de,MENU1_STR	;#72ac
	ld hl,MENU1_SCR	;#c583
	ld b, MENU1_LEN	;#10
	call DRW_TXT
	; Display "2- 2 SOUPIRANTS"
	ld hl,MENU2_SCR	;#c5c3
	ld b, MENU2_LEN	;#10
	call DRW_TXT
	; Display "3- CHOIX DU DEFI"
	ld hl,MENU3_SCR	;#c643
	ld b, MENU3_LEN	;#10
	call DRW_TXT
	; Display "4- REDEFINIR LES"
	ld hl,MENU4_SCR1	;#c683
	ld b, MENU4_LEN1	;#10
	call DRW_TXT
	; Display "TOUCHES"
	ld hl,MENU4_SCR2 	;#c6cc
	ld b, MENU4_LEN2	;#07
	call DRW_TXT
	; Display "PROGRAMME  DE"
	ld hl,COPYRIGHT1_SCR	;#c746
	ld b,COPYRIGHT1_LEN	;#0d
	call DRW_TXT
	; Display "ERIC BOUCHER"
	ld hl,COPYRIGHT2_SCR	;#c786
	ld b,COPYRIGHT2_LEN 	;#0d
	call DRW_TXT

MENU_LOOP:	
	; Read keyboard
	call #bb09
	jr nc,MENU_LOOP
	cp #31
	jp z,MENU_1
	cp #32
	jp z,MENU_2
	cp #33
	jr z,MENU_3
	cp #34
	jp z,MENU_4
	jr MENU_LOOP

; -------------------
; Menu 3 - Choix du defi
; -------------------
MENU_3:
	ld hl,#c582
	ld bc,#3822
	call CLEAR_SCREEN_AREA
	; Display "TES"
	ld hl,TES_SCR	;#c5c6
	ld de,TES_STR	;#7358
	ld b,TES_LEN	;#03
	call DRW_TXT
	; Display "INITIALES"
	inc hl
	inc hl
	ld b,INITIALES_LEN	;#09
	call DRW_TXT
	; Display "..."
	ld hl,DOTS_SCR		;#c610
	ld b,DOTS_LEN		;#03
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
	ld hl,DEFI_CHOICE_SCR	;#c645
	ld de,DEFI_CHOICE_STR	;#7251
	ld b,DEFI_CHOICE_LEN	;#0e
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
	ld hl,HSCORE1
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
	ld hl,OK_SCR	;#c691
	ld de,OK_STR	;#725f
	ld b,OK_LEN	;#02
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
	jp MENU

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
	jp MENU

.invalid:
	pop hl
	ld de,#000d
	add hl,de
	pop bc
	dec b
	jp nz,.check_custom_name
	ld hl,INVALID_SCR	;#c68b
	ld de,INVALID_STR	;#7261
	ld b,INVALID_LEN	;#08
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
	ld hl,DROITE_SCR	;#c58a
	ld de,DROITE_STR	;#730d
	ld b,DROITE_LEN		;#07
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
	ld hl,GAUCHE_SCR	;#c5ca
	ld b,GAUCHE_LEN		;#07
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
	ld hl,ACCELERE_SCR	;#c608
	ld b,ACCELERE_LEN	;#09
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Insert CHAR into routine ??
	ld (key_down),a
	; Draw CHAR
	call DRW_CHAR

	; Display "ROTATION:"
	ld hl,ROTATION_SCR	;#c648
	ld b,ROTATION_LEN	;#09
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
	jp MENU

MENU_1:
	xor a
	ld (p1_game_over),a
	inc a
	ld (p2_game_over),a
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
	ld (p1_game_over),a
	ld (p2_game_over),a

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

	call DANCEFLR_CURTAIN_DOWN

	; Disable sound
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	call STOP_KAZATCHOK
	
	; Setup level
	ld a,(start_levelX10)
	add #2f
	ld (#726f),a
	ld a,(start_levelX01)
	add #2f
	ld (#7270),a
	ld a,#01
	ld (p1_score_X00001),a
	ld (p2_score_X00001),a
	ld (p1_score_X00010),a
	ld (p2_score_X00010),a
	ld (p1_score_X00100),a
	ld (p2_score_X00100),a
	ld (p1_score_X01000),a
	ld (p2_score_X01000),a
	ld (p1_score_X10000),a
	ld (p2_score_X10000),a
start_level_ptr equ $ + 1
	ld hl,LEVEL_TABLE
	ld (p1_level_ptr),hl
	ld (p2_level_ptr),hl
start_levelX10 equ $ + 1
	ld a,#01
	ld (cur_level_X10),a
start_levelX01 equ $ + 1
	ld a,#02
	ld (cur_level_X01),a
	jr START_LEVEL

NEXT_LEVEL:
	ld a,(cur_level_X01)
	inc a
	ld (cur_level_X01),a
	cp #0b
	jr nz,START_LEVEL
	ld a,#01
	ld (cur_level_X01),a
	ld a,(cur_level_X10)
	inc a
	ld (cur_level_X10),a

START_LEVEL:
	ld a,(cur_level_X10)
	cp #04
	jr nz,.player1
	ld a,(cur_level_X01)
	cp #03
	; Last level ?? 31
	jp z,GAME_FINISHED

.player1:
	ld a,(p1_game_over)
	dec a
	jr z,.player2
	jp PLAYER1
.player2:
	ld a,(p2_game_over)
	dec a
	jr z,NEXT_LEVEL
	jp PLAYER2

PLAYER1:
	ld a,#01
	ld (cur_player),a
	ld hl,#c30a
	ld (cur_score_scr),hl
	ld hl,p1_score_X00001
	ld de,cur_score_X00001
	ld b,#05
.init_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .init_score

	ld hl,(p1_level_ptr)
	ld (cur_level_ptr),hl
	ld de,SOUPIRANT1_STR
	
	call PLAY
	
	ld hl,(cur_level_ptr)
	ld a,(hl)
	inc hl
	ld (p1_level_ptr),hl
	dec a

	call z,DANCE_ANIMATION

	ld de,p1_score_X00001
	ld hl,cur_score_X00001
	ld b,#05
.store_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .store_score

	call DISABLE_RNDM_BLCK
	call FLBK_MOVE_UP_DISABLE
	call SET_ROT_NORMAL
	call SET_DIR_NORMAL
	jp START_LEVEL.player2

PLAYER2:
	ld a,#02
	ld (cur_player),a
	ld hl,#c392
	ld (cur_score_scr),hl
	ld hl,cur_score_X00001
	ld de,p2_score_X00001
	ld b,#05
.init_score:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .init_score

	ld hl,(p2_level_ptr)
	ld (cur_level_ptr),hl

	ld de,SOUPIRANT2_STR
	call PLAY

	ld hl,(cur_level_ptr)
	ld a,(hl)
	inc hl
	ld (p2_level_ptr),hl
	dec a
	call z,DANCE_ANIMATION

	ld de,p2_score_X00001
	ld hl,cur_score_X00001
	ld b,#05
.store_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .store_score

	call DISABLE_RNDM_BLCK
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
	ld hl,SOUPIRANT_SCR	;#c3eb
	ld b,SOUPIRANT_LEN	;#09
	call DRW_TXT
	; Skip space
	inc de
	; Draw "1/2" depending on value of reg DE
	ld hl,SOUPIRANT_NUM_SCR	;#c433
	ld b,SOUPIRANT_NUM_LEN  ;#01
	call DRW_TXT
	; Draw "PRET"
	ld hl,PRET_SCR 		;#c470
	ld de,PRET_STR		;#732d
	ld b,PRET_LEN		;#04
	call DRW_TXT

	call DELAY
	
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA

	ld hl,(cur_level_ptr)		; ptr = &level[0]
	ld de,cur_lignes_X10
	ld b,#02
.copy_lignes:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .copy_lignes

	ld (cur_level_ptr),hl		; store ptr = &level[2]
	; Draw "DEFI"
	ld de,DEFI2_STR		;#73cf
	ld hl,DEFI2_SCR		;#e36d
	ld b,DEFI2_LEN		;#04
	call DRW_WTXT

	; Draw Current LEVEL
	inc hl
	inc hl
	ld a,(cur_level_X10)
	add #2f
	call DRW_WCHAR
	ld a,(cur_level_X01)
	add #2f
	call DRW_WCHAR

	; Draw NB LIGNES
	ld hl,LIGNES_SCR 	;#e3eb
	ld a,(cur_lignes_X10)
	add #2f
	call DRW_WCHAR
	ld a,(cur_lignes_X01)
	add #2f
	call DRW_WCHAR

	; Draw "LIGNES"
	inc hl
	inc hl
	ld b,LIGNES_LEN		;#06
	call DRW_WTXT

	; Draw "A"
	ld hl,A_SCR		;#e473
	ld b,A_LEN 		;#01
	call DRW_WTXT

	; Draw "COMPLETER"
	ld hl,COMPLETER_SCR	;#e4eb
	ld b,COMPLETER_LEN	;#09
	call DRW_WTXT

	; Display level info
	ld hl,#c18f
	ld a,(cur_level_X10)
	add #2f
	call DRW_CHAR
	ld a,(cur_level_X01)
	add #2f
	call DRW_CHAR

	ld hl,#c1cf
	ld a,(cur_lignes_X10)
	add #2f
	call DRW_CHAR
	ld a,(cur_lignes_X01)
	add #2f
	call DRW_CHAR

	call DELAY

	ld hl,(cur_level_ptr)	; load ptr = &level[2] = speed ?
	ld a,(hl)
	ld (down_delay),a	; set variable (accualy poke the value into instruction)

	; Down delay : delay before automatic down move
	; Move delay : laterral move repeat delay

	; Update move delay based on down delay
	call ADAPT_MOVE_DELAY

	inc hl			; ptr = &level[3]
	ld a,(hl)		; 
	inc hl			; ptr = &level[4]
	ld (cur_level_ptr),hl	; <- store ptr = &level[4]

	push af
	bit 7,a			; a.7 -> Random blocks
	call nz,ENABLE_RNDM_BLCK
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

	ld hl,(cur_level_ptr)	; ptr = &level[4]
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
	ld (cur_level_ptr),hl 	; store current ptr = &level[6]
	call SETUP_PLAYGND_OFSCR

	; Draw playground
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP

	; Get first piece
	call GET_RNDM_PIECE
	
	; Draw it
	ld hl,(nxt_piece_prz_pos)
	ld de,(nxt_piece_cur_bmp)
	ld bc,(nxt_piece_cur_dim)
	call DRAW_BMP
	
	call DELAY

	call PLAY_LEVEL

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
	ld hl,DAMNED_SCR	;#c3eb
	ld de,DAMNED_STR	;#7343
	ld b,DAMNED_LEN		;#09
	call DRW_TXT
	; Draw "DEFI"
	ld hl,DEFI_SCR 		;#c430
	ld b,DEFI_LEN		;#04
	call DRW_TXT
	; Draw "REMPORTE"
	ld hl,REMPORTE_SCR	;#c46c
	ld b,REMPORTE_LEN	;#08
	call DRW_TXT

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "BONUS"
	ld hl,#c3ef
	ld de,#7279
	ld b,#05
	call DRW_TXT
	; Draw "MAESTRIA"
	ld hl,MAESTRIA_SCR 	;#c42c
	ld de,MAESTRIA_STR	;#7397
	ld b,MAESTRIA_LEN 	;#08
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
	ld (cur_bonus_X100),a
	ld a,#01
	ld (cur_bonus_X010),a
	ld (cur_bonus_X001),a
	ld hl,#c1aa
	ld bc,#1014
	call CLEAR_SCREEN_AREA
	jp .not_empty

.next:
	; Display current bonus value
	ld hl,#c20e
	ld a,(cur_bonus_X100)
	add #2f
	call DRW_CHAR
	ld a,(cur_bonus_X010)
	add #2f
	call DRW_CHAR
	ld a,(cur_bonus_X001)
	add #2f
	call DRW_CHAR
	
	; Check last line of mask playground 
	; to determine if it's empty
	ld hl,#3ddf
	ld b,#0a
.check1:
	ld a,(hl)
	inc hl
	inc hl
	cp #00
	jp nz,.not_empty
	djnz .check1

	; Line is empty
	; Bonus computation is finished.
	; Draw flame ???
	ld de,FLAME3_BMP
	ld bc,PLAYGND_LINE_DIM
	ld hl,PLAYGND_BOTTOM_LINE_SCR
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
	ld hl,PLAYGND_BOTTOM_LINE_SCR
	ld bc,PLAYGND_LINE_DIM
	call CLEAR_SCREEN_AREA

	call DELAY

.decrease:
	ld a,(cur_bonus_X001)
	dec a
	ld (cur_bonus_X001),a

	jr nz,.display
	ld a,#0a
	ld (cur_bonus_X001),a
	ld a,(cur_bonus_X010)
	dec a
	ld (cur_bonus_X010),a
	jr nz,.display
	ld a,#0a
	ld (cur_bonus_X010),a
	ld a,(cur_bonus_X100)
	dec a
	ld (cur_bonus_X100),a
	jr nz,.display
	
	ld a,#01
	ld (cur_bonus_X100),a
	ld (cur_bonus_X010),a
	ld (cur_bonus_X001),a
.display:

	push af
	ld hl,#c20e
	ld a,(cur_bonus_X100)
	add #2f
	call DRW_CHAR
	ld a,(cur_bonus_X010)
	add #2f
	call DRW_CHAR
	ld a,(cur_bonus_X001)
	add #2f
	call DRW_CHAR
	
	ld b,#01
	call SCORE_ADD_UNITS
	
	pop af
	jr nz,.decrease
	ret

.not_empty:
	ld hl,PLAYGND_BOTTOM_LINE_SCR
	ld de,FLAME1_BMP
	ld bc,PLAYGND_LINE_DIM
	call DRAW_BMP

	ld b,#64
.delay21:
	ld c,#96
.delay22:
	dec c
	jr nz,.delay22
	djnz .delay21

	; Move offscreen playground 1 line down
	;ld hl,#3e93	; probably a bug - should be #3e92
	;ld de,#3df3	; probably a bug - should be #3df2
	ld hl,PLAYGND_OFSCR+(26*8*20)	; should substract 1 to be at the end of line
	ld de,PLAYGND_OFSCR+(25*8*20)	; should substract 1 to be at the end of line

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


	; Draw playground (starting 2 lines below the top and ending 1 line before the bottom)
	ld hl,PLAYGND_SCR+(2*64)	;#e1ea	top minus 2 'char' screen lines 
	ld de,PLAYGND_OFSCR+(2*8*20) 	;#2f93	top minus 2*8 bitmap lines 
	ld bc,PLAYGND_DIM-(#1800)  	;#b814  height minus 3*8 lines 
	call DRAW_BMP

	; Draw burning line 
	ld hl,PLAYGND_BOTTOM_LINE_SCR; #e7aa
	ld de,FLAME2_BMP	
	ld bc,PLAYGND_LINE_DIM
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
	ld a,(cur_bonus_X010)
	sbc #02
	ld (cur_bonus_X010),a
	jr nc,.cont
	add #0a
	ld (cur_bonus_X010),a
	ld a,(cur_bonus_X100)
	dec a
	ld (cur_bonus_X100),a
	jr nz,.cont
	ld a,#01
	ld (cur_bonus_X100),a
	ld (cur_bonus_X010),a
.cont:
	jp .next


PLAY_LEVEL:
	ld a,(key_down)		;
	call GET_KEY_CODE	;
	ld b,#ff		;
	call #bb39		; Set down key repeat allowed

	ld hl,GAME_MELODY
	ld (melody_ptr),hl
	ld a,#01
	ld (melody_dur),a
	ld hl,FLBK_GAME_MELODY_BLOCK
	call #bcda

	ld a,#07
	ld c,#30
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	call CFG_AY_SND
	
	; highest_line_idx = 0
	xor a			
	ld (playgnd_top_idx),a		

NEXT_PIECE:

	; Move next piece info to current piece info
	ld hl,piece_src_pos
	ld de,nxt_piece_scr_pos
	ld b,#1c
.copy:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz .copy

	; Get the next piece
	call GET_RNDM_PIECE

	; TODO Clarify
	ld hl,#2ef9			; reset offscreen1 start address ??
	ld (piece_cur_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call DRAW_MASK_BMP_OFFSCREEN1

	ld hl,(piece_src_pos)
	ld de,(piece_cur_bmp_pos)
	ld bc,(piece_dim)
	call DRAW_BMP_SYNC

	ld hl,(nxt_piece_prz_pos)
	ld de,(nxt_piece_cur_bmp)
	ld bc,(nxt_piece_cur_dim)
	call DRAW_BMP
	
	; Add 3 points
	ld b,#03
	call SCORE_ADD_UNITS

	ld bc,#61a8	; delay loop
.delay:			; |
	dec bc		; |
	ld a,b		; |
	or c		; |
	jr nz,.delay	; -

	ld hl,#3ebf
	ld (piece_cur_msk_pos),hl
	
	ld a,#01
	ld (move_cnt),a
	
	ld a,#1a			; 26
	ld (piece_top_idx),a		; line idx of the bottom of the piece

	ld hl,PIECE_MASK_BOTTOM_START  	; mask playground bottom of piece line address
	ld (piece_msk_bottom),hl	; increased by 12 (#0c) every move down

	ld hl,PIECE_SCR_BOTTOM_START	; scr playground bottom of piece line address
	ld (piece_scr_bottom),hl	; increased by 64 (#40) every move down

	ld hl,PIECE_BMP_BOTTOM_START	; bmp playground bottom of piece line address
	ld (piece_bmp_bottom),hl	; increased by 160 (#a0) move down

	ld a,NB_BMP_LINES_START		; initial number of lines from the bitmap playgraound's top
	ld (nb_bmp_lines),a		; increased by 8 every move down

	ld a,NB_MSK_LINES_START		; initial number of lines from the mask playgraound's top
	ld (nb_msk_lines),a		; increased by on every move down


KEY_LOOP:
	ld a,(move_cnt)
	dec a
	jr z,.allow_move

	ld hl,CHECK_LOOP
	jr .cont
.allow_move:
	ld hl,CHECK_MOVE
.cont:
	ld (check1),hl

	ld hl,CHECK_LOOP
	ld (check2),hl

down_delay equ $ + 1
	ld a,#32
	ld (down_cnt),a

CHECK_LOOP:
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
check1 equ $ + 1
	jp CHECK_MOVE

; Check lateral moves
CHECK_MOVE:	
key_left equ $ + 1
	ld a,#08
	call #bb1e
	jp nz,MOVE_LEFT

key_right equ $ + 1
	ld a,#01		
	call #bb1e		
	jp nz,MOVE_RIGHT

check2 equ $ + 1
	jp CHECK_LOOP		


KEY_CONT:
move_delay equ $ + 1
	ld a,#0c
	ld (move_cnt),a
	ld hl,CHECK_LOOP
	ld (check1),hl
	jp CHECK_LOOP

MOVE_DOWN:
	; Increase score on explicit user's down move
	ld b,#01
	call SCORE_ADD_UNITS
FALL:
	ld hl,(piece_cur_msk_pos)
	ld bc,#000c
	add hl,bc
	ld (piece_prv_msk_pos),hl
	ld bc,(miece_msk_B1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,LAND
	ld bc,(piece_msk_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,LAND
	ld bc,(piece_msk_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,LAND
	ld bc,(piece_msk_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,LAND
	ld hl,(piece_prv_msk_pos)
	ld (piece_cur_msk_pos),hl
	
	ld hl,(piece_src_pos)
	ld (piece_prv_scr_pos),hl
	ld bc,#0040
	add hl,bc
	ld (piece_src_pos),hl

	ld hl,(piece_cur_bmp_pos)
	ld (piece_prv_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(piece_cur_bmp_pos)
	ld bc,#00a0
	add hl,bc
	ld (piece_cur_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call DRAW_MASK_BMP_OFFSCREEN1
	
	; draw offscreen playground
	; from previous pos to an extended height (one more line)
	; This will clear the piece from it previous position 
	; and display it at its new position.
	ld hl,(piece_prv_scr_pos)
	ld de,(piece_prv_bmp_pos)
	ld bc,(piece_dim)
	ld a,#08
	add b
	ld b,a
	call DRAW_BMP_SYNC
	
	; (piece_top_idx) = (piece_top_idx)-1
	ld a,(piece_top_idx)
	dec a
	ld (piece_top_idx),a
	
	; (piece_scr_bottom) = (piece_scr_bottom)+#40
	ld hl,(piece_scr_bottom)
	ld bc,#0040
	add hl,bc
	ld (piece_scr_bottom),hl

	; (piece_msk_bottom) = (piece_msk_bottom) + #0c
	ld hl,(piece_msk_bottom)
	ld bc,#000c
	add hl,bc
	ld (piece_msk_bottom),hl

	; (piece_bmp_bottom) = (piece_bmp_bottom) + #a0
	ld hl,(piece_bmp_bottom)
	ld bc,#00a0
	add hl,bc
	ld (piece_bmp_bottom),hl

	; (nb_msk_lines) = (nb_msk_lines) + 1
	ld a,(nb_msk_lines)
	inc a
	ld (nb_msk_lines),a

	; (nb_bmp_lines) = (nb_bmp_lines) + #08
	ld a,(nb_bmp_lines)
	ld b,#08
	add b
	ld (nb_bmp_lines),a

	jp KEY_LOOP

;#89ec
LAND:

	ld d,LANDUP_SOUND_LEN
	ld hl,landup_sound
.sound:
	ld c,(hl)
	inc hl
	ld a,(hl)
	inc hl
	call CFG_AY_SND
	dec d
	jr nz,.sound
	
	; Delay
	ld b,#00
.delay1:
	ld c,#28
.delay2:
	dec c
	jr nz,.delay2
	djnz .delay1

	; -----------------------------
	; Piece landed
	; Insert piece's blocks into playground mask 
;#8a04
	ld hl,(piece_cur_msk_pos)
	ld bc,(miece_msk_B1)
	add hl,bc
	ld (hl),#01		; set playground mask value to for piece's block1
	ld bc,(piece_msk_B2)
	add hl,bc
	ld (hl),#01		; set playground mask value to for piece's block2
	ld bc,(piece_msk_B3)
	add hl,bc
	ld (hl),#01		; set playground mask value to for piece's block3
	ld bc,(piece_msk_B4)
	add hl,bc
	ld (hl),#01		; set playground mask value to for piece's block4
	ld hl,COMBO_STR_TBL		
	ld (combo_str),hl	; init combo string pointer to "------  50"
	
	ld a,#00
	ld (combo_lines),a

	ld a,#d2		; Initial bliblibliiip pitch
	ld (blibliblip_pitch),a

	; -----------------------------
	; Stop land up Sound
;#8a33
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

	; -----------------------------
	; Check for completed lines
;#8a4f
	ld b,#04	; <- max number of possible completed lines
check_next_cpltd_line:
	push bc

	ld hl,(piece_msk_bottom) ; <- current piece bottom playground mask's line 
	ld c,#0c	 	 ; line width (1+10+1)
.nxt_blk:
	ld a,(hl)
	cp #01
	jp nz,uncomplete_line
	dec hl
	dec c
	jr nz,.nxt_blk

	; -----------------------------
	; Draw burning flame 1
;#8a61
	ld de,FLAME1_BMP	; <- flame1 bitmap 20x8 
	ld hl,(piece_scr_bottom)	; <- must be screen playground line's start address
	ld bc,PLAYGND_LINE_DIM
	call DRAW_BMP	

	; -----------------------------
	; Delay
	ld b,#64
.delay11:
	ld c,#64
.delay12:
	dec c
	jr nz,.delay12
	djnz .delay11

	; -----------------------------
	; Move playground's bitmap one line down, 
	; starting at the removed bitmap line address
;8a76
	or a
	ld hl,(piece_bmp_bottom)
	ld de,(piece_bmp_bottom)	; Current line bitmap playground start address
	ld bc,#ff60	; -160
	add hl,bc
	ld a,(nb_bmp_lines)	; <- number of pixel lines to top of playground's bitmap 
	ld b,a
.move1_h:
	ld c,#14
.move1_w:
	ld a,(hl)
	dec hl
	ld (de),a
	dec de
	dec c
	jr nz,.move1_w
	djnz .move1_h

	; -----------------------------
	; Move playground's mask one line down, 
	; starting at the removed mask line address
;#8a91
	ld hl,(piece_msk_bottom)
	ld de,(piece_msk_bottom)
	ld bc,#fff4	; -12
	add hl,bc
	ld a,(nb_msk_lines)	; <- number of lines to top of playground's mask 
	ld b,a
.move2_h:
	ld c,#0c
.move2_w:
	ld a,(hl)
	dec hl
	ld (de),a
	dec de
	dec c
	jr nz,.move2_w
	djnz .move2_h


	; -----------------------------
	; Draw burning flame 2
;#8aab
	ld de,FLAME2_BMP	; flame2 bitmap 20x8
	ld hl,(piece_scr_bottom)	; <- must be screen playground line's start address
	ld bc,PLAYGND_LINE_DIM
	call DRAW_BMP

	; -----------------------------
	; Delay
	ld b,#64
.delay21:
	ld c,#64
.delay22:
	dec c
	jr nz,.delay22
	djnz .delay21

	; -----------------------------------
	; Rebuild the top and bottom shadow/lighting of the cutted pieces
	; -----------------------------------
	; Top inner lighting of the lower pieces
;#8ac0
	or a
	ld hl,(piece_bmp_bottom)
	ld bc,#0028
	add hl,bc
	ld b,#14
.lgt1:
	ld a,(hl)
	cp #00
	jr z,.l1_nxt
	and #55
	cp #04
	jr nz,.l1_rplc
	xor #2a
	jr .l1_nxt
.l1_rplc:
	ld a,#3f
.l1_nxt:
	ld (hl),a
	dec hl
	djnz .lgt1

	; -----------------------------------
	; Top outer lighting of the lower pieces
	ld b,#14
.lgt2:
	ld a,(hl)
	cp #00
	jr z,.l2_nxt
	ld (hl),#3f
.l2_nxt:
	dec hl
	djnz .lgt2

	; -----------------------------------
	; Bottom outer lighting of the upper pieces
	ld b,#14
.shdw1:
	ld a,(hl)
	cp #00
	jr z,.s1_nxt
	ld (hl),#0c
.s1_nxt:
	dec hl
	djnz .shdw1

	; -----------------------------------
	; Bottom inner lighting of the upper pieces
	ld b,#14
.shdw2:
	ld a,(hl)
	cp #00
	jr z,.s2_nxt
	and #aa
	cp #2a
	jr nz,.s2_rplc
	xor #04
	jr .s2_nxt
.s2_rplc:
	ld a,#0c
.s2_nxt:
	ld (hl),a
	dec hl
	djnz .shdw2

	; -----------------------------
	; Draw burning flame 3 (which is identical to flame 2 ??? mistake ???)
;#8b0e
	ld de,FLAME3_BMP
	ld hl,(piece_scr_bottom)
	ld bc,PLAYGND_LINE_DIM
	call DRAW_BMP

	; ----------------------------
	; Delay
	ld b,#64
.delay31:
	ld c,#64
.delay32:
	dec c
	jr nz,.delay32
	djnz .delay31


	; -----------------------------
	; Fully redraw rebuild playground bitmap
	ld hl,PLAYGND_SCR
	ld de,PLAYGND_OFSCR
	ld bc,PLAYGND_DIM
	call DRAW_BMP

	; ----------------------------
	; Play the bliblibliip with increasing pitch
	ld d,#03
.play_blip:
	or a
	ld a,(blibliblip_pitch)
	ld b,#1e
	sbc b
	ld (blibliblip_pitch),a
	ld c,a
	ld a,#00
	call #bd34
	ld a,#08
	ld c,#0f
	call #bd34

	; ----------------------------
	; Delay
	ld b,#00
.delay41:
	ld c,#14
.delay42:
	dec c
	jr nz,.delay42
	djnz .delay41

	; ----------------------------
	; Cut sound off ??
	ld a,#08
	ld c,#00
	call #bd34
	
	; ----------------------------
	; Delay
	ld b,#00
.delay51:
	ld c,#1e
.delay52:
	dec c
	jr nz,.delay52
	djnz .delay51

	dec d
	jr nz,.play_blip

	; ----------------------------
	; Cut sound off ??
	ld a,#08
	ld c,#00
	call #bd34

	; ----------------------------
	; Decrease pitch a bit for next completed line
	ld a,(blibliblip_pitch)
	ld b,#32
	add b
	ld (blibliblip_pitch),a


	; ----------------------------
	; Enable XXX flyback
	ld a,#49
	ld (clear_combo_cnt),a
	ld hl,FLBK_CLEAR_COMBO_BLOCK
	call #bcda

	; ----------------------------
	; Increase falling speed (decrease delay)
	ld a,(down_delay)
	dec a
	jr z,.cont1
	ld (down_delay),a
	; ----------------------------
	; Adjust left-right move's repeat delay
	call ADAPT_MOVE_DELAY
.cont1:

	; ----------------------------
	; Draw current combo string 
	ld b,COMBO_LEN		;#0a
	ld hl,COMBO_SCR		;#c349
	ld de,(combo_str)
	call DRW_TXT
	ld (combo_str),de

	; ----------------------------
	; Adjust some game variables ...

	ld a,(combo_lines)
	inc a
	ld (combo_lines),a

	ld a,(piece_top_idx)
	dec a
	ld (piece_top_idx),a

	ld a,(playgnd_top_idx)
	dec a
	ld (playgnd_top_idx),a

	; ----------------------------
	; Decrease remaining lines
	ld a,(cur_lignes_X01)
	dec a
	ld (cur_lignes_X01),a
	jr nz,.cont2
	ld a,#0a
	ld (cur_lignes_X01),a

	ld a,(cur_lignes_X10)
	dec a
	ld (cur_lignes_X10),a
	jr nz,.cont2

	ld a,#01		; (reminder: digits are offseted by 1. Why? I certainly had a good reason :-) )
	ld (cur_lignes_X10),a	; 0 remaining lines 
	ld (cur_lignes_X01),a	; 0 remaining lines
.cont2:

	; ----------------------------
	; Display remaining lines
	ld hl,#c1cf
	ld a,(cur_lignes_X10)
	add #2f
	call DRW_CHAR
	ld a,(cur_lignes_X01)
	add #2f
	call DRW_CHAR

end_check_clptd_line:
	pop bc
	dec b
	jp nz,check_next_cpltd_line


	ld a,(combo_lines)
	cp #00
	jr z,.cont_combo

	cp #01
	jr nz,.combo2

	; One line -> 50 points
	ld b,#05
	call SCORE_ADD_TENS
	jr .cont_combo
.combo2:
	cp #02
	jr nz,.combo3

	; Two lines -> 100 points
	ld b,#01
	jr .add_combo
.combo3:
	cp #03
	jr nz,.combo4
	; Three lines -> 200 points
	ld b,#02
	jr .add_combo
.combo4:
	; Four lines -> 400 points
	ld b,#04
.add_combo:
	call SCORE_ADD_HDRDS
.cont_combo:


	ld a,(cur_lignes_X01)
	dec a
	ld b,a
	ld a,(cur_lignes_X10)
	dec a
	or b
	jr z,LEVEL_COMPLETED	; All requested lines completed

	; highest_line_idx = max((highest_line_idx), (piece_top_idx) )
	ld a,(piece_top_idx)
	ld b,a
	ld a,(playgnd_top_idx)
	sbc b
	jp nc,.cont_max
	or a
	ld a,(piece_top_idx)
	ld (playgnd_top_idx),a
.cont_max:

	ld a,(playgnd_top_idx)
	cp #18
	jr nc,GAME_OVER

	; Insert random block if necessary
	ld a,(FLBK_RNDM_BLCK_CNT)
	dec a
	call z,INSERT_RNDM_BLCK

	; Move playground up if necessary
	ld a,(FLBK_MOVE_UP_CNT)
	dec a
	call z,PLAYGROUND_MOVE_UP

	jp NEXT_PIECE

uncomplete_line:
	; Update variables
	ld hl,(piece_scr_bottom)
	ld bc,#ffc0
	add hl,bc
	ld (piece_scr_bottom),hl
	ld hl,(piece_bmp_bottom)
	ld bc,#ff60
	add hl,bc
	ld (piece_bmp_bottom),hl
	ld hl,(piece_msk_bottom)
	ld bc,#fff4
	add hl,bc
	ld (piece_msk_bottom),hl
	ld a,(nb_msk_lines)
	dec a
	ld (nb_msk_lines),a
	ld a,(nb_bmp_lines)
	ld b,#f8
	add b
	ld (nb_bmp_lines),a
	jp end_check_clptd_line

LEVEL_COMPLETED:
	ld a,(key_down)
	call GET_KEY_CODE
	ld b,#00
	call #bb39	; Disable down KEY repeat

	ld hl,FLBK_GAME_MELODY_BLOCK
	call #bcdd	; Disable Flyback block
	
	ld hl,(melody_ptr)	; Load note address
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
	ld hl,FLBK_GAME_MELODY_BLOCK
	call #bcdd	; Disable Flyback block

	call DISABLE_RNDM_BLCK
	call FLBK_MOVE_UP_DISABLE
	call SET_ROT_NORMAL
	call SET_DIR_NORMAL

	ld hl,(melody_ptr)	; Load note address
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
	ld a,(cur_player);|
	dec a		; |
	jr z,l8cef
	
	ld (p2_game_over),a	; <- PLAYER 2 GAME OVER
	jr l8cf3

l8cef:
	inc a		
	ld (p1_game_over),a	; <- PLAYER 1 GAME OVER

l8cf3:
	call DRAW_POPUP_BOX
	; Draw "SOUPIRANT"
	ld hl,#c3eb
	ld de,SOUPIRANT1_STR
	ld b,#09
	call DRW_TXT
	; Draw "<current player>"
	ld hl,#c433
	ld a,(cur_player)
	add #30
	call DRW_CHAR
	; Draw "Dommage"
	ld hl,DOMMAGE_SCR	;#c46d
	ld de,DOMMAGE_STR	;#7331
	ld b,DOMMAGE_LEN	;#07
	call DRW_TXT

	call DELAY
	call DRAW_POPUP_BOX
	; Draw "TU AS"
	ld hl,TU_AS_SCR		;#c3ef
	ld de,TU_AS_STR		;#7338
	ld b,TU_AS_LEN		;#05
	call DRW_TXT
	; Draw "ECHOUE"
	ld hl,ECHOUE_SCR	;#c42e
	ld de,ECHOUE_STR	;#733d
	ld b,ECHOUE_LEN		;#06
	call DRW_WTXT

	call DELAY
	call CHECK_HIGH_SCORE

	ld a,(p1_game_over)
	dec a
	ld b,a
	ld a,(p2_game_over)
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
	call DANCEFLR_CURTAIN_UP
	jp START
;#8d60
melody_ptr:
	DB #00
	DB #00
;#8d62
melody_dur:
	DB #00
;#8d63
FLBK_GAME_MELODY_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00
;#8d71
move_cnt:
	DB #00
;#8d72
down_cnt:
	DB #00

	DB #00		; unused

; ----------------------------
; Manage in game melody
; lateral move repeat delay and automatic move down
; ----------------------------
; #8d74
FLBK_GAME_MELODY_ISR:
	di
	push af
	push hl
	push bc
	ld a,(melody_dur)
	dec a
	jr nz,.cont
	ld hl,(melody_ptr)
.next:
	ld a,(hl)
	inc a
	jr nz,.play
	ld hl,GAME_MELODY
	ld (melody_ptr),hl
	jr .next
.play:
	inc hl
	ld (melody_ptr),hl
	dec a
	ld c,a
	ld a,#04
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	call CFG_AY_SND
	ld a,#09
.cont:
	ld (melody_dur),a

	ld a,(move_cnt)
	dec a
	jp z,.action1
	ld (move_cnt),a

.cont1:
	ld a,(down_cnt)
	dec a
	jp z,.action2
	ld (down_cnt),a
.cont2:
	pop bc
	pop hl
	pop af
	ei
	ret

.action2:
	ld hl,FALL		; Action 2
	ld (check1),hl		; force fall 
	ld (check2),hl		; force fall 
	jr .cont2

.action1:			; Action 1: 
	ld hl,CHECK_MOVE	; left-right repeat delay
	ld (check1),hl		; Allow lateral move
	jr .cont1

FLBK_CLEAR_COMBO_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00
clear_combo_cnt:
	DB #00

; #8ddf
FLBK_CLEAR_COMBO_ISR:
	di
	push hl
	push af
	push de
	push bc
	ld a,(clear_combo_cnt)
	dec a
	ld (clear_combo_cnt),a
	jr nz,.cont
	ld hl,COMBO_SCR
	ld bc,COMBO_DIM		;#0814
	call CLEAR_SCREEN_AREA
	ld hl,FLBK_CLEAR_COMBO_BLOCK
	call #bcdd
.cont:
	pop bc
	pop de
	pop af
	pop hl
	ei
	ret


; --------------------------------------------------------
; Rotate piece
; --------------------------------------------------------
;#
ROTATE:
	ld hl,(piece_cur_bmp_pos)
	ld (piece_prv_bmp_pos),hl
	ld hl,(piece_src_pos)
	ld (piece_prv_scr_pos),hl
	ld hl,(piece_dim)
	ld (piece_prv_dim),hl
	ld hl,(piece_bmp)
	ld (piece_prv_bmp),hl
	ld hl,(piece_cur_msk_pos)
	ld (piece_prv_msk_pos),hl
	ld bc,(piece_rot_B1)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_left
	ld bc,(piece_rot_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_left
	ld bc,(piece_rot_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_left
	ld bc,(piece_rot_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_left
	jp .valid
.try_left:
	; Try moving piece one step left
	ld hl,(piece_cur_msk_pos)
	dec hl
	ld (piece_prv_msk_pos),hl
	ld bc,(piece_rot_B1)
	ld bc,(piece_rot_B1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,.try_right
	ld bc,(piece_rot_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_right
	ld bc,(piece_rot_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_right
	ld bc,(piece_rot_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.try_right
	ld hl,(piece_cur_bmp_pos)
	dec hl
	dec hl
	ld (piece_cur_bmp_pos),hl
	ld hl,(piece_src_pos)
	dec hl
	dec hl
	ld (piece_src_pos),hl
	jp .valid
.try_right:
	; Try moving piece one step left
	ld hl,(piece_cur_msk_pos)
	inc hl
	ld (piece_prv_msk_pos),hl
	ld bc,(piece_rot_B1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,.cont
	ld bc,(piece_rot_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.cont
	ld bc,(piece_rot_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.cont
	ld bc,(piece_rot_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.cont
	ld hl,(piece_cur_bmp_pos)
	inc hl
	inc hl
	ld (piece_cur_bmp_pos),hl
	ld hl,(piece_src_pos)
	inc hl
	inc hl
	ld (piece_src_pos),hl
	jp .valid
.cont:
	ld hl,(piece_cur_msk_pos)
	dec hl
	dec hl
	ld (piece_prv_msk_pos),hl
	ld bc,(piece_rot_B1)
	ld bc,(piece_rot_B1)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(piece_rot_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(piece_rot_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(piece_rot_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,.cont

	ld hl,(piece_cur_bmp_pos)
	dec hl
	dec hl
	dec hl
	dec hl
	ld (piece_cur_bmp_pos),hl
	ld hl,(piece_src_pos)
	dec hl
	dec hl
	dec hl
	dec hl
	ld (piece_src_pos),hl
.valid:
	ld hl,(piece_prv_msk_pos)
	ld (piece_cur_msk_pos),hl
	ld hl,(piece_prv_bmp_pos)
	ld de,(piece_prv_bmp)
	ld bc,(piece_prv_dim)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(piece_rot_bmp)
	ld de,piece_bmp
	ld b,#1a
.loop:
	ld a,(hl)
	inc hl
	ld (de),a
	inc de
	djnz .loop
	ld de,(piece_rot_bmp_ofst)
	ld hl,(piece_cur_bmp_pos)
	add hl,de
	ld (piece_cur_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,(piece_prv_scr_pos)
	ld de,(piece_prv_bmp)
	ld bc,(piece_prv_dim)
	call DRAW_MASK_BMP
	ld hl,(piece_src_pos)
	ld de,(piece_rot_scr_ofst)
	add hl,de
	ld (piece_src_pos),hl
	ld de,(piece_cur_bmp_pos)
	ld bc,(piece_dim)
	jp DRAW_BMP_SYNC

; --------------------------------------------------------
; Move piece left
; --------------------------------------------------------
;#8f76
MOVE_LEFT:
	; Check if move is possible
	ld hl,(piece_cur_msk_pos)
	dec hl				; move 1 cell left
	ld (piece_prv_msk_pos),hl
	ld bc,(miece_msk_B1)		; Check if the piece block1 
	add hl,bc			; hits something
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT			; Move impossible -> abort
	ld bc,(piece_msk_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld bc,(piece_msk_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld bc,(piece_msk_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld hl,(piece_prv_msk_pos)
	ld (piece_cur_msk_pos),hl
	ld hl,(piece_cur_bmp_pos)
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(piece_cur_bmp_pos)
	dec hl
	dec hl
	ld (piece_cur_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,(piece_src_pos)
	dec hl
	dec hl
	ld (piece_src_pos),hl
	ld de,(piece_cur_bmp_pos)
	ld bc,(piece_dim)
	inc c
	inc c
	call DRAW_BMP_SYNC
	jp KEY_CONT

; --------------------------------------------------------
; Move piece right
; --------------------------------------------------------
;#8fe8
MOVE_RIGHT:
	ld hl,(piece_cur_msk_pos)
	inc hl
	ld (piece_prv_msk_pos),hl
	ld bc,(miece_msk_B1)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld bc,(piece_msk_B2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld bc,(piece_msk_B3)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld bc,(piece_msk_B4)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,KEY_CONT
	ld hl,(piece_prv_msk_pos)
	ld (piece_cur_msk_pos),hl
	ld hl,(piece_cur_bmp_pos)
	ld (piece_prv_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call CLEAR_MASK_BMP_OFFSCREEN1
	ld hl,(piece_prv_bmp_pos)
	inc hl
	inc hl
	ld (piece_cur_bmp_pos),hl
	ld de,(piece_bmp)
	ld bc,(piece_dim)
	call DRAW_MASK_BMP_OFFSCREEN1
	ld hl,(piece_src_pos)
	ld (piece_prv_scr_pos),hl
	inc hl
	inc hl
	ld (piece_src_pos),hl
	ld hl,(piece_prv_scr_pos)
	ld de,(piece_prv_bmp_pos)
	ld bc,(piece_dim)
	inc c
	inc c
	call DRAW_BMP_SYNC
	jp KEY_CONT

; --------------------------------------------------------
; Adapt in-game move repeat's delay (left-right) according to falling speed
; --------------------------------------------------------
;#9063
ADAPT_MOVE_DELAY:
	ld a,(down_delay)
	cp #03
	jr nc,.nxt1
	ld a,#04
	ld (move_delay),a
	ret
.nxt1:
	cp #05
	jr nc,.nxt2
	ld a,#08
	ld (move_delay),a
	ret
.nxt2:
	cp #07
	jr nc,.nxt3
	ld a,#09
	ld (move_delay),a
	ret
.nxt3:
	ld a,#0c
	ld (move_delay),a
	ret

menu_info:
	DB #00	; Either <score> or <level>
menu_dur:
	DB #00
FLBK_MENU_ANIM_BLOCK:
	DB #00,#00,#00,#00,#00
	DB #00,#00,#00,#00,#00

; -----------------------------------------------
; Main menu animation Flyback ISR
; -----------------------------------------------
;#9096
FLBK_MENU_ANIM_ISR:
	push af
	push bc
	push de
	push hl
	ld a,(menu_dur)
	dec a
	jr nz,.hiscore_done
	ld (menu_dur),a
	ld a,(menu_info)
	dec a
	jr nz,.hscore_levels
	; Display "<score 1>"
	ld hl,HSCORE1_SCR+8		;#c3b3		
	ld de,HSCORE1+3
	ld b,#05
	call DRW_TXT
	; Display "<score 2>"
	ld hl,HSCORE2_SCR+8		;#c3f3
	ld de,HSCORE2+3
	ld b,#05
	call DRW_TXT
	; Display "<score 3>"
	ld hl,HSCORE3_SCR+8		;#c433
	ld de,HSCORE3+3
	ld b,#05
	call DRW_TXT
	; Display "<score 4>"
	ld hl,HSCORE4_SCR+8		;#c473
	ld de,HSCORE4+3
	ld b,#05
	call DRW_TXT
	; Display "<score 5>"
	ld hl,HSCORE5_SCR+8		;#c4b3
	ld de,HSCORE5+3
	ld b,#05
	call DRW_TXT
	ld (menu_info),a  ; a!=0
	
	; Display "Kazatchok Dancer"
	ld hl,KOZAK_DANCER_SCR		;#e4ea
	ld de,KOZAK_DANCER_ZBMP
	call DRAW_ZBMP
	xor a
.hiscore_done:
	ld (menu_dur),a
	pop hl
	pop de
	pop bc
	pop af
	ret

.hscore_levels:
	ld a,#01
	ld (menu_info),a
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
	ld hl,ALINKA_HEAD_SCR		;#e4ea
	ld de,ALINKA_HEAD_ZBMP
	call DRAW_ZBMP
	xor a
	jr .hiscore_done

; ------------------------------------------
; Didn't beat the Amant
; ------------------------------------------
; #913d
NEW_AMANT_MISSED:
	call DRAW_POPUP_BOX
	; Draw "SOUPIRANT"
	ld hl,#c3eb
	ld de,SOUPIRANT1_STR
	ld b,#09
	call DRW_TXT

	; Draw "<cur_player>"
	ld hl,#c433
	ld a,(cur_player)
	add #30
	call DRW_CHAR

	; Draw "BRAVO"
	ld hl,BRAVO_SCR	;#c46f
	ld de,BRAVO_STR	;#7367
	ld b,BRAVO_LEN	;#05
	call DRW_TXT

	call DELAY
	call DRAW_POPUP_BOX

	; Draw "MAIS"
	ld hl,MAIS_SCR 		;#c3f0
	ld de,MAIS_STR		;#738b
	ld b,MAIS_LEN		;#04
	call DRW_TXT

	; Draw "TU N'AS"
	ld hl,TU_N_AS_SCR 	;#c42d
	ld de,TU_N_AS_STR	;#7381
	ld b,TU_N_AS_LEN	;#07
	call DRW_TXT

	; Draw "PAS"
	ld hl,PAS_SCR 	;#c471
	ld de,PAS_STR	;#7388
	ld b,PAS_LEN	;#03
	call DRW_TXT

	call DELAY
	call DRAW_POPUP_BOX

	; Draw "LE TITRE"
	ld hl,LE_TITRE_SCR	;#c3ec
	ld de,LE_TITRE_STR	;#7377
	ld b,LE_TITRE_LEN	;#08
	call DRW_TXT

	; Draw "D'"
	ld hl,D_SCR 	;#c42d
	ld de,D_STR	;#737f
	ld b,D_LEN	;#02
	call DRW_WTXT

	; Draw "AMANT"
	ld de,L_AMANT_STR+2	;#71eb
	ld b,#05
	call DRW_WTXT
	call DELAY
	jp CHECK_HIGH_SCORE

; ------------------------------------------
; Game finished. (31 levels)
; ------------------------------------------
;#91b2
GAME_FINISHED:
	ld a,(key_down)
	call GET_KEY_CODE
	ld b,#00
	call #bb39		; Disable CHAR repeat
	
	ld hl,PLAYGND_SCR
	ld bc,PLAYGND_DIM
	call CLEAR_SCREEN_AREA
	
	call DANCE_ANIMATION
	
	call START_KAZATCHOK
	
	ld a,(p1_game_over)
	dec a
	jr z,P2_FINISHED		; P1 is GAME OVER
	
	ld a,(p2_game_over)
	dec a
	jr z,P1_FINISHED		; P2 is GAME OVER
	
	; -----------------------
	; Compare player's scores
	; -----------------------
	ld hl,p1_score_X10000
	ld de,p2_score_X10000
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


; ------------------------------------------
; Player 1 beats player 2
; ------------------------------------------
;#91ed
P1_WINS:
	; Process P2 first
	ld a,#02
	ld (cur_player),a
	ld hl,cur_score_X00001
	ld de,p2_score_X00001
	ld b,#05
.cpy_P2_score:
	ld a,(de)
	ld (hl),a
	inc hl
	inc de
	djnz .cpy_P2_score

	call NEW_AMANT_MISSED		; Game finished but doesn't beat the Amant

; ------------------------------------------
; Player 1 finished the game
; ------------------------------------------
;#9203
P1_FINISHED:
	ld a,#01
	ld (cur_player),a
	ld hl,cur_score_X00001
	ld de,p1_score_X00001
	ld b,#05
.cpy_score:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .cpy_score
	jp CHECK_NEW_AMANT

; ------------------------------------------
; Player 2 beats player 1
; ------------------------------------------
;#9219
P2_WINS:
	; Process P1 first.
	ld a,#01
	ld (cur_player),a
	ld hl,cur_score_X00001
	ld de,p1_score_X00001
	ld b,#05
.cpy_score:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .cpy_score
	call NEW_AMANT_MISSED 		; Game finished but doesn't beat the Amant

; ------------------------------------------
; Player 2 finished the game
; ------------------------------------------
;#922f
P2_FINISHED:
	ld a,#02
	ld (cur_player),a
	ld hl,cur_score_X00001
	ld de,p2_score_X00001
	ld b,#05
.copy:
	ld a,(de)
	ld (hl),a
	inc de
	inc hl
	djnz .copy

; ------------------------------------------
; Check if the player beats the Amant's score
; ------------------------------------------
;#9242
CHECK_NEW_AMANT:
	ld hl,cur_score_X10000
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

; ------------------------------------------
; Called when a player beats the Amant's score
; ------------------------------------------
;#9260
NEW_AMANT_WIN:
	call DRAW_POPUP_BOX
	; Darw "BRAVO"
	ld hl,#c3ef
	ld de,#7367
	ld b,#05
	call DRW_TXT
	; Draw "SOUPIRANT"
	ld de,SOUPIRANT1_STR
	ld hl,#c42b
	ld b,#09
	call DRW_TXT
	; Draw "<current player>"
	ld a,(cur_player)
	add #30
	ld hl,#c473
	call DRW_CHAR

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "TU ES"
	ld hl,TU_ES_SCR	;#c3ef
	ld de,TU_ES_STR	;#736c
	ld b,TU_ES_LEN	;#05
	call DRW_TXT
	; Draw "DEVENU"
	ld hl,DEVENU_SCR	;#c42e
	ld b,DEVENU_LEN		;#06
	call DRW_TXT

	call DELAY

	call DRAW_POPUP_BOX
	; Draw "L'AMANT"
	ld hl,L_AMANT_SCR2
	ld de,L_AMANT_STR
	ld b,L_AMANT_LEN-1
	call DRW_WTXT

	; Draw "EN TITRE"
	ld hl,EN_TITRE_SCR 	;#c46c
	ld de,EN_TITRE_STR	;#738f
	ld b,EN_TITRE_LEN	;#08
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
	ld (hscore_changed),a
	
	; Update Amant
	inc de
	ld hl,cur_score_X10000
	ld b,#05
.cpy_score:
	ld a,(hl)
	add #2f
	ld (de),a
	inc de
	dec hl
	djnz .cpy_score
	
	ld b,#05
	ld de,HSCORE1

.check_soupirants:
	push bc
	push de
	inc de
	inc de
	inc de
	ld hl,cur_score_X10000
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
	call DANCEFLR_CURTAIN_UP
	jp START

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
	ld a,(cur_level_X10)
	add #2f
	ld (de),a
	inc de
	ld a,(cur_level_X01)
	add #2f
	ld (de),a
	jp .finished

; ---------------------------------------
; Check if current player's score is a high score
; ---------------------------------------
;#93b4
CHECK_HIGH_SCORE:
	ld b,#05		; nb of high score table's entry.
	ld de,HSCORE1
.check_entry:
	push bc
	push de
	inc de
	inc de
	inc de
	ld hl,cur_score_X10000
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
	ld (hscore_changed),a
	ld hl,cur_score_X10000
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
	ld a,(cur_level_X10)
	add #2f
	ld (de),a
	inc de
	ld a,(cur_level_X01)
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

; -------------------------------------------------
; Draw the entered name (to be able to choose a start level)
; -------------------------------------------------
;#948c
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

; -------------------------------------
; Display a dot and wait for keyboard input
; -------------------------------------
; HL: screen address to display '.'
; 
; A : contain the char pressed is any
;#94ad
WAIT_KEY:
	; Display '.'
	ld a,#2e	
	call DRW_CHAR
	dec hl
	dec hl
	jp #bb18	; wait key


; ----------------------------
; LEFT - RIGHT key code
; ----------------------------
;#94b7
KEY
.right:
	DB #01
.left:
	DB #08

; ---------------------------------------
; Restore direction left-right
; ---------------------------------------
;#94b9
SET_DIR_NORMAL:
	ld a,(KEY.right)
	ld (key_right),a
	ld a,(KEY.left)
	ld (key_left),a
	ret

; ---------------------------------------
; Reverse direction right-left
; ---------------------------------------
;#94c6
SET_DIR_REVERSED:
	ld a,(KEY.right)
	ld (key_left),a
	ld a,(KEY.left)
	ld (key_right),a
	ret

;l94d3:
rot_reversed:
	DB #00

; -------------------
; Set normal piece's rotation
; -------------------
;#94d4
SET_ROT_NORMAL:
	ld a,(rot_reversed)
	dec a
	ret nz
	ld a,#00
	jr SWITCH_ROT_DIRECTION

; --------------------------------
; Set reversed piece's rotation
; --------------------------------
;#94dd
SET_ROT_REVERSED:
	ld a,(rot_reversed)
	dec a
	ret z
	ld a,#01
; --------------------------------
; Swap piece daat to reverse rotation direction
; --------------------------------
;#94e4
SWITCH_ROT_DIRECTION:
	ld (rot_reversed),a
	ld hl,PIECES_DEFS		; = PIECE_1
	ld de,reversed_rot_buffer
	ld b,#03
.loop1:
	push bc
	inc hl
	inc hl
	inc hl
	inc hl
	ld b,#04
.loop2:
	push bc
	ld b,#0c
.loop3:
	inc hl
	djnz .loop3
	ld c,#0e
.loop4:
	ld a,(de)
	ld b,(hl)
	ld (hl),a
	ld a,b
	ld (de),a
	inc hl
	inc de
	dec c
	jr nz,.loop4
	pop bc
	djnz .loop2
	pop bc
	djnz .loop1
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
;#95d0
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
;#9601
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


; ----------------------------------
; Draw bitmap on screen
; DE: src address
; HL: dst address
; B : height
; C : width
; ----------------------------------
;#9621
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
;#9669
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
;#967b
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
;#9691
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
; Clear screen AREA
; HL: Screen address
; B : height
; C : width
; ----------------------------
;#96a8
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


; -----------------------------------------
; Add hundreds to score
; B : the number of hundreds to add
; -----------------------------------------
;l96b8
SCORE_ADD_HDRDS:
	ld a,(cur_score_X00100)
	add b
	jp HDRDS
; -----------------------------------------
; Add tens to score
; B : the number of tens to add
; -----------------------------------------
;#96bf
SCORE_ADD_TENS:
	ld a,(cur_score_X00010)
	add b
	jp TENS

; -----------------------------------------
; Add units to score
; B : the number of units to add
; -----------------------------------------
;#96c6
SCORE_ADD_UNITS:
	ld a,(cur_score_X00001)
	add b
	ld (cur_score_X00001),a
	cp #0b
	jr c,DRAW_SCORE
	or a
	sbc #0a
	ld (cur_score_X00001),a
	ld a,(cur_score_X00010)
	inc a
TENS:
	ld (cur_score_X00010),a
	sbc #0b
	jr c,DRAW_SCORE
	inc a
	ld (cur_score_X00010),a
	or a
	sbc #0b
	jr c,.cont
	inc a
	ld (cur_score_X00010),a
.cont:
	ld a,(cur_score_X00100)
	inc a
HDRDS:
	ld (cur_score_X00100),a
	or a
	sbc #0b
	jr c,DRAW_SCORE
	inc a
	ld (cur_score_X00100),a
	ld a,(cur_score_X01000)
	inc a
	ld (cur_score_X01000),a
	cp #0b
	jr c,DRAW_SCORE
	ld a,#01
	ld (cur_score_X01000),a
	ld a,(cur_score_X10000)
	inc a
	ld (cur_score_X10000),a
	cp #0b
	jr c,DRAW_SCORE
	ld a,#01
	ld (cur_score_X10000),a

;#971f:
DRAW_SCORE:
	ld hl,(cur_score_scr)
	ld a,(cur_score_X10000)
	add #2f
	call DRW_CHAR
	ld a,(cur_score_X01000)
	add #2f
	call DRW_CHAR
	ld a,(cur_score_X00100)
	add #2f
	call DRW_CHAR
	ld a,(cur_score_X00010)
	add #2f
	call DRW_CHAR
	ld a,(cur_score_X00001)
	add #2f
	jp DRW_CHAR

; -------------------------
; Draw text
; HL: screen location
; DE: text address
; B : text len
; -------------------------
;974a
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
;#9752
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
;#975a
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
	ld de,ALPHABET
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
	ld de,ALPHABET
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
	ld hl,PIECES_TABLE
	add hl,bc		; HL = &piece_table[random]
	ld e,(hl)		; 
	inc hl			;
	ld d,(hl)		; DE = piece_table[random]


	ld hl,nxt_piece_prz_pos ; Copy piece data into next piece buffer
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
PIECES_TABLE:
	DW PIECE_5_DEF
	DW PIECE_3_DEF
	DW PIECE_2_DEF
	DW PIECE_4_DEF
	DW PIECE_6_DEF
	DW PIECE_7_DEF
	DW PIECE_1_DEF

ANIMATION_END:
	; Draw dance floor
	ld hl,#fc82
	ld de,DANCEFLR_OFSCR
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

	; Draw dance floor
	ld hl,#fc82
	ld de,DANCEFLR_OFSCR
	ld bc,#6522
	call DRAW_BMP
	; proceed to curtain moving down.

; ------------------------------------------------
; Animate the curtain moving down on the dance floor
; ------------------------------------------------
DANCEFLR_CURTAIN_DOWN:
	ld hl,#fc42		; upper curtain screen origin
	ld de,DANCEFLR_OFSCR
	ld b,#65

.loop:
	push bc
	push hl
	push de
	push hl
	; Prepare offscreen bitmap by copying curtain bitmap
	call PREPARE_DANCEFLR_OFFSCR
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
DANCEFLR_CURTAIN_UP:
	ld hl,#e782	; lower curtain screen address.
	ld de,#3d33	; revealed background line address while curtain is moving up
	
	ld b,#66
.loop:
	push bc
	push hl
	push de
	call PREPARE_DANCEFLR_OFFSCR
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
PREPARE_DANCEFLR_OFFSCR:
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
DANCE_ANIMATION:
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

	ld hl,DANCEFLR_OFSCR	
	ld de,LFT_COLUMN_BMP
	ld bc,#6405		; 5x100
	call DRAW_BMP_OFSCR_W22
	ld hl,#2fe1
	ld de,RGT_COLUMN_BMP
	ld bc,#640a		; 10x100
	call DRAW_BMP_OFSCR_W22

	call DANCEFLR_CURTAIN_UP

	ld hl,#d605
	ld de,KOZAK_IN_BMP
	ld bc,#1904
	call DRAW_BMP

	ld a,#28		; initial delay, then deley 10 frames
	ld (dance_cnt),a
	ld hl,DANCE_TBL		; <- dance animation data
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

	; Enable kazatchok melody
	call START_KAZATCHOK

	; Draw empty dance floor
	ld hl,#fc82
	ld de,DANCEFLR_OFSCR
	ld bc,#6522
	call DRAW_BMP

	; Add Kozak ready to dance
	ld hl,#ee0e
	ld de,KOZAK7_BMP
	ld bc,#200a
	call DRAW_BMP

.wait:
	ld a,(dance_cnt)
	cp #00
	jr z,.done	; Animation terminated.
	jr .wait

.done:
	call ANIMATION_END
	jp STOP_KAZATCHOK

; --------------------------------
; Dance animation's flyback block
; --------------------------------
; #99dd
FLBK_DANCE_BLOCK:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00,#00  
dance_cnt:
	DB #00
dance_ptr:
	DB #00,#00

; #99ef
FLBK_DANCE_ISR:
	push af
	ld a,(dance_cnt)
	dec a
	ld (dance_cnt),a
	jr nz,.skip
	di
	push hl
	push de
	push bc
	ld a,DANCE_TEMPO	;#0a
	ld (dance_cnt),a
	ld hl,(dance_ptr)
	ld a,(hl)
	cp #ff
	jr nz,.anim
	ld a,#00		; <- indicate animation's done
	ld (dance_cnt),a
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
; Enable Kazatchok melody
; ---------------------------
START_KAZATCHOK:
	ld hl,KAZATCHOK_MELODY
	ld (kztk_ptr),hl
	ld a,#01
	ld (kztk_dur),a
	
	ld a,#04
	ld c,#00
	call CFG_AY_SND

	ld a,#05
	ld c,#00
	call CFG_AY_SND

	ld hl,FLBK_KAZATCHOK_BLOCK
	call #bcda	; add/enable flyback block

	ld a,#07
	ld c,#30
	call CFG_AY_SND
	ld a,#0a
	ld c,#0a
	jp CFG_AY_SND

; ---------------------------
; Stop Kazatchok melody
; ---------------------------
STOP_KAZATCHOK:
	ld a,#04
	ld c,#00
	call CFG_AY_SND
	ld a,#05
	ld c,#00
	call CFG_AY_SND
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	ld hl,FLBK_KAZATCHOK_BLOCK
	jp #bcdd	; disable/remove flyback block


kztk_ptr:		; 
	DB #00,#00	; Current note address

kztk_dur:		; 
	DB #00		; note duration

FLBK_KAZATCHOK_BLOCK:		; Music flyback block
	DB #00,#00	; Chain
	DB #00		; Count
	DB #00		; Class
	DB #00,#00	; Routine address
	DB #00		; ROM select byte
	DB #00,#00,#00	; User field

; ---------------------
; Kazatchok Flyback routine
; ---------------------
;#9a84:		
FLBK_KAZATCHOK_ISR:
	di
	push af
	push bc
	push hl
	ld a,(kztk_dur)
	dec a
	ld (kztk_dur),a
	jr nz,.cont	; if duration!=0 then keep playing same note
	; else program next note	
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	ld hl,(kztk_ptr)
.next:
	ld a,(hl)	; new note duration
	inc a		 
	jr nz,.play	; if duration != #FF then play note
	; else start over again
	ld hl,KAZATCHOK_MELODY	
	ld (kztk_ptr),hl
	jr .next
.play:
	dec a
	ld (kztk_dur),a
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
	ld (kztk_ptr),hl
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
ENABLE_RNDM_BLCK:
	xor a
	ld (FLBK_RNDM_BLCK_CNT),a
	ld hl,FLBK_RNDM_BLCK_BLOCK
	jp #bcda

; ---------------------------
; Disable random block flyback
; ---------------------------
;#9af2
DISABLE_RNDM_BLCK:
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
	ld (.value),a
	ld ix,#3ff1
	ld hl,#3e05
	ld b,#0f
.loop1:
	ld c,#0a
	ld d,#00
.loop2:
	ld a,(ix+#00)
	or a
	jr z,.empty
.cont:
	dec ix
	dec hl
	dec hl
	dec c
	jr nz,.loop2
	dec ix
	dec ix
	or a
	ld de,#ff74
	add hl,de
	djnz .loop1
	ret
.empty:
	ld a,d
	inc d
.value equ $ + 1
	cp #03
	jr nz,.cont
	ld a,(ix+#0c)
	dec a
	jr nz,.cont
	ld a,(ix-#0c)
	dec a
	jr z,.cont
	ld a,(ix-#18)
	dec a
	jr z,.cont
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
	ld a,(playgnd_top_idx)
	cp #0f
	ret nc
	inc a
	ld (playgnd_top_idx),a
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
	ld de,PLAYGND_OFSCR+(20*8)	; 1 line below
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
;#9d21
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



