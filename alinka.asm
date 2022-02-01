	org #7e65
main:
	ld bc,#0404		; 
	call #bc38		; SCR SET BORDER
	ld a,#10
l7e6d:
	push af
	ld bc,#0404		 
	dec a
	call #bc32		; SCR SET INK
	pop af
	dec a
	jr nz,l7e6d
	call #bd19		; MC WAIT FLYBACK
	ld a,#c0		; 
	call #bc08		; SCR SET BASE #C000
	ld a,#00		;
	call #bc0e		; SCR SET MODE #00
	
; ****************************** Deobfuscate data
	ld hl,#4268		
	ld bc,#3b83
l7e8c:
	ld a,(hl)
	xor c
	ld (hl),a
	inc hl
	dec bc
	ld a,b
	or c
	jr nz,l7e8c

	ld hl,#bc26
	ld (#9d69),hl
	ld hl,#c000
	ld de,#4268
	call #9d45

	ld hl,#c000
	ld de,#400b
	ld b,#c6
l7eac:
	push bc
	push hl
	ld c,#50
l7eb0:
	ld a,(hl)
	ld (de),a
	inc de
	inc hl
	dec c
	jr nz,l7eb0
	pop hl
	call #bc26
	pop bc
	djnz l7eac
	ld hl,#9d0a
	ld (#9d69),hl
	ld hl,#8105
	ld de,#1388
	ld b,#0a
	call #bc77
	ld hl,#7207
	call #bc83
	call #bc7a
	ld b,#04
	ld hl,#7fd6
l7edd:
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
	djnz l7edd
	ld (#7fde),sp
	ld sp,#0000
	ld hl,#c0c0
	ld b,#ff




;	Called with 
; 	ld (#9d69),#bc26
; 	hl,#c000
;	de,#4268

	org #9d45
	ld a,(de)		; a = #C6
	inc de			; de= #4269
	ld b,a			; b = a= #C6
l9d48:
	push bc			; push bc [#C6xx]
	push hl			; push hl [#C000}
l9d4a:
	ld a,(de)		; a  = #50
	inc de			; de = #427A
	cp #ff			; NZ
	jp z,l9d67		;
	bit 7,a			; Z
	jr z,l9d60		;
	res 7,a			; a = #52
	ld b,a			; b = a = #52
	ld a,(de)		; a = #E1
	inc de			; de = #427B
l9d5a:
	ld (hl),a		; (#C000)=#E1
	inc hl			;
	djnz l9d5a
	jr l9d4a
l9d60:
	ld b,a
l9d61:
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	djnz l9d61
l9d67:
	pop hl
	call #9d0a ; <- replaced by #bc26 (next scr line)
	pop bc
	djnz l9d48
	ret






	ld de,#9d94
	ld b,#04
l9d74:
	push bc
	push hl
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
l9d80:
	ld (hl),a
	inc hl
	dec c
	jr nz,l9d80
	ld a,(de)
	inc de
	ld (hl),a
	inc hl
	ld a,(de)
	inc de
	ld (hl),a
	pop hl
	call #9d0a
	pop bc
	djnz l9d74
	ret


	out (c),c