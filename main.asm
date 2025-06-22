; -----------------------------------------------------------------------------
;
; TTE - TinyTro
;
; Code : h0ffman, jaycee1980 (cleanup verison)
; Music : h0ffman
; ASCII : ne7 & FuZion
; Synth : Blueberry  -> https://github.com/askeksa/Cinter
;
; -----------------------------------------------------------------------------
; tab=8

; Options
; SYSTEM_NICE		if 1, suspend and restore the OS gracefully
; ABSORIGIN		if defined, build at an absolute location with ORG, no sections.
; USETOPAZ		if 1, use system topaz.font data, else includes "assets/font.bin"
; MUSIC_ON		if 1, play music

; Default options

	; If we're building as a regular executable, make sure we preserve the system!
	IFND ABSORIGIN
SYSTEM_NICE		EQU	1
	ENDIF

	; Default to music being on
	IFND MUSIC_ON
MUSIC_ON		EQU	1
	ENDIF

	; Default to Sync FX on
	IFND SYNC_FX
SYNC_FX			EQU	1
	ENDIF

	; Default to using system font
	IFND USETOPAZ
USETOPAZ		EQU	1
	ENDIF

MENU_ON	= 1		; include all code required for menu selection

	IF MENU_ON=1
MENU_LINE	= 4	; text line menu starts on
MENU_COUNT	= 9	; count of menu items
MENU_SELECT	= 1	; 0 = options on / off : 1 = pack menu selection
	ENDIF


; Includes

			INCLUDE	"include/amiga_custom.i"
			INCLUDE	"include/amiga_cia.i"
			INCLUDE	"include/amiga_trapvects.i"

; Defines

SCREEN_WIDTH		EQU	640
SCREEN_WIDTH_BYTE	EQU	SCREEN_WIDTH/8
SCREEN_HEIGHT		EQU	256
SCREEN_SIZE		EQU	SCREEN_WIDTH_BYTE*SCREEN_HEIGHT
FONT_CHAR_COUNT		EQU	224

DMACONSET		EQU	DMAF_SETCLR|DMAF_COPPER|DMAF_RASTER|DMAF_MASTER
INTENASET		EQU	INTF_SETCLR|INTF_INTEN|INTF_VERTB

			INCLUDE	"vars.i"

; ---------------------------------------------------------
; Main - entry point
; ---------------------------------------------------------
	IFND ABSORIGIN
			SECTION	"code", code
	ELSE
			ORG	ABSORIGIN
	ENDIF

START:			movem.l	d1-d7/a1-a6,-(sp)

		; Let's get going!

	IF SYSTEM_NICE=1
			bsr	system_disable
			tst.b	d0
			bne	.sysfail
	ELSE
		; Assume our VBR is zero!!
		; TODO: should we do something better than this perhaps?
			suba.l	a0,a0
			move.l	a0,_VBR
	ENDIF

		; If we're using the system font, grab it
	IF USETOPAZ=1
			bsr	GrabTopazFont
	ENDIF

		; Initialise Cinter music
	IF MUSIC_ON=1
			move.l	a6,-(sp)
			lea	CinterTune,a2
			lea	CinterInstruments,a4
			lea	_CinterVars,a6
			bsr	CinterInit
			move.l	(sp)+,a6
	ENDIF

		; Set up the copper list

			lea	cpBannerPlanes,a0
			move.l	#ScreenMem,d0
			move.w	d0,6(a0)
			swap	d0
			move.w	d0,2(a0)
			adda.l	#8,a0

			move.l	#ScreenOffset,d0
			move.w	d0,6(a0)
			swap	d0
			move.w	d0,2(a0)

		; Start our copper list
			lea	_custom,a6

			move.l	#CopperList,cop1lc(a6)
			move.w	d0,copjmp1(a6)

		; Set up our VBlank IRQ

			lea	VBlankIRQ(pc),a1
			move.l	_VBR,a0
			move.l	a1,tv_Lev3Int(a0)

		; Setup our keyboard routines if we're using the menu
	IF MENU_ON=1
			bsr	KeyboardInit
	ENDIF

		; DMA and interrupts on!
			move.w	#INTENASET,intena(a6)
			move.w	#DMACONSET,dmacon(a6)

		; Init RNG
			lea	_Vars,a5
			move.l	#$BABEFEED,d0
			bsr	PrepRand
    
		; Our main loop
.mainloop:		tst.w	FrameReq(a5)
			beq	.noreq

			move.w	#1,FrameActive(a5)
			clr.w	FrameReq(a5)
			bsr	HoffBannerLogic
			clr.w	FrameActive(a5)

