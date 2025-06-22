; Amiga system shutdown and restore code

; Exec
_LVOSupervisor:		EQU	-30
_LVOOpenLibrary:	EQU	-552
_LVOCloseLibrary:	EQU	-414

AttnFlags:		EQU	$128

; Graphics

_LVOLoadView:		EQU	-222
_LVOWaitTOF:		EQU	-270
gb_ActiView:		EQU	$22
gb_copinit:		EQU	$26

SPR0DATA        	equ     spr+sd_dataA


; Disable the OS but preserve its state for restoration later

system_disable:
			; Start by opening graphics.library
				lea	GfxName,a1
				moveq	#0,d0
				move.l	4.w,a6
				jsr	_LVOOpenLibrary(a6)
				move.l	d0,_GfxBase
				bne	.gfxok

			; We shouldn't go any further if gfxlib wont open!
				moveq	#-1,d0
				rts

			; Save the OS view and copper lists
.gfxok:				move.l	d0,a6
				move.l	gb_ActiView(a6),_SysOldView
				move.l	gb_copinit(a6),_SysCopper

			; Set a blank display
				sub.l	a1,a1
				bsr	system_doview

			; Save the system dmacon/intena
				lea	_custom,a6
				move.w	dmaconr(a6),_SysDMACON
				move.w	intenar(a6),_SysINTENA

			; Stop all interrupts and DMA
				move.w	#$7FFF,d0
				move.w	d0,intena(a6)
				move.w	d0,dmacon(a6)

			; Clear the mouse pointer sprite data so we don't get sprite trails
				moveq	#0,d0
				move.l	d0,SPR0DATA(a6)

			; If we have a CPU better than 68000, get the VBR
				bsr	system_getvbr
				move.l	a0,_VBR

			; Preserve OS interrupt vectors
				lea	_SysInterruptVects,a1
				lea	$64,a0
				moveq	#6-1,d0
.ints:				move.l	(a0)+,(a1)+
				dbf	d0,.ints

			; Done
				moveq	#0,d0
				rts

; Restore the OS

system_restore:			lea	_custom,a6

			; Stop all interrupts and DMA
				move.w	#$7FFF,d0
				move.w	d0,intena(a6)
				move.w	d0,dmacon(a6)

			; Restore OS interrupt vectors
				lea	_SysInterruptVects,a0
				lea	$64,a1
				moveq	#6-1,d0
.ints:				move.l	(a0)+,(a1)+
				dbf	d0,.ints

			; Restore OS copper list
				move.l	_SysCopper,cop1lc(a6)
				move.w	d0,copjmp1(a6)

			; Restore OS dma/int settings
				move.w	#$8000,d1

				move.w	_SysINTENA,d0
				or.w	d1,d0
				move.w	d0,intena(a6)

				move.w	_SysDMACON,d0
				or.w	d1,d0
				move.w	d0,dmacon(a6)

			; Restore OS display
				move.l	_GfxBase,a6
				move.l	_SysOldView,a1
				bsr	system_doview

			; Close our graphics.library handle
				move.l	a6,a1
				move.l	4.w,a6
				jsr	_LVOCloseLibrary(a6)
				rts


system_doview:			jsr	_LVOLoadView(a6)
				jsr	_LVOWaitTOF(a6)
				jmp	_LVOWaitTOF(a6)


; Return VBR in a0

system_getvbr:			move.l	a6,-(sp)
				moveq	#0,d0
				move.l	4.w,a6
				btst	#0,AttnFlags+1(a6)	; 68010+?
				beq.s	.novbr

				lea	.vbr(pc),a5
				jsr	_LVOSupervisor(a6)
.novbr:				move.l	d0,a0
				move.l	(sp)+,a6
				rts

.vbr				dc.l	$4E7A0801	;movec	vbr,d0
				rte
