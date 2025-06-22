;--------------------------------------------------------------------------------------------------
; amiga_custom.i
; Definitions for the Amiga custom hardware registers
;--------------------------------------------------------------------------------------------------

	IFND	__AMIGA_CUSTOM_I
__AMIGA_CUSTOM_I	SET	1

;; Custom chip base address

_custom			EQU	$DFF000

;; Custom chip register offsets 

bltddat			EQU	$000
dmaconr			EQU	$002
vposr			EQU	$004
vhposr			EQU	$006
dskdatr			EQU	$008
joy0dat			EQU	$00A
joy1dat			EQU	$00C
clxdat			EQU	$00E

adkconr			EQU	$010
pot0dat			EQU	$012
pot1dat			EQU	$014
potinp			EQU	$016
serdatr			EQU	$018
dskbytr			EQU	$01A
intenar			EQU	$01C
intreqr			EQU	$01E

dskpt			EQU	$020
dsklen			EQU	$024
dskdat			EQU	$026
refptr			EQU	$028
vposw			EQU	$02A
vhposw			EQU	$02C
copcon			EQU	$02E
serdat			EQU	$030
serper			EQU	$032
potgo			EQU	$034
joytest			EQU	$036
strequ			EQU	$038
strvbl			EQU	$03A
strhor			EQU	$03C
strlong			EQU	$03E

bltcon0			EQU	$040
bltcon1			EQU	$042
bltafwm			EQU	$044
bltalwm			EQU	$046
bltcpt			EQU	$048
bltbpt			EQU	$04C
bltapt			EQU	$050
bltdpt			EQU	$054
bltsize			EQU	$058
bltcon0l		EQU	$05B		; note: byte access only
bltsizv			EQU	$05C
bltsizh			EQU	$05E

bltcmod			EQU	$060
bltbmod			EQU	$062
bltamod			EQU	$064
bltdmod			EQU	$066

bltcdat			EQU	$070
bltbdat			EQU	$072
bltadat			EQU	$074

sprhdat			EQU	$078
bplhdat			EQU	$07A

deniseid		EQU	$07C
dsksync			EQU	$07E

cop1lc			EQU	$080
cop2lc			EQU	$084
copjmp1			EQU	$088
copjmp2			EQU	$08A
copins			EQU	$08C
diwstrt			EQU	$08E
diwstop			EQU	$090
ddfstrt			EQU	$092
ddfstop			EQU	$094
dmacon			EQU	$096
clxcon			EQU	$098
intena			EQU	$09A
intreq			EQU	$09C
adkcon			EQU	$09E

aud0			EQU	$0A0
aud1			EQU	$0B0
aud2			EQU	$0C0
aud3			EQU	$0D0

bplpt			EQU	$0E0
bpl1pt			EQU	$0E0
bpl2pt			EQU	$0E4
bpl3pt			EQU	$0E8
bpl4pt			EQU	$0EC
bpl5pt			EQU	$0F0
bpl6pt			EQU	$0F4
bpl7pt			EQU	$0F8
bpl8pt			EQU	$0FC

bplcon0			EQU	$100
bplcon1			EQU	$102
bplcon2			EQU	$104
bplcon3			EQU	$106
bpl1mod			EQU	$108
bpl2mod			EQU	$10A
bplcon4			EQU	$10C
clxcon2			EQU	$10E

bpl1dat			EQU	$110
bpl2dat			EQU	$112
bpl3dat			EQU	$114
bpl4dat			EQU	$116
bpl5dat			EQU	$118
bpl6dat			EQU	$11A
bpl7dat			EQU	$11C
bpl8dat			EQU	$11E

sprpt			EQU	$120
spr0pt			EQU	$120
spr1pt			EQU	$124
spr2pt			EQU	$128
spr3pt			EQU	$12C
spr4pt			EQU	$130
spr5pt			EQU	$134
spr6pt			EQU	$138
spr7pt			EQU	$13C

spr			EQU	$140