.noreq:			cmp.w	#5,TitleStatus(a5)
			bcc	.noleft

	IF MENU_ON=1
			tst.b	KeyEnter(a5)
			bne	.yesenter
	ENDIF
			btst    #6,_ciaa+ciapra
			bne	.noleft

.yesenter:		move.w	#5,TitleStatus(a5)
.noleft:		tst.w	Exit(a5)
			beq	.mainloop

		; Time to go...
	IF MENU_ON=1
			bsr	KeyboardRemove
	ENDIF


	IF SYSTEM_NICE=1
			bsr	system_restore
	ELSE
			move.w	#$7FFF,d0
			move.w	d0,dmacon(a6)
			move.w	d0,intena(a6)
			move.w	d0,intreq(a6)
			move.w	#$000,color00(a6)
	ENDIF

		; If no menu, return 0 in d0
	IF MENU_ON=0
			moveq	#0,d0
	ENDIF

		; exit back to whoever called us!
.sysfail:		movem.l	(sp)+,d1-d7/a1-a6
			rts


; -------------------------------------------------------
; PrepRand - generates small set of random numbers

	; d0 = initial seed 
PrepRand:		lea	RandList(a5),a0
			move.l	d0,RandomSeed(a5)

			move.w	#RAND_MAX-1,d2

.loop:			move.l	RandomSeed(a5),d0
			move.l	d0,d1
			swap.w	d0
			mulu.w	#$9D3D,d1
			add.l	d1,d0
			move.l	d0,RandomSeed(a5)
			clr.w	d0
			swap.w	d0
			and.w	#31<<3,d0
			move.w	d0,(a0)+
			dbra	d2,.loop
			rts


; -------------------------------------------------------
; Grab system Topaz font


tf_CharData	= $22
tf_Modulo	= $26

	IF USETOPAZ=1
GrabTopazFont:		move.l	a6,-(sp)

	IF SYSTEM_NICE=1
			move.l	_GfxBase,a6
	ELSE
			move.l	$4.w,a6
			lea	GfxName,a1
			moveq	#0,d0
			jsr	-552(a6)		; exec/OpenLibrary()
			move.l	d0,a6
	ENDIF

	; Open topaz.font
			lea	.TopazName(pc),a0
			move.l	#8<<16,-(sp)		; build textAttr on the stack
			move.l	a0,-(sp)
			move.l	sp,a0
			jsr	-72(a6)			; gfx/OpenFont()

			addq.l	#8,sp			; free textAddr on the stack
			move.l	d0,a0

	; Grab it's data (NurdleFont!)
			moveq	#0,d0
			move.w	tf_Modulo(a0),d0
			move.l	tf_CharData(a0),a0

			lea	FontData,a1
			move.w	#FONT_CHAR_COUNT-1,d1

.charloop		move.l	a0,a2
			moveq	#8-1,d2

.pixloop		move.b	(a2),(a1)+
			add.l	d0,a2
			dbra	d2,.pixloop

			addq.l	#1,a0
			dbra	d1,.charloop

			move.l	(sp)+,a6
			rts

.TopazName:		dc.b	"topaz.font",0
			EVEN

	ENDIF

; ---------------------------------------------------------
; Top/Bottom stripe sync effects

	IF MUSIC_ON&SYNC_FX

	; This routine is called from inside CinterPlay2

UpdateSyncFX:		move.l	a0,-(sp)
			lea	_Vars,a0

			cmp.w	#3*8,d3
			bne.s	.skipkick
			move.w	#SYNC_COL_COUNT-2,SyncKick(a0)

.skipkick		cmp.w	#4*8,d3
			bne	.skipsnare
			move.w	#SYNC_COL_COUNT-2,SyncSnare(a0)
.skipsnare		move.l	(sp)+,a0
			rts

	; Called from the vblank

SyncFX:			lea	SyncPal(pc),a0
			move.w	SyncKick(a5),d0
			move.w	SyncSnare(a5),d1
			move.w	(a0,d0.w),cpKickColor+2
			move.w	(a0,d1.w),cpSnareColor+2

			tst.w	SyncKick(a5)
			beq 	.skipkick
			subq.w	#2,SyncKick(a5)

.skipkick:		tst.w	SyncSnare(a5)
			beq	.skipsnare
			subq.w	#2,SyncSnare(a5)
.skipsnare:		rts


