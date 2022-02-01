
FILE_BUF 	 equ #1388

DATA_LEN 	 equ #3b83

DATA_PTR 	 equ #4268

CURTAIN_BMP	 equ #5bbf
CURTAIN_BMP2	 equ #3d55

HIGH_SCORE_CHANGED	 equ #71e8	; High score updated

AMANT		 equ #7207	; Lover's Score entry
AMANT_SCORE	 equ #720b	; Lover's score
SOUPIRANT_1 	 equ #7210	; High Score table entry 1
SOUPIRANT_2 	 equ #721d	; High Score table entry 2
SOUPIRANT_3 	 equ #722a	; High Score table entry 3
SOUPIRANT_4 	 equ #7237	; High Score table entry 4
SOUPIRANT_5 	 equ #7244	; High Score table entry 5


CUR_LEVEL_PTR	 equ #7481	; current player level ptr
P1_LEVEL_PTR	 equ #7483	; P1 level ptr
P2_LEVEL_PTR	 equ #7485	; P2 level ptr
LEVEL_TABLE	 equ #7487	; Level table
				; 31 Level entries




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
	; Configure CRTC - change width/height 
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
	; using the Stack pointer push (thus going from #FFFF down to #C040)
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
	; Draw box: game area 
	; --------------------
	ld hl,#c168
	ld c,#14
	call BOX_TOP
	ld bc,#d014
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
	ld hl,l8d63	; frame flyback block
	ld de,l8d74	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block
	ld hl,l8d63
	call #bcdd	; remove/disable block;

	ld hl,l8dd0	; frame flyback block
	ld de,l8ddf	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block
	ld hl,l8dd0
	call #bcdd	; remove/disable block

	ld hl,l99dd	; frame flyback block
	ld de,l99ef	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block
	ld hl,l99dd
	call #bcdd	; remove/disable block

	ld hl,l9ac9	; frame flyback block
	ld de,l9ad4	; event routine address
	ld bc,#8100	; B: evt class | C: ROM select address of the routine
	call #bcd7	; init block 
	ld hl,l9ac9
	call #bcdd	; remove/disable block

	ld hl,l9b68	; frame flyback block	
	ld de,l9b74	; event routine address
	ld bc,#8100	; B: evt class | C: ROM
	call #bcd7	; init block 
	ld hl,l9b68
	call #bcdd	; remove/disable block

	ld hl,SND_FLBK	; frame flyback block
	ld de,SND_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM
	call #bcd7	; init block 
	ld hl,SND_FLBK
	call #bcdd	; remove/disable block

	ld hl,HSCORE_FLBK	; frame flyback block
	ld de,HSCORE_ISR	; event routine address
	ld bc,#8100	; B: evt class | C: ROM
	call #bcd7	; init block 
	ld hl,HSCORE_FLBK
	call #bcdd	; remove/disable block

	; ----------------------------------------
	; Reset variable l94d3
	; ----------------------------------------
	xor a
	ld (l94d3),a

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
	; Clear offside playing area
	; ??? maybe ???
	; 20*210
	; ----------------------------------------
	call CLR_2E53_3EBB

	; ----------------------------------------
	; Draw curtain
	; ----------------------------------------
	ld hl,#e442
	ld b,#03
.curtain:
	push bc
	push hl
	ld de,CURTAIN_BMP
	ld bc,#0822
	call DRAW_BMP

	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz .curtain

	; ----------------------------------------
	; Draw Player 1 head
	; ----------------------------------------
	ld hl,#e303
	ld de,#5eaf
	ld bc,#1405
	call DRAW_BMP

	; ----------------------------------------
	; Draw Player 2 head
	; ----------------------------------------
	ld hl,#c31e
	ld de,#5f13
	ld bc,#1405
	call DRAW_BMP

MAIN_START:
	ld a,(HIGH_SCORE_CHANGED)
	dec a
	jr nz,MAIN_SCREEN
	ld (HIGH_SCORE_CHANGED),a

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
FILE_TBL:
l8105:
	DB "ALINKA.TBL"

;l810f
MAIN_SCREEN:
	call ENBL_SND

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
	ld hl,HSCORE_FLBK
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

; Read keyboard
MAIN_CHOICE:	
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
	call CLEAR_AREA
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
	call CLEAR_AREA
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
	call CLEAR_AREA
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
	call CLEAR_AREA
	
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
	ld (l8916),a
	ld (l94b7),a

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
	ld (l890e),a
	ld (l94b8),a

	; Display "ACCELERE:"
	ld hl,#c608
	ld b,#09
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Insert CHAR into routine ??
	ld (l8906),a
	; Draw CHAR
	call DRW_CHAR

	; Display "ROTATION:"
	ld hl,#c648
	ld b,#09
	call DRW_TXT
	; Read CHAR
	call #bb18
	; Insert CHAR into routine ??
	ld (l8900),a
	; Draw CHAR
	call DRW_CHAR

	; Clear MENU Area
	ld hl,#c582
	ld bc,#3822
	call CLEAR_AREA
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
	ld hl,HSCORE_FLBK
	call #bcdd

	; Clear playing area
	ld hl,#e16a
	ld bc,#d014
	call CLEAR_AREA

	; ??
	call CURTAIN_DOWN

	; Disable sound
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	call DSBL_SND
	
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
	ld de,#7282
	
	call PLAY
	
	ld hl,(CUR_LEVEL_PTR)
	ld a,(hl)
	inc hl
	ld (P1_LEVEL_PTR),hl
	dec a

	call z,l9943

	ld de,P1_SCORE_X00001
	ld hl,CUR_SCORE_X00001
	ld b,#05
.save_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .save_score
	call l9af2
	call l9b92
	call l94d4
	call l94b9
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

	ld de,#7297
	call PLAY

	ld hl,(CUR_LEVEL_PTR)
	ld a,(hl)
	inc hl
	ld (P2_LEVEL_PTR),hl
	dec a
	call z,l9943

	ld de,P2_SCORE_X00001
	ld hl,CUR_SCORE_X00001
	ld b,#05
.save_score:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .save_score

	call l9af2
	call l9b92
	call l94d4
	call l94b9
	jp NEXT_LEVEL

PLAY:
	push de
	call CLR_2E53_3EBB
	ld hl,#e16a
	ld bc,#d014
	call CLEAR_AREA
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
	
	ld hl,#e16a
	ld bc,#d014
	call CLEAR_AREA

	ld hl,(CUR_LEVEL_PTR)
	ld de,CUR_LIGNES_X10
	ld b,#02
.copy_lignes:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .copy_lignes

	ld (CUR_LEVEL_PTR),hl
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

	ld hl,(CUR_LEVEL_PTR)
	ld a,(hl)
	ld (l88f6),a		; <- (88f6) = nb line (ten)

	call l9063

	inc hl
	ld a,(hl)
	inc hl
	ld (CUR_LEVEL_PTR),hl

	push af
	bit 7,a
	call nz,l9ae8
	pop af
	push af
	bit 6,a
	call nz,l9b88
	pop af
	push af
	bit 5,a
	call nz,l94dd
	pop af
	bit 4,a
	call nz,l94c6
	ld hl,(CUR_LEVEL_PTR)
	push hl
	ld e,(hl)
	inc hl
	ld d,(hl)
	inc hl
	call l9c48
	pop hl
	ld e,(hl)
	inc hl
	ld d,(hl)
	inc hl
	ld (CUR_LEVEL_PTR),hl
	call l9c83
	ld hl,#e16a
	ld de,#2e53
	ld bc,#d014
	call DRAW_BMP
	call l97f3
	ld hl,(#7598)
	ld de,(#759c)
	ld bc,(#759e)
	call DRAW_BMP
	call DELAY
	call l8839
	call DELAY
	ld hl,#c34a
	ld bc,#0812
	call CLEAR_AREA
	ld hl,#e15a
	ld bc,#200a
	call CLEAR_AREA
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

	call COUNT_BONUS
	jp DELAY

COUNT_BONUS:
	ld hl,#e16a
	ld de,#2e53
	ld bc,#d014
	call DRAW_BMP
	ld a,#05
	ld (CUR_BONUS_X100),a
	ld a,#01
	ld (CUR_BONUS_X010),a
	ld (CUR_BONUS_X001),a
	ld hl,#c1aa
	ld bc,#1014
	call CLEAR_AREA
	jp l87a2
l8702:
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
	ld hl,#3ddf
	ld b,#0a
l8722:
	ld a,(hl)
	inc hl
	inc hl
	cp #00
	jp nz,l87a2
	djnz l8722
	ld de,#5e0f
	ld bc,#0814
	ld hl,#e7aa
	call DRAW_BMP
	ld b,#64
l873a:
	ld c,#64
l873c:
	dec c
	jr nz,l873c
	djnz l873a
	ld hl,#e7aa
	ld bc,#0814
	call CLEAR_AREA
	call DELAY
l874d:
	ld a,(CUR_BONUS_X001)
	dec a
	ld (CUR_BONUS_X001),a
	jr nz,l877d
	ld a,#0a
	ld (CUR_BONUS_X001),a
	ld a,(CUR_BONUS_X010)
	dec a
	ld (CUR_BONUS_X010),a
	jr nz,l877d
	ld a,#0a
	ld (CUR_BONUS_X010),a
	ld a,(CUR_BONUS_X100)
	dec a
	ld (CUR_BONUS_X100),a
	jr nz,l877d
	ld a,#01
	ld (CUR_BONUS_X100),a
	ld (CUR_BONUS_X010),a
	ld (CUR_BONUS_X001),a
l877d:
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
	call l96c6
	pop af
	jr nz,l874d
	ret
l87a2:
	ld hl,#e7aa
	ld de,#5ccf
	ld bc,#0814
	call DRAW_BMP
	ld b,#64
l87b0:
	ld c,#96
l87b2:
	dec c
	jr nz,l87b2
	djnz l87b0
	ld hl,#3e93
	ld de,#3df3
	ld b,#c8
l87bf:
	ld c,#14
l87c1:
	ld a,(de)
	ld (hl),a
	dec de
	dec hl
	dec c
	jr nz,l87c1
	djnz l87bf
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
	ld hl,#e1ea
	ld de,#2f93
	ld bc,#b814
	call DRAW_BMP
	ld hl,#e7aa
	ld de,#5d6f
	ld bc,#0814
	call DRAW_BMP
	ld b,#64
l880e:
	ld c,#c8
l8810:
	dec c
	jr nz,l8810
	djnz l880e
	or a
	ld a,(CUR_BONUS_X010)
	sbc #02
	ld (CUR_BONUS_X010),a
	jr nc,l8836
	add #0a
	ld (CUR_BONUS_X010),a
	ld a,(CUR_BONUS_X100)
	dec a
	ld (CUR_BONUS_X100),a
	jr nz,l8836
	ld a,#01
	ld (CUR_BONUS_X100),a
	ld (CUR_BONUS_X010),a
l8836:
	jp l8702
l8839:
	ld a,(l8906)
	call GET_KEY_CODE
	ld b,#ff
	call #bb39
	ld hl,#7125
	ld (l8d60),hl
	ld a,#01
	ld (l8d62),a
	ld hl,l8d63
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
	ld hl,#75b6
	ld de,#759a
	ld b,#1c
l886f:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz l886f
	call l97f3
	ld hl,#2ef9
	ld (#758e),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9653
	ld hl,(#75b6)
	ld de,(#758e)
	ld bc,(#75ba)
	call l9621
	ld hl,(#7598)
	ld de,(#759c)
	ld bc,(#759e)
	call DRAW_BMP
	ld b,#03
	call l96c6
	ld bc,#61a8
l88ad:
	dec bc
	ld a,b
	or c
	jr nz,l88ad
	ld hl,#3ebf
	ld (#757e),hl
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
l8900 equ $ + 1
	cp #20
	call z,l8e02
	pop af
l8906 equ $ + 1
	cp #0a
	jp z,l892e
l890b equ $ + 1
	jp l890d
l890e equ $ + 1
l890d:
	ld a,#08
	call #bb1e
	jp nz,l8f76
l8916 equ $ + 1
	ld a,#01
	call #bb1e
	jp nz,l8fe8
l891e equ $ + 1
	jp l88fa
l8921 equ $ + 1
l8920:
	ld a,#0c
	ld (l8d71),a
	ld hl,l88fa
	ld (l890b),hl
	jp l88fa
l892e:
	ld b,#01
	call l96c6
l8933:
	ld hl,(#757e)
	ld bc,#000c
	add hl,bc
	ld (#7580),hl
	ld bc,(#75bc)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld bc,(#75be)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld bc,(#75c0)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld bc,(#75c2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l89ec
	ld hl,(#7580)
	ld (#757e),hl
	ld hl,(#75b6)
	ld (#7590),hl
	ld bc,#0040
	add hl,bc
	ld (#75b6),hl
	ld hl,(#758e)
	ld (#7592),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9691
	ld hl,(#758e)
	ld bc,#00a0
	add hl,bc
	ld (#758e),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9653
	ld hl,(#7590)
	ld de,(#7592)
	ld bc,(#75ba)
	ld a,#08
	add b
	ld b,a
	call l9621
	ld a,(#7583)
	dec a
	ld (#7583),a
	ld hl,(#7586)
	ld bc,#0040
	add hl,bc
	ld (#7586),hl
	ld hl,(#7584)
	ld bc,#000c
	add hl,bc
	ld (#7584),hl
	ld hl,(#7588)
	ld bc,#00a0
	add hl,bc
	ld (#7588),hl
	ld a,(#758a)
	inc a
	ld (#758a),a
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
	ld hl,(#757e)
	ld bc,(#75bc)
	add hl,bc
	ld (hl),#01
	ld bc,(#75be)
	add hl,bc
	ld (hl),#01
	ld bc,(#75c0)
	add hl,bc
	ld (hl),#01
	ld bc,(#75c2)
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
	ld hl,#e16a
	ld de,#2e53
	ld bc,#d014
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
	ld hl,l8dd0
	call #bcda
	ld a,(l88f6)
	dec a
	jr z,l8b8b
	ld (l88f6),a
	call l9063
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
	call l96bf
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
	call l96b8
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
	jr nc,l8ca6
	ld a,(l9ad3)
	dec a
	call z,l9afd
	ld a,(l9b72)
	dec a
	call z,l9b9d
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
	ld a,(l8906)
	call GET_KEY_CODE
	ld b,#00
	call #bb39	; Disable KEY repeat
	ld hl,l8d63
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


l8ca6:
	ld a,(l8906)
	call GET_KEY_CODE
	ld b,#00	
	call #bb39	; Disable KEY repeat
	ld hl,l8d63
	call #bcdd	; Disable Flyback block

	call l9af2
	call l9b92
	call l94d4
	call l94b9

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
	ld de,#7282
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
	call CLEAR_AREA
	call CLR_2E53_3EBB
	ld hl,#e16a
	ld bc,#d014
	call CLEAR_AREA
	call CURTAIN_UP
	jp MAIN_START
l8d60:
	nop
	nop
l8d62:
	nop
l8d63:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
l8d71:
	nop
l8d72:
	nop
	nop
l8d74:
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
l8dd0:
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
	nop
l8dde:
	nop
l8ddf:
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
	call CLEAR_AREA
	ld hl,l8dd0
	call #bcdd
l8dfc:
	pop bc
	pop de
	pop af
	pop hl
	ei
	ret
l8e02:
	ld hl,(#758e)
	ld (#7592),hl
	ld hl,(#75b6)
	ld (#7590),hl
	ld hl,(#75ba)
	ld (#7596),hl
	ld hl,(#75b8)
	ld (#7594),hl
	ld hl,(#757e)
	ld (#7580),hl
	ld bc,(#75ca)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	ld bc,(#75cc)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	ld bc,(#75ce)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	ld bc,(#75d0)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e4b
	jp l8f1a
l8e4b:
	ld hl,(#757e)
	dec hl
	ld (#7580),hl
	ld bc,(#75ca)
	ld bc,(#75ca)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8e92
	ld bc,(#75cc)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e92
	ld bc,(#75ce)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e92
	ld bc,(#75d0)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8e92
	ld hl,(#758e)
	dec hl
	dec hl
	ld (#758e),hl
	ld hl,(#75b6)
	dec hl
	dec hl
	ld (#75b6),hl
	jp l8f1a
l8e92:
	ld hl,(#757e)
	inc hl
	ld (#7580),hl
	ld bc,(#75ca)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8ed5
	ld bc,(#75cc)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld bc,(#75ce)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld bc,(#75d0)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld hl,(#758e)
	inc hl
	inc hl
	ld (#758e),hl
	ld hl,(#75b6)
	inc hl
	inc hl
	ld (#75b6),hl
	jp l8f1a
l8ed5:
	ld hl,(#757e)
	dec hl
	dec hl
	ld (#7580),hl
	ld bc,(#75ca)
	ld bc,(#75ca)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(#75cc)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(#75ce)
	add hl,bc
	ld a,(hl)
	cp #00
	ret nz
	ld bc,(#75d0)
	add hl,bc
	ld a,(hl)
	cp #00
	jr nz,l8ed5
	ld hl,(#758e)
	dec hl
	dec hl
	dec hl
	dec hl
	ld (#758e),hl
	ld hl,(#75b6)
	dec hl
	dec hl
	dec hl
	dec hl
	ld (#75b6),hl
l8f1a:
	ld hl,(#7580)
	ld (#757e),hl
	ld hl,(#7592)
	ld de,(#7594)
	ld bc,(#7596)
	call l9691
	ld hl,(#75c8)
	ld de,#75b8
	ld b,#1a
l8f36:
	ld a,(hl)
	inc hl
	ld (de),a
	inc de
	djnz l8f36
	ld de,(#75c4)
	ld hl,(#758e)
	add hl,de
	ld (#758e),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9653
	ld hl,(#7590)
	ld de,(#7594)
	ld bc,(#7596)
	call l967b
	ld hl,(#75b6)
	ld de,(#75c6)
	add hl,de
	ld (#75b6),hl
	ld de,(#758e)
	ld bc,(#75ba)
	jp l9621
l8f76:
	ld hl,(#757e)
	dec hl
	ld (#7580),hl
	ld bc,(#75bc)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(#75be)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(#75c0)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(#75c2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld hl,(#7580)
	ld (#757e),hl
	ld hl,(#758e)
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9691
	ld hl,(#758e)
	dec hl
	dec hl
	ld (#758e),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9653
	ld hl,(#75b6)
	dec hl
	dec hl
	ld (#75b6),hl
	ld de,(#758e)
	ld bc,(#75ba)
	inc c
	inc c
	call l9621
	jp l8920
l8fe8:
	ld hl,(#757e)
	inc hl
	ld (#7580),hl
	ld bc,(#75bc)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(#75be)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(#75c0)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld bc,(#75c2)
	add hl,bc
	ld a,(hl)
	cp #00
	jp nz,l8920
	ld hl,(#7580)
	ld (#757e),hl
	ld hl,(#758e)
	ld (#7592),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9691
	ld hl,(#7592)
	inc hl
	inc hl
	ld (#758e),hl
	ld de,(#75b8)
	ld bc,(#75ba)
	call l9653
	ld hl,(#75b6)
	ld (#7590),hl
	inc hl
	inc hl
	ld (#75b6),hl
	ld hl,(#7590)
	ld de,(#7592)
	ld bc,(#75ba)
	inc c
	inc c
	call l9621
	jp l8920

l9063:
	ld a,(l88f6)
	cp #03
	jr nc,l9070
	ld a,#04
	ld (l8921),a
	ret
l9070:
	cp #05
	jr nc,l907a
	ld a,#08
	ld (l8921),a
	ret
l907a:
	cp #07
	jr nc,l9084
	ld a,#09
	ld (l8921),a
	ret
l9084:
	ld a,#0c
	ld (l8921),a
	ret

HSCORE_INFO:
	DB #00	; Either <score> or <level>
HSCORE_DUR:
	DB #00
HSCORE_FLBK:
	DB #00,#00,#00,#00,#00
	DB #00,#00,#00,#00,#00

HSCORE_ISR:
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
	ld de,#7282
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
	ld a,(l8906)
	call GET_KEY_CODE
	ld b,#00
	call #bb39		; Disable CHAR repeat
	
	ld hl,#e16a
	ld bc,#d014
	call CLEAR_AREA
	
	call l9943
	
	call ENBL_SND
	
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
	ld de,#7282
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
	jr z,.custom_game
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
	ld (HIGH_SCORE_CHANGED),a
	
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
	ld hl,#e16a
	ld bc,#d014
	call CLEAR_AREA
	call CLR_2E53_3EBB
	call CURTAIN_UP
	jp MAIN_START

.custom_game:
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


CHECK_HIGH_SCORE:
	ld b,#05
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

	ld a,(l8906)
	call GET_KEY_CODE
	ld b,#00	
	call #bb39	; Disable KBD repeat
	
	pop de
	ld a,(custom_game)
	dec a
	jr z,CUSTOM_GAME

	call #bb18	; Wait KEY
.initiale_1:
	dec de
	ld hl,#c471
	call WAIT_KEY
	inc de
	cp #7f
	jr z,.initiale_1
	ld (de),a
	call DRW_CHAR
	inc de
.initiale_2:
	dec de
	ld hl,#c473
	call WAIT_KEY
	cp #7f
	jr z,.initiale_1
	inc de
	ld (de),a
	call DRW_CHAR
	ld hl,#c475
	call WAIT_KEY
	cp #7f
	jr z,.initiale_2
	inc de
	ld (de),a
	inc de
	call DRW_CHAR
	
UPDATE_HIGH_SCORE:
	ld a,#01
	ld (HIGH_SCORE_CHANGED),a
	ld hl,CUR_SCORE_X10000
	ld b,#05
.copy:
	ld a,(hl)
	add #2f
	ld (de),a
	dec hl
	inc de
	djnz .copy

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

CUSTOM_GAME:
	ld hl,custom_name
	ld b,#03
.cpy:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	djnz .cpy
	call DRAW_CUSTOM_NAME
	jp UPDATE_HIGH_SCORE

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

l94b9 equ $ + 2
l94b8 equ $ + 1
l94b7:
	ld bc,#3a08
	or a
	sub h
	ld (l8916),a
	ld a,(l94b8)
	ld (l890e),a
	ret

l94c6:
	ld a,(l94b7)
	ld (l890e),a
	ld a,(l94b8)
	ld (l8916),a
	ret
l94d3:
	DB #00
l94d4:
	ld a,(l94d3)
	dec a
	ret nz
	ld a,#00
	jr l94e4
l94dd:
	ld a,(l94d3)
	dec a
	ret z
	ld a,#01
l94e4:
	ld (l94d3),a
	ld hl,#7c5b
	ld de,l950f
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
l950f:
	sbc (hl)
	nop
	ld a,#00
	xor l
	ld a,h
	nop
	nop
	ld bc,#0c00
	nop
	inc c
	nop
	ld (bc),a
	nop
	ld (bc),a
	nop
	ld e,a
	ld a,h
	inc c
	nop
	ld bc,#0100
	nop
	ld a,(bc)
	nop
	nop
	nop
	nop
	nop
	ld a,c
	ld a,h
	ld bc,#0c00
	nop
	inc c
	nop
	ld bc,#6000
	rst #38
	ret nz
	rst #38
	sub e
	ld a,h
	ld (bc),a
	nop
	ld a,(bc)
	nop
	ld bc,#0100
	nop
	sbc (hl)
	nop
	ld a,#00
	add hl,de
	ld a,l
	ld bc,#0c00
	nop
	dec bc
	nop
	ld bc,#0200
	nop
	ld (bc),a
	nop
	bit 7,h
	inc c
	nop
	ld bc,#0100
	nop
	inc c
	nop
	nop
	nop
	nop
	nop
	push hl
	ld a,h
	ld bc,#0100
	nop
	dec bc
	nop
	inc c
	nop
	ld h,b
	rst #38
	ret nz
	rst #38
	rst #38
	ld a,h
	nop
	nop
	inc c
	nop
	ld bc,#0100
	nop
	sbc (hl)
	nop
	ld a,#00
	add l
	ld a,l
	ld bc,#0b00
	nop
	ld bc,#0c00
	nop
	ld (bc),a
	nop
	ld (bc),a
	nop
	scf
	ld a,l
	inc c
	nop
	ld bc,#0100
	nop
	dec bc
	nop
	nop
	nop
	nop
	nop
	ld d,c
	ld a,l
	ld bc,#0c00
	nop
	ld bc,#0b00
	nop
	ld h,b
	rst #38
	ret nz
	rst #38
	ld l,e
	ld a,l
	ld bc,#0b00
	nop
	ld bc,#0100
	nop

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



l9621:
	push bc
	ld b,#f5
l9624:
	in a,(c)
	rra
	jr nc,l9624
	pop bc
l962a:
	push bc
	push hl
	push de
l962d:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,l962d
	pop de
	ld hl,#0014
	add hl,de
	ex de,hl
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz l962a
	ret

; Draw bitmap
; B: height
; C: width
; DE: src address
; HL: dst address
DRAW_BMP:
	push bc
	push hl
l9644:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,l9644
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz DRAW_BMP
	ret

l9653:
	push bc
	push hl
l9655:
	ld a,(de)
	inc de
	cp #00
	jr z,l965c
	ld (hl),a
l965c:
	inc hl
	dec c
	jr nz,l9655
	pop hl
	ld bc,#0014
	add hl,bc
	pop bc
	djnz l9653
	ret
l9669:
	push bc
	push hl
l966b:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,l966b
	pop hl
	ld bc,#0022
	add hl,bc
	pop bc
	djnz l9669
	ret
l967b:
	push bc
	push hl
l967d:
	ld a,(de)
	inc de
	cp #00
	jr z,l9685
	ld (hl),#00
l9685:
	inc hl
	dec c
	jr nz,l967d
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz l967b
	ret
l9691:
	push bc
	push hl
l9693:
	ld a,(de)
	inc de
	cp #00
	jr z,l969b
	ld (hl),#00
l969b:
	inc hl
	dec c
	jr nz,l9693
	pop hl
	ld bc,#0014
	add hl,bc
	pop bc
	djnz l9691
	ret


; ----------------------------
; Clear AREA
; HL: Screen address
; B : height
; C : width
; ----------------------------
CLEAR_AREA:
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
	djnz CLEAR_AREA
	ret


l96b8:
	ld a,(CUR_SCORE_X00100)
	add b
	jp l96f3
l96bf:
	ld a,(CUR_SCORE_X00010)
	add b
	jp l96db
l96c6:
	ld a,(CUR_SCORE_X00001)
	add b
	ld (CUR_SCORE_X00001),a
	cp #0b
	jr c,l971f
	or a
	sbc #0a
	ld (CUR_SCORE_X00001),a
	ld a,(CUR_SCORE_X00010)
	inc a
l96db:
	ld (CUR_SCORE_X00010),a
	sbc #0b
	jr c,l971f
	inc a
	ld (CUR_SCORE_X00010),a
	or a
	sbc #0b
	jr c,l96ef
	inc a
	ld (CUR_SCORE_X00010),a
l96ef:
	ld a,(CUR_SCORE_X00100)
	inc a
l96f3:
	ld (CUR_SCORE_X00100),a
	or a
	sbc #0b
	jr c,l971f
	inc a
	ld (CUR_SCORE_X00100),a
	ld a,(CUR_SCORE_X01000)
	inc a
	ld (CUR_SCORE_X01000),a
	cp #0b
	jr c,l971f
	ld a,#01
	ld (CUR_SCORE_X01000),a
	ld a,(CUR_SCORE_X10000)
	inc a
	ld (CUR_SCORE_X10000),a
	cp #0b
	jr c,l971f
	ld a,#01
	ld (CUR_SCORE_X10000),a

l971f:
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
l9782:
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
	djnz l9782
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
l97c5:
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
	jr nc,l97d8
	ld bc,#c040
	add hl,bc
l97d8:
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
	jr nc,l97ea
	ld bc,#c040
	add hl,bc
l97ea:
	pop bc
	djnz l97c5
	pop hl
	inc hl
	inc hl
	pop de
	pop bc
	ret



l97f3:
	ld a,r
	ld c,a
	ld a,(l9838)
	add c
	sla a
	sla a
	add c
	inc a
	ld (l9838),a
	and #07
	cp #07
	jp nc,l97f3
	sla a
	ld c,a
	ld b,#00
	ld hl,l9839
	add hl,bc
	ld e,(hl)
	inc hl
	ld d,(hl)
	ld hl,#7598
	ld b,#1e
l981b:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz l981b
	ld hl,#e15a
	ld b,#20
l9826:
	push bc
	push hl
	ld c,#0a
l982a:
	ld (hl),#00
	inc hl
	dec c
	jr nz,l982a
	pop hl
	call NXT_SCR_LINE
	pop bc
	djnz l9826
	ret
l9838:
	DB #00
l9839:
	rst #10
	ld a,l
	inc sp
	ld a,l
	rst #00
	ld a,h
	sbc a
	ld a,l
	rrca
	ld a,(hl)
	ld b,a
	ld a,(hl)
	ld e,e
	ld a,h
l9847:
	ld hl,#fc82
	ld de,#2fc9
	ld bc,#6522
	call DRAW_BMP
	ld hl,#ee45
	ld de,#4a3f
	ld bc,#1604
	call DRAW_BMP
	ld bc,#0000
l9862:
	dec bc
	ld a,b
	or c
	jr nz,l9862
	ld hl,#fc82
	ld de,#2fc9
	ld bc,#6522
	call DRAW_BMP


CURTAIN_DOWN:
	ld hl,#fc42
	ld de,#2fc9
	ld b,#65
l987b:
	push bc
	push hl
	push de
	push hl
	call l98f4
	call l9910
	ld b,#f5
l9887:
	in a,(c)
	rra
	jr nc,l9887
	ld bc,#0822
	pop hl
	ld de,CURTAIN_BMP2
	call DRAW_BMP
	pop de
	ld hl,#0022
	add hl,de
	ex de,hl
	pop hl
	call NXT_SCR_LINE
	ld b,#64
l98a2:
	ld c,#0a
l98a4:
	dec c
	jr nz,l98a4
	djnz l98a2
	pop bc
	djnz l987b
	ld de,CURTAIN_BMP
	ld bc,#0822
	jp DRAW_BMP

CURTAIN_UP:
	ld hl,#e782
	ld de,#3d33
	ld b,#66
l98bd:
	push bc
	push hl
	push de
	call l98f4
	call l9910
	ld b,#f5
l98c8:
	in a,(c)
	rra
	jr nc,l98c8
	ld bc,#0822
	ld de,CURTAIN_BMP2
	call DRAW_BMP
	pop de
	ld bc,#0122
	call DRAW_BMP
	ld hl,#ffbc
	add hl,de
	ex de,hl
	pop hl
	or a
	call PRV_SCR_LINE
	ld b,#64
l98e9:
	ld c,#0a
l98eb:
	dec c
	jr nz,l98eb
	djnz l98e9
	pop bc
	djnz l98bd
	ret


l98f4:
	push hl
	push de
	push bc
	push af
	ld hl,CURTAIN_BMP
	ld de,CURTAIN_BMP2
	ld b,#08
l9900:
	ld c,#22
l9902:
	ld a,(hl)
	ld (de),a
	inc hl
	inc de
	dec c
	jr nz,l9902
	djnz l9900
	pop af
	pop bc
	pop de
	pop hl
	ret
l9910:
	push hl
	push de
	push bc
	push af
	ld hl,#fef0
	add hl,de
	ld de,CURTAIN_BMP2
	ld b,#08
l991d:
	ld c,#22
l991f:
	push bc
	ld a,(de)
	ld b,a
	and #aa
	jr nz,l992b
	ld a,(hl)
	and #aa
	or b
	ld (de),a
l992b:
	ld a,(de)
	ld b,a
	and #55
	jr nz,l9936
	ld a,(hl)
	and #55
	or b
	ld (de),a
l9936:
	inc hl
	inc de
	pop bc
	dec c
	jr nz,l991f
	djnz l991d
	pop af
	pop bc
	pop de
	pop hl
	ret


l9943:
	call CLR_2E53_3EBB
	ld hl,#2e53
	ld a,#3f
	ld b,#0c
l994d:
	ld c,#22
l994f:
	ld (hl),a
	inc hl
	dec c
	jr nz,l994f
	djnz l994d
	ld a,#30
	ld b,#22
l995a:
	ld (hl),a
	inc hl
	djnz l995a
	ld a,#0c
	ld b,#3f
l9962:
	ld c,#22
l9964:
	ld (hl),a
	inc hl
	dec c
	jr nz,l9964
	djnz l9962
	ld a,#30
	ld b,#22
l996f:
	ld (hl),a
	inc hl
	djnz l996f
	ld hl,#2fc9
	ld de,#5f77
	ld bc,#6405
	call l9669
	ld hl,#2fe1
	ld de,#616b
	ld bc,#640a
	call l9669
	call CURTAIN_UP
	ld hl,#d605
	ld de,#4a9b
	ld bc,#1904
	call DRAW_BMP

	ld a,#28
	ld (l99ec),a
	ld hl,#7431
	ld (l99ed),hl
	ld hl,l99dd
	call #bcda

	ld bc,#0000
l99ae:
	dec bc
	ld a,b
	or c
	jr nz,l99ae

	call ENBL_SND
	ld hl,#fc82
	ld de,#2fc9
	ld bc,#6522
	call DRAW_BMP
	ld hl,#ee0e
	ld de,#6d63
	ld bc,#200a
	call DRAW_BMP
l99ce:
	ld a,(l99ec)
	cp #00
	jr z,l99d7
	jr l99ce
l99d7:
	call l9847
	jp DSBL_SND

;
; Flyback block
; Which one ???
l99dd:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00,#00  
	DB #00,#00,#00,#00  
l99ec:
	DB #00
l99ed:
	DB #00,#00

l99ef:
	push af
	ld a,(l99ec)
	dec a
	ld (l99ec),a
	jr nz,l9a2c
	di
	push hl
	push de
	push bc
	ld a,#0a
	ld (l99ec),a
	ld hl,(l99ed)
	ld a,(hl)
	cp #ff
	jr nz,l9a18
	ld a,#00
	ld (l99ec),a
	ld hl,l99dd
	call #bcdd
	jp l9a29
l9a18:
	ld e,a
	inc hl
	ld a,(hl)
	inc hl
	ld (l99ed),hl
	ld d,a
	ld hl,#ee0e
	ld bc,#200a
	call DRAW_BMP
l9a29:
	pop bc
	pop de
	pop hl
l9a2c:
	pop af
	ei
	ret

; ---------------------------
; Enable sound melody
; ---------------------------
ENBL_SND:
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

	ld hl,SND_FLBK
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
DSBL_SND:
	ld a,#04
	ld c,#00
	call CFG_AY_SND
	ld a,#05
	ld c,#00
	call CFG_AY_SND
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	ld hl,SND_FLBK
	jp #bcdd	; disable/remove SND_FLBK block


NOTE_PTR:		; Address  HL=#6fe3  <- beginning of melody notes
	DB #00,#00	; Current note address

NOTE_DUR:		; Compteur ?? A=1
	DB #00		; Music note duration

SND_FLBK:		; Music flyback block
	DB #00,#00	; Chain
	DB #00		; Count
	DB #00		; Class
	DB #00,#00	; Routine address
	DB #00		; ROM select byte
	DB #00,#00,#00	; User field

; ---------------------
; Sound Flyback routine
; ---------------------
SND_ISR:
l9a84:		
	di
	push af
	push bc
	push hl
	ld a,(NOTE_DUR)
	dec a
	ld (NOTE_DUR),a
	jr nz,l9ac4	; if duration!=0 then keep playing same note
	; else program next note	
	ld a,#0a
	ld c,#00
	call CFG_AY_SND
	ld hl,(NOTE_PTR)
l9a9b:
	ld a,(hl)	; new note duration
	inc a		 
	jr nz,l9aa7	; if duration != #FF then play note
	; else start over again
	ld hl,#6fe3	
	ld (NOTE_PTR),hl
	jr l9a9b
l9aa7:
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
l9ac4:
	pop hl
	pop bc
	pop af
	ei
	ret



;
; Flyback block
;
l9ac9:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00
l9ad3:
	DB #00


;
; Flyback ISR routine
; it decrease a counter and stop if it reaches 0
;
l9ad4:
	push af
	; Decrease 'counter'
	ld a,(l9ad3)
	dec a
	jr nz,.cont
	; Disable flyback
	ld hl,l9ac9
	call #bcdd
	ld a,#01
.cont:
	ld (l9ad3),a
	pop af
	ret

; Enable flyback block
l9ae8:
	xor a
	ld (l9ad3),a
	ld hl,l9ac9
	jp #bcda

; Disable flyback block
l9af2:
	ld a,#ff
	ld (l9ad3),a
	ld hl,l9ac9
	jp #bcdd



l9afd:
	ld a,(l9838)
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
	ld de,#65d3
	ld bc,#0802
	call l9653
	ld hl,#e16a
	ld de,#2e53
	ld bc,#d014
	call DRAW_BMP
	ld a,#c8
	ld (l9ad3),a
	ld hl,l9ac9
	jp #bcda

; Flyback block
l9b68:
	DB #00,#00
	DB #00
	DB #00
	DB #00,#00
	DB #00
	DB #00,#00,#00
l9b72:
	DB #00
l9b73:
	DB #00

; Flyback routine...
; Decrease counter ???
l9b74:
	push af
	ld a,(l9b72)
	dec a
	jr nz,.cont
	; Disable flyback block
	ld hl,l9b68
	call #bcdd
	ld a,#01
.cont:
	ld (l9b72),a
	pop af
	ret

; Enable Flyback block
l9b88:
	xor a
	ld (l9b72),a
	ld hl,l9b68
	jp #bcda

; Disable Flyback block
l9b92:
	ld a,#ff
	ld (l9b72),a
	ld hl,l9b68
	jp #bcdd


l9b9d:
	ld a,(#7582)
	cp #0f
	ret nc
	inc a
	ld (#7582),a
	ld hl,#3ebb
	ld de,#3ec7
	ld b,#19
l9baf:
	ld c,#0c
l9bb1:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,l9bb1
	djnz l9baf

	ld hl,#2e53
	ld de,#2ef3
	ld b,#c8
l9bc2:
	ld c,#14
l9bc4:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	dec c
	jr nz,l9bc4
	djnz l9bc2

	ld ix,#3fe8
	ld a,r
	ld c,a
	ld a,(l9838)
	add c
	sla a
	sla a
	add c
	inc a
	ld (l9838),a
	and #1f
	add #07
	sra a
	sra a
	ld (l9b73),a
	ld b,#09
l9bee:
	push bc
	ld a,(l9b73)
	dec a
	jr z,l9c25
l9bf5:
	ld (l9b73),a
	push hl
	ld de,#6583
	ld bc,#0802
	call l9653
	pop hl
	inc hl
	inc hl
	ld (ix+#00),#01
	inc ix
	pop bc
	djnz l9bee
	ld hl,#e16a
	ld de,#2e53
	ld bc,#d014
	call DRAW_BMP
	ld a,#fa
	ld (l9b72),a
	ld hl,l9b68
	jp #bcda
l9c25:
	push hl
	ld de,#6553
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
l9c48:
	ld b,#14
	ld hl,#3ebb
l9c4d:
	ld (hl),#01
	inc hl
	ld c,#0a
l9c52:
	ld (hl),#00
	inc hl
	dec c
	jr nz,l9c52
	ld (hl),#01
	inc hl
	djnz l9c4d
	ld b,#48
l9c5f:
	ld a,(de)
	inc de
	cp #00
	jr z,l9c67
	ld a,#01
l9c67:
	ld (hl),a
	inc hl
	djnz l9c5f
	ld b,#18
l9c6d:
	ld (hl),#02
	inc hl
	djnz l9c6d
	ret

; Clear RAM #2E53 -> #3EBB (len=#D2*#14= #1068) 
; Usage ???
CLR_2E53_3EBB:
l9c73:
	ld hl,#2e53
	ld b,#d2
l9c78:
	ld c,#14
l9c7a:
	ld (hl),#00
	inc hl
	dec c
	jr nz,l9c7a
	djnz l9c78
	ret

l9c83:
	ld hl,#2e53
	ld b,#a0
l9c88:
	ld c,#14
l9c8a:
	ld (hl),#00
	inc hl
	dec c
	jr nz,l9c8a
	djnz l9c88
	ld b,#06
l9c94:
	inc de
	ld c,#0a
l9c97:
	push bc
	push de
	push hl
	ld b,#08
	ld a,(de)
	cp #00
	jr z,l9cc2
	cp #01
	jr z,l9cc7
	cp #02
	jr z,l9ccc
	cp #03
	jr z,l9cd1
	cp #04
	jr z,l9cd6
	cp #05
	jr z,l9cdb
	cp #06
	jr z,l9ce0
	cp #07
	jr z,l9ce5
	ld de,#65d3
	jr l9ce8
l9cc2:
	ld de,#6553
	jr l9ce8
l9cc7:
	ld de,#6563
	jr l9ce8
l9ccc:
	ld de,#6573
	jr l9ce8
l9cd1:
	ld de,#6583
	jr l9ce8
l9cd6:
	ld de,#6593
	jr l9ce8
l9cdb:
	ld de,#65a3
	jr l9ce8
l9ce0:
	ld de,#65b3
	jr l9ce8
l9ce5:
	ld de,#65c3
l9ce8:
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
	djnz l9ce8
	pop hl
	inc hl
	inc hl
	pop de
	inc de
	pop bc
	dec c
	jr nz,l9c97
	inc de
	push bc
	ld bc,#008c
	add hl,bc
	pop bc
	djnz l9c94
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
; DE: bitmap address
; HL: screen address
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
; l9D45
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
;l9d6f:
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