color			EQU	$180
color00			EQU	$180
color01			EQU	$182
color02			EQU	$184
color03			EQU	$186
color04			EQU	$188
color05			EQU	$18A
color06			EQU	$18C
color07			EQU	$18E
color08			EQU	$190
color09			EQU	$192
color10			EQU	$194
color11			EQU	$196
color12			EQU	$198
color13			EQU	$19A
color14			EQU	$19C
color15			EQU	$19E
color16			EQU	$1A0
color17			EQU	$1A2
color18			EQU	$1A4
color19			EQU	$1A6
color20			EQU	$1A8
color21			EQU	$1AA
color22			EQU	$1AC
color23			EQU	$1AE
color24			EQU	$1B0
color25			EQU	$1B2
color26			EQU	$1B4
color27			EQU	$1B6
color28			EQU	$1B8
color29			EQU	$1BA
color30			EQU	$1BC
color31			EQU	$1BE

htotal			EQU	$1C0
hsstop			EQU	$1C2
hbstrt			EQU	$1C4
hbstop			EQU	$1C6
vtotal			EQU	$1C8
vsstop			EQU	$1CA
vbstrt			EQU	$1CC
vbstop			EQU	$1CE
sprhstrt		EQU	$1D0
sprhstop		EQU	$1D2
bplhstrt		EQU	$1D4
bplhstop		EQU	$1D6
hhposw			EQU	$1D8
hhposr			EQU	$1DA
beamcon0		EQU	$1DC
hsstrt			EQU	$1DE
vsstrt			EQU	$1E0
hcenter			EQU	$1E2
diwhigh			EQU	$1E4
bplhmod			EQU	$1E6
sprhpt			EQU	$1E8
bplhpt			EQU	$1EC

fmode			EQU	$1FC

; AudChannel
ac_ptr			EQU	$00	; ptr to start of waveform data
ac_len			EQU	$04	; length of waveform in words
ac_per			EQU	$06	; sample period
ac_vol			EQU	$08	; volume
ac_dat			EQU	$0A	; sample pair
ac_SIZEOF		EQU	$10

; SpriteDef
sd_pos			EQU	$00
sd_ctl			EQU	$02
sd_dataA		EQU	$04
sd_dataB		EQU	$06
sd_SIZEOF		EQU	$08

; Definitions of bits in dmacon, dmaconr

DMAB_SETCLR		EQU	15
DMAB_AUD0		EQU	0
DMAB_AUD1		EQU	1
DMAB_AUD2		EQU	2
DMAB_AUD3		EQU	3
DMAB_DISK		EQU	4
DMAB_SPRITE		EQU	5
DMAB_BLITTER		EQU	6
DMAB_COPPER		EQU	7
DMAB_RASTER		EQU	8
DMAB_MASTER		EQU	9
DMAB_BLITHOG		EQU	10
DMAB_BLTNZERO		EQU	13
DMAB_BLTDONE		EQU	14

DMAF_SETCLR		EQU	(1<<15)
DMAF_AUD0		EQU	(1<<0)
DMAF_AUD1		EQU	(1<<1)
DMAF_AUD2		EQU	(1<<2)
DMAF_AUD3		EQU	(1<<3)
DMAF_DISK		EQU	(1<<4)
DMAF_SPRITE		EQU	(1<<5)
DMAF_BLITTER		EQU	(1<<6)
DMAF_COPPER		EQU	(1<<7)
DMAF_RASTER		EQU	(1<<8)
DMAF_MASTER		EQU	(1<<9)
DMAF_BLITHOG		EQU	(1<<10)
DMAF_BLTNZERO		EQU	(1<<13)
DMAF_BLTDONE		EQU	(1<<14)

DMAF_AUDIO		EQU	$000F
DMAF_ALL		EQU	$01FF

; Definitions of bits in intena, intenar, intreq, intreqr