SyncPal:		dc.w	$a22,$b22,$c33,$c44,$e55,$e66,$f88,$faa
SYNC_COL_COUNT:		EQU	*-SyncPal
	ENDIF

; ---------------------------------------------------------
; VBlank interrupt handler

VBlankIRQ:		movem.l	d0-a6,-(sp)
			lea	_custom,a6

		; Only handle vertical blanks
			move.w	intreqr(a6),d0
			btst	#INTB_VERTB,d0
			beq	.notus

		; Increase frame tick counter
			lea	_Vars,a5
			addq.w	#1,TickCounter(a5)

			tst.w	FrameActive(a5)
			bne.s	.norun

			move.w	#1,FrameReq(a5)
.norun:

		; Play Cinter music
	IF MUSIC_ON=1
			movem.l	a5-a6,-(sp)
			lea	_CinterVars,a6
			bsr	CinterPlay1
			bsr	CinterPlay2
			movem.l	(sp)+,a5-a6

	IF SYNC_FX=1
			bsr	SyncFX
	ENDIF
	ENDIF

		; Acknowlege the interrupt
			move.w	#INTF_VERTB,d0
			move.w	d0,intreq(a6)
			move.w	d0,intreq(a6)

		; We're done...
.notus:			movem.l	(sp)+,d0-a6
			nop
			rte


; ---------------------------------------------------------
; Keyboard Handling

	IF MENU_ON=1

KeyboardInit:		lea	_ciaa,a0
			move.b	#CIAICRF_SETCLR|CIAICRF_SP,ciaicr(a0)		;clear all ciaa-interrupts
			tst.b	ciaicr(a0)
			and.b	#~(CIACRAF_SPMODE),ciacra(a0)			;set input mode

			move.w	#INTF_PORTS,intreq(a6)				;clear ports interrupt

			lea	KeyboardIRQ,a0
			move.l	_VBR,a1
			move.l	a0,tv_Lev2Int(a1)
			move.w	#INTF_SETCLR|INTF_INTEN|INTF_PORTS,intena(a6)
			rts

KeyboardRemove:        	move.w	#INTF_PORTS,d0
			move.w	d0,intena(a6)
			move.w	d0,intreq(a6)
			rts	

KeyboardIRQ:		movem.l	d0-d1/a0-a1/a6,-(sp)
			lea	_custom,a6

		; Only handle CIA A interrupt (other hardware might generate a level 2 IRQ in expanded amigas)
			move.w	intreqr(a6),d0
			btst	#INTB_PORTS,d0
			beq	.notus

		; Only handle the keyboard serial register
			lea	_ciaa,a0
			btst	#CIAICRB_SP,ciaicr(a0)
			beq	.notkeyb

		; Read key from serial register
			move.b	ciasdr(a0),d0 
			or.b	#CIACRAF_SPMODE,ciacra(a0)	; Start handshake

		; Decode the keypress
			btst	#0,d0
			beq	.keyup

			not.b	d0
			lsr.b	#1,d0

		; Test for the key presses we want
			lea	_Vars,a1

			cmp.b	#$4c,d0
			seq	KeyUp(a1)

			cmp.b	#$4d,d0
			seq	KeyDown(a1)

			cmp.b	#$44,d0
			seq	KeyEnter(a1)
.keyup:

		; Wait a little while before handshaking
			moveq	#3-1,d0
.wait1:			move.b	vhposr(a6),d0
.wait2:			cmp.b	vhposr(a6),d0
			beq.s	.wait2
			dbf	d0,.wait1


		; Handshake
			and.b	#~(CIACRAF_SPMODE),ciacra(a0)	; end handshake


		; Acknowlege the interrupt
.notkeyb:		move.w	#INTF_PORTS,d0
			move.w	d0,intreq(a6)
			move.w	d0,intreq(a6)

		; We're done...
.notus:			movem.l	(sp)+,d0-d1/a0-a1/a6
			nop
			rte
	ENDIF

; ---------------------------------------------------------
; Included code

	IF SYSTEM_NICE=1
			INCLUDE	"system_disable.asm"
	ENDIF

	IF MUSIC_ON=1
			INCLUDE	"cinter.asm"
	ENDIF

			INCLUDE	"banner.asm"

; ---------------------------------------------------------
; Data

	IF SYSTEM_NICE|USETOPAZ
GfxName:		dc.b	"graphics.library",0
			EVEN
	ENDIF

	IF USETOPAZ=0
FontData:		INCBIN	"assets/font.dat"
	ENDIF

	IF MUSIC_ON=1
