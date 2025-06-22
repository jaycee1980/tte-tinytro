;--------------------------------------------------------------------------------------------------
; amiga_cia.i
; Definitions for the Amiga CIA chips
;--------------------------------------------------------------------------------------------------

	IFND	__AMIGA_CIA_I
__AMIGA_CIA_I	SET	1

;; CIA chip base addresses

_ciaa			EQU	$BFE001
_ciab			EQU	$BFD000

;; cia register offsets
ciapra			EQU	$0000
ciaprb			EQU	$0100
ciaddra			EQU	$0200
ciaddrb			EQU	$0300
ciatalo			EQU	$0400
ciatahi			EQU	$0500
ciatblo			EQU	$0600
ciatbhi			EQU	$0700
ciatodlow		EQU	$0800
ciatodmid		EQU	$0900
ciatodhi		EQU	$0A00
ciasdr			EQU	$0C00
ciaicr			EQU	$0D00
ciacra			EQU	$0E00
ciacrb			EQU	$0F00

;; interrupt control register bits
CIAICRB_TA		EQU	0
CIAICRB_TB		EQU	1
CIAICRB_ALRM		EQU	2
CIAICRB_SP		EQU	3
CIAICRB_FLG		EQU	4
CIAICRB_IR		EQU	7		; read
CIAICRB_SETCLR		EQU	7		; write

CIAICRF_TA		EQU	(1<<0)
CIAICRF_TB		EQU	(1<<1)
CIAICRF_ALRM		EQU	(1<<2)
CIAICRF_SP		EQU	(1<<3)
CIAICRF_FLG		EQU	(1<<4)
CIAICRF_IR		EQU	(1<<7)
CIAICRF_SETCLR		EQU	(1<<7)


;; control register A bits
CIACRAB_START		EQU	0		; stop/start time
CIACRAB_PBON		EQU	1
CIACRAB_OUTMODE		EQU	2
CIACRAB_RUNMODE		EQU	3
CIACRAB_LOAD		EQU	4		; write strobe
CIACRAB_INMODE		EQU	5
CIACRAB_SPMODE		EQU	6
CIACRAB_TODIN		EQU	7

CIACRAF_START		EQU	(1<<0)
CIACRAF_PBON		EQU	(1<<1)
CIACRAF_OUTMODE		EQU	(1<<2)
CIACRAF_RUNMODE		EQU	(1<<3)
CIACRAF_LOAD		EQU	(1<<4)
CIACRAF_INMODE		EQU	(1<<5)
CIACRAF_SPMODE		EQU	(1<<6)
CIACRAF_TODIN		EQU	(1<<7)

;; control register B bits
CIACRBB_START		EQU	0
CIACRBB_PBON		EQU	1
CIACRBB_OUTMODE		EQU	2
CIACRBB_RUNMODE		EQU	3
CIACRBB_LOAD		EQU	4
CIACRBB_INMODE0		EQU	5
CIACRBB_INMODE1		EQU	6
CIACRBB_ALARM		EQU	7

CIACRBF_START		EQU	(1<<0)
CIACRBF_PBON		EQU	(1<<1)
CIACRBF_OUTMODE		EQU	(1<<2)
CIACRBF_RUNMODE		EQU	(1<<3)
CIACRBF_LOAD		EQU	(1<<4)
CIACRBF_INMODE0		EQU	(1<<5)
CIACRBF_INMODE1		EQU	(1<<6)
CIACRBF_ALARM		EQU	(1<<7)

;;  control register B INMODE masks
CIACRBF_IN_PHI2		EQU	0
CIACRBF_IN_CNT		EQU	(CIACRBF_INMODE0)
CIACRBF_IN_TA		EQU	(CIACRBF_INMODE1)
CIACRBF_IN_CNT_TA	EQU	(CIACRBF_INMODE0!CIACRBF_INMODE1)

;; ciaa port A (0xbfe001) bit definitions
CIAB_GAMEPORT1		EQU	7	; (inp) gameport 1, pin 6 (fire button)
CIAB_GAMEPORT0		EQU	6	; (inp) gameport 0, pin 6 (fire button)
CIAB_DSKRDY		EQU	5	; (inp) disk ready
CIAB_DSKTRACK0		EQU	4	; (inp) disk on track 00
CIAB_DSKPROT		EQU	3	; (inp) disk write protect
CIAB_DSKCHANGE		EQU	2	; (inp) disk change
CIAB_LED		EQU	1	; (out) led light control (0=bright, 1=dim)
CIAB_OVERLAY		EQU	0	; (out) memory overlay bit

CIAF_GAMEPORT1		EQU	(1<<7)
CIAF_GAMEPORT0		EQU	(1<<6)
CIAF_DSKRDY		EQU	(1<<5)
CIAF_DSKTRACK0		EQU	(1<<4)
CIAF_DSKPROT		EQU	(1<<3)
CIAF_DSKCHANGE		EQU	(1<<2)
CIAF_LED		EQU	(1<<1)
CIAF_OVERLAY		EQU	(1<<0)

;; ciaa port B (0xbfe101) - the whole register is used for the parallel port

;; ciab port A (0xbfd000) -- serial and printer control
CIAB_COMDTR		EQU	7	; serial Data Terminal Ready
CIAB_COMRTS		EQU	6	; serial Request to Send
CIAB_COMCD		EQU	5	; serial Carrier Detect
CIAB_COMCTS		EQU	4	; serial Clear to Send
CIAB_COMDSR		EQU	3	; serial Data Set Ready
CIAB_PRTRSEL		EQU	2	; printer SELECT
CIAB_PRTRPOUT		EQU	1	; printer paper out
CIAB_PRTRBUSY		EQU	0	; printer busy

CIAF_COMDTR		EQU	(1<<7)
CIAF_COMRTS		EQU	(1<<6)
CIAF_COMCD		EQU	(1<<5)
CIAF_COMCTS		EQU	(1<<4)
CIAF_COMDSR		EQU	(1<<3)
CIAF_PRTRSEL		EQU	(1<<2)
CIAF_PRTRPOUT		EQU	(1<<1)
CIAF_PRTRBUSY		EQU	(1<<0)

;; ciab port B (0xbfd100) -- disk control (all outputs)
CIAB_DSKMOTOR		EQU	7	; disk motor
CIAB_DSKSEL3		EQU	6	; disk select unit 3
CIAB_DSKSEL2		EQU	5	; disk select unit 2
CIAB_DSKSEL1		EQU	4	; disk select unit 1
CIAB_DSKSEL0		EQU	3	; disk select unit 0
CIAB_DSKSIDE		EQU	2	; disk side select
CIAB_DSKDIREC		EQU	1	; disk direction of seek
CIAB_DSKSTEP		EQU	0	; disk step heads

CIAF_DSKMOTOR		EQU	(1<<7)
CIAF_DSKSEL3		EQU	(1<<6)
CIAF_DSKSEL2		EQU	(1<<5)
CIAF_DSKSEL1		EQU	(1<<4)
CIAF_DSKSEL0		EQU	(1<<3)
CIAF_DSKSIDE		EQU	(1<<2)
CIAF_DSKDIREC		EQU	(1<<1)
CIAF_DSKSTEP		EQU	(1<<0)

	ENDC