INTB_SETCLR		EQU	15	;Set/Clear control bit. Determines if bits written with a 1 get set or cleared. Bits written with a zero are allways unchanged.
INTB_INTEN		EQU	14	;Master interrupt (enable only )
INTB_EXTER		EQU	13	;External interrupt
INTB_DSKSYNC		EQU	12	;Disk re-SYNChronized
INTB_RBF		EQU	11	;serial port Receive Buffer Full
INTB_AUD3		EQU	10	;Audio channel 3 block finished
INTB_AUD2		EQU	9	;Audio channel 2 block finished
INTB_AUD1		EQU	8	;Audio channel 1 block finished
INTB_AUD0		EQU	7	;Audio channel 0 block finished
INTB_BLIT		EQU	6	;Blitter finished
INTB_VERTB		EQU	5	;start of Vertical Blank
INTB_COPER		EQU	4	;Coprocessor
INTB_PORTS		EQU	3	;I/O Ports and timers
INTB_SOFTINT		EQU	2	;software interrupt request
INTB_DSKBLK		EQU	1	;Disk Block done
INTB_TBE		EQU	0	;serial port Transmit Buffer Empty

INTF_SETCLR		EQU	(1<<15)
INTF_INTEN		EQU	(1<<14)
INTF_EXTER		EQU	(1<<13)
INTF_DSKSYNC		EQU	(1<<12)
INTF_RBF		EQU	(1<<11)
INTF_AUD3		EQU	(1<<10)
INTF_AUD2		EQU	(1<<9)
INTF_AUD1		EQU	(1<<8)
INTF_AUD0		EQU	(1<<7)
INTF_BLIT		EQU	(1<<6)
INTF_VERTB		EQU	(1<<5)
INTF_COPER		EQU	(1<<4)
INTF_PORTS		EQU	(1<<3)
INTF_SOFTINT		EQU	(1<<2)
INTF_DSKBLK		EQU	(1<<1)
INTF_TBE		EQU	(1<<0)

; Definitions of bits in adkcon, adkconr

ADKB_SETCLR		EQU	15	; standard set/clear bit
ADKB_PRECOMP1		EQU	14	; two bits of precompensation
ADKB_PRECOMP0		EQU	13
ADKB_MFMPREC		EQU	12	; use mfm style precompensation
ADKB_UARTBRK		EQU	11	; force uart output to zero
ADKB_WORDSYNC		EQU	10	; enable DSKSYNC register matching
ADKB_MSBSYNC		EQU	9	; (Apple GCR Only) sync on MSB for reading
ADKB_FAST		EQU	8	; 1 -> 2 us/bit (mfm), 2 -> 4 us/bit (gcr)
ADKB_USE3PN		EQU	7	; use aud chan 3 to modulate period of ??
ADKB_USE2P3		EQU	6	; use aud chan 2 to modulate period of 3
ADKB_USE1P2		EQU	5	; use aud chan 1 to modulate period of 2
ADKB_USE0P1		EQU	4	; use aud chan 0 to modulate period of 1
ADKB_USE3VN		EQU	3	; use aud chan 3 to modulate volume of ??
ADKB_USE2V3		EQU	2	; use aud chan 2 to modulate volume of 3
ADKB_USE1V2		EQU	1	; use aud chan 1 to modulate volume of 2
ADKB_USE0V1		EQU	0	; use aud chan 0 to modulate volume of 1

ADKF_SETCLR		EQU	(1<<15)
ADKF_PRECOMP1		EQU	(1<<14)
ADKF_PRECOMP0		EQU	(1<<13)
ADKF_MFMPREC		EQU	(1<<12)
ADKF_UARTBRK		EQU	(1<<11)
ADKF_WORDSYNC		EQU	(1<<10)
ADKF_MSBSYNC		EQU	(1<<9)
ADKF_FAST		EQU	(1<<8)
ADKF_USE3PN		EQU	(1<<7)
ADKF_USE2P3		EQU	(1<<6)
ADKF_USE1P2		EQU	(1<<5)
ADKF_USE0P1		EQU	(1<<4)
ADKF_USE3VN		EQU	(1<<3)
ADKF_USE2V3		EQU	(1<<2)
ADKF_USE1V2		EQU	(1<<1)
ADKF_USE0V1		EQU	(1<<0)

ADKF_PRE000NS		EQU	0				; 000 ns of precomp
ADKF_PRE140NS		EQU	(ADKF_PRECOMP0)			; 140 ns of precomp
ADKF_PRE280NS		EQU	(ADKF_PRECOMP1)			; 280 ns of precomp
ADKF_PRE560NS		EQU	(ADKF_PRECOMP0!ADKF_PRECOMP1)	; 560 ns of precomp

	ENDC
