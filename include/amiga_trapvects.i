;--------------------------------------------------------------------------------------------------
; amiga_trapvects.i
; Definitions for the 68000 Trap vectors as used on the Amiga
;--------------------------------------------------------------------------------------------------

	IFND	__AMIGA_TRAPVECTS_I
__AMIGA_TRAPVECTS_I	SET	1

tv_ResetSP:			EQU	$0
tv_ResetPC:			EQU	$4
tv_BusError:			EQU	$8
tv_AddressError:		EQU	$C
tv_IllegalInstruction:		EQU	$10
tv_DivideByZero:		EQU	$14
tv_ChkInstruction		EQU	$18
tv_TrapInstruction		EQU	$1C
tv_PrivilegeViolation:		EQU	$20
tv_Trace:			EQU	$24
tv_LineA:			EQU	$28
tv_LineF:			EQU	$2C
tv_SpuriousInt:			EQU	$60
tv_Lev1Int:			EQU	$64
tv_Lev2Int:			EQU	$68
tv_Lev3Int:			EQU	$6C
tv_Lev4Int:			EQU	$70
tv_Lev5Int:			EQU	$74
tv_Lev6Int:			EQU	$78
tv_Lev7Int:			EQU	$7C

tv_Trap0:			EQU	$80
tv_Trap1:			EQU	$84
tv_Trap2:			EQU	$88
tv_Trap3:			EQU	$8C
tv_Trap4:			EQU	$90
tv_Trap5:			EQU	$94
tv_Trap6:			EQU	$98
tv_Trap7:			EQU	$9C
tv_Trap8:			EQU	$A0
tv_Trap9:			EQU	$A4
tv_Trap10:			EQU	$A8
tv_Trap11:			EQU	$AC
tv_Trap12:			EQU	$B0
tv_Trap13:			EQU	$B4
tv_Trap14:			EQU	$B8
tv_Trap15:			EQU	$BC

	ENDC
	