CinterTune:		INCBIN	"assets/tune.dat"
	ENDIF

TextProg:		dc.l	LogoText
			dc.l	SCREEN_WIDTH_BYTE*8
			dc.w	0			; no centring
			dc.w	6*FPS			; wait time

			dc.l	IntroText
			dc.l	SCREEN_WIDTH_BYTE*10
			dc.w	1			; centring
			dc.w	18*FPS			; wait time

			dc.l	BBSText
			dc.l	SCREEN_WIDTH_BYTE*8
			dc.w	0			; no centring
			dc.w	6*FPS			; wait time

			dc.l	MembersText
			dc.l	SCREEN_WIDTH_BYTE*10
			dc.w	1			; centring
			dc.w	15*FPS			; wait time
			dc.l	0			; repeat

LogoText:		INCBIN	"text/ne7-tte.txt"
			dc.b	0

BBSText:		INCBIN	"text/r32_bbs_ad2.txt"
			dc.b	0

IntroText:		INCBIN	"text/intro.txt"
			dc.b	0

MembersText:		INCBIN	"text/tte-members.txt"
			dc.b	0

			EVEN

	IF MENU_ON=1
MenuProg:		dc.l	MenuText
			dc.l	SCREEN_WIDTH_BYTE*10
			dc.w	1			; centring
			dc.w	15*FPS			; wait time
			dc.l	0

MenuText:		INCBIN	"text/menu.txt"
			dc.b	0
	ENDIF

; ---------------------------------------------------------
; Chip Data

	IFND	ABSORIGIN
		SECTION	"chipdata", data_c
	ENDIF

BKG_COLOR = $113

CopperList:		dc.w	diwstrt,$2c81	; window start stop
			dc.w	diwstop,$2cc1	; 192 + 8
			dc.w	ddfstrt,$3c	; datafetch start stop 
			dc.w	ddfstop,$d4

			dc.w	bplcon0,$A200	; set as 2 bp display
			dc.w	bplcon1,$0040	; set scroll 0
			dc.w	bplcon2,$0000
			dc.w	bpl1mod,0
			dc.w	bpl2mod,0

			dc.w	color00,$000
			dc.w	color01,$ccc
			dc.w	color02,$000
			dc.w	color03,$ccc

cpBannerPlanes:		dc.w	bpl1pt,0
			dc.w	bpl1pt+2,0
			dc.w	bpl2pt,0
			dc.w	bpl2pt+2,0


		; top lines
			dc.w	$27ff,$fffe
cpKickColor:		dc.w	color00,$a22
			dc.w	$28ff,$fffe
			dc.w	color00,$000
			dc.w	$29ff,$fffe
			dc.w	color00,BKG_COLOR

	IFD	MENU_ON
		; select lines
cpSelect:		dc.w	$50ff,$fffe
			dc.w	color00,BKG_COLOR
			dc.w	$58ff,$fffe
			dc.w	color00,BKG_COLOR
	ENDIF

		; end lines
			dc.w	$ffdf,$fffe	; Wait for end of NTSC area
			dc.w	$2eff,$fffe	; Wait for bottom of PAL
			dc.w	color00,$000
			dc.w	$2fff,$fffe

cpSnareColor:		dc.w	color00,$a22
			dc.w	$30ff,$fffe
			dc.w	color00,$000

			dc.w	$FFFF,$FFFE

; ---------------------------------------------------------
; Chip BSS

	IFND	ABSORIGIN
		SECTION	"chipbss", bss_c
	ENDIF

	IF MUSIC_ON=1
CinterInstruments:	ds.b	44604
	ENDIF

ScreenOffset:		ds.b	SCREEN_WIDTH_BYTE*4
ScreenMem:		ds.b	HOFFBANNER_PLANE_SIZE

; ---------------------------------------------------------
; BSS

	IFND ABSORIGIN
		SECTION	"vars", bss
	ENDIF

_VBR:			ds.l	1

	IF SYSTEM_NICE=1
_GfxBase:		ds.l	1
_SysInterruptVects:	ds.l	6
_SysOldView:		ds.l	1
_SysCopper:		ds.l	1
_SysDMACON:		ds.w	1
_SysINTENA:		ds.w	1
	ENDIF

	IF USETOPAZ=1
FontData:		ds.b	FONT_CHAR_COUNT*8
	ENDIF

	IF MUSIC_ON=1
_CinterVars:		ds.b	c_SIZE
	ENDIF

_Vars:			ds.b	Vars_SIZEOF
			EVEN
	