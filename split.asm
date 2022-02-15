;;#7e65
MAIN:
;; Reset the disk rom
	ld hl,(#BE7D)
        ld a,(hl)
        push    AF
        LD    C,7
        LD    DE,#40
        LD    HL,#B0FF
        CALL    #BCCE
        POP    AF
        OR    A
        JR    Z,CONT
        RST    #18	;; Call ROM routine
        DW    LECTB	;; Address of the call structure
	JR 	CONT	;; Could have made it more compact by moving the call structure further away  

LECTB   DW    #CDDD	;; Call address (select drive B)
        DB    7		;; ROM number

CONT:
	;; --------------------
	;; Set border color
	;; --------------------
	ld bc,#0404
	call #bc38

	;; --------------------
	;; Set pen colors, all purple
	;; to hide the on screen data preparation
	;; --------------------
;;#7e6b
	ld a,#10
MAIN_hide_loop:
	push af
	ld bc,#0404
	dec a
	call #bc32
	pop af
	dec a
	jr nz,MAIN_hide_loop
