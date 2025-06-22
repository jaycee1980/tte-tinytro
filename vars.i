
FPS			= 50
HOFFBANNER_COL		= 80
HOFFBANNER_ROW		= 32
HOFFBANNER_PLANE_SIZE	= HOFFBANNER_ROW*HOFFBANNER_COL*8
HOFFBANNER_MATRIX_SIZE	= HOFFBANNER_ROW*HOFFBANNER_COL


RAND_MAX		= 80+32

	RSRESET
BanScreen:			rs.l	1
BanMaxtrix:			rs.l	1
BanMaxtrixRender:		rs.l	1
BanCharCount:			rs.w	1
BanActive:			rs.w	1
Ban_SIZEOF:			rs.w	0


	RSRESET
FrameReq:			rs.w	1
FrameActive:			rs.w	1

TitleTimer:			rs.w	1
TitleStatus:			rs.w	1
HoffBannerTitlePos:		rs.l	1
HoffBannerPos:			rs.l	1
HoffBannerPos2:			rs.l	1
HoffBannerTextPtr:		rs.l	1
HoffBannerRow:			rs.w	1
PlanePos:			rs.l	1
TextProgPtr:			rs.l	1
LineCount:			rs.w	1
WaitTime:			rs.w	1
Exit:				rs.w	1

SyncKick:			rs.w	1
SyncSnare:			rs.w	1

Options:			rs.l	1
OptionId:			rs.w	1

TextSpacing:			rs.l	1
Center:				rs.w	1

KeyUp:				rs.b	1
KeyDown:			rs.b	1
KeyEnter:			rs.b	1

HoffBanItems:			rs.b	Ban_SIZEOF*HOFFBANNER_ROW

HoffBannerLineOffests:		rs.w	HOFFBANNER_ROW+2
HoffBannerLineLengths:		rs.w	HOFFBANNER_ROW+2
RandomSeed:			rs.l	1
RandList:			rs.w	RAND_MAX
TickCounter:			rs.w	1
HoffBannerMatrix:		rs.w	HOFFBANNER_MATRIX_SIZE
HoffBannerMatrixRender:		rs.w	HOFFBANNER_MATRIX_SIZE
Vars_SIZEOF:			rs.w	0
