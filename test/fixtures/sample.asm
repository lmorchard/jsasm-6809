;***************************************************************************
; DEFINE SECTION
;***************************************************************************
Intensity_7F    equ     $F2A9                   ; BIOS Intensity routine

Print_Str_d     equ     $F37A                   ; BIOS print routine
Wait_Recal      equ     $F192                   ; BIOS recalibration
music1          equ     $FD0D
Vec_Text_HW     equ     $C82A
Vec_Text_Height equ     $C82A
Vec_Text_Width  equ     $C82B

; start of vectrex memory with cartridge name...
		org     0
;***************************************************************************
; HEADER SECTION
;***************************************************************************
		db      "g GCE 2014", $80       ; 'g' is copyright sign
		dw      music1                  ; music from the rom
		db      $F8, $50, $20, -$66     ; height, width, rel y, rel x
						; (from 0,0)
		db      "HELLO CATS PROG 1",$80; some game information,
						; ending with $80
		db      0                       ; end of game header
;***************************************************************************
; CODE SECTION
;***************************************************************************
; here the cartridge program starts off

		ldd #$f460 ; HEIGTH, WIDTH (-14, 96)
		std Vec_Text_HW ; store to BIOS RAM location

main:
		jsr     Wait_Recal              ; Vectrex BIOS recalibration
		jsr     Intensity_7F            ; Sets the intensity of the
						; vector beam to $5f
		ldu     #hello_world_string     ; address of string
		lda     #$10                    ; Text position relative Y
		ldb     #-$68                   ; Text position relative X
		jsr     Print_Str_d             ; Vectrex BIOS print routine
		bra     main                    ; and repeat forever
;***************************************************************************
; DATA SECTION
;***************************************************************************
hello_world_string:
		db   $6a, " HELLO CATS ", $6a, $80
;***************************************************************************
		end  main
;***************************************************************************
