;EasyCodeName=Module,1
; ======================================================
; WAIFor's Amusement Mod 2.0's Patch Source Code
; For UserPatch 20180309 Only
; ======================================================

.Const

; ==== Interfaces ====
; Allowing Gizmo.dll to apply them. Each part ends of a NULL(0) value.
; NOTE: If you don't change some of them, you can remove them both in ASM and DEF files.
; Order: ExTriggers, Editor, CustomSlp, ExTerrains

; Patches To Write
; Address:DWord, Address Of Patch:DWord, Length:DWord
__Patches DD 2, Offset __ExTriggers_Patches
		;DD 2, Offset __Editor_Patches
		;DD 2, Offset __CustomSLP_Patches
		DD 2, Offset __ExTerrains_Patches
		DD 0
		;DD 007BB320H, Offset TerrNameSnow, SizeOf TerrNameSnow
		;DD 007BB344H, Offset TerrNameRock, SizeOf TerrNameRock

; Address List To Change (Offset 1, For FakeJmp and FakeCall)
__Addresses DD Offset PowerShow_1, Offset PowerShow_2, MoreOnMinimap1_1, MoreOnMinimap2_1, MoreOnMinimap3_1
		DD ColoredUnit_1, ColoredUnit2_1, CustomGarrison_1, BuilderSound_1, MoreLang_1, AddUnitZPosition_1
		DD AdvAdjacentMode_1, AdvAdjacentMode_2, AdvAdjacentMode_3
		;DD TerrainCollision_1
		DD 2, Offset __ExTriggers_Addrs
		DD 2, Offset __Editor_Addrs
		DD 2, Offset __CustomSLP_Addrs
		DD 2, Offset __ExTerrains_Addrs
		DD 0

; Address List To Change (Offset 2, For Fake Conditional Jumps)
__Addresses2 DD MoreOnMinimap1_01, MoreOnMinimap2_01, MoreOnMinimap3_01, 004337C5H, CustomGarrison_01
		DD BuilderSound_01, BuilderSound_02, MoreLang_01
		;DD ColoredUnit_01
		DD 2, Offset __ExTriggers_Addrs2
		DD 2, Offset __Editor_Addrs2
		DD 2, Offset __CustomSLP_Addrs2
		DD 2, Offset __ExTerrains_Addrs2
		DD 0

; Address List To Write Direct Address (e.g. Jmp [eax * 4 + Address])
; Address:DWord, Address To Write:DWord, Offset:DWord
__DirectAddresses DD 004337C7H, MoreOnMinimap3, 0
		DD 2, Offset __ExTriggers_Dircts
		DD 2, Offset __Editor_Dircts
		DD 2, Offset __CustomSLP_Dircts
		;DD 2, Offset __ExTerrains_Dircts
		DD 0

; Address List To Jump From EXE to DLL
; Jump From:DWord, Jump To:Dword
__Jumps DD 0044E9AEH, Offset PowerShow
		DD 00432C61H, MoreOnMinimap1
		DD 00432F1EH, MoreOnMinimap2
		DD 005862A9H, ColoredUnit
		DD 004CEDE7H, ColoredUnit2
		DD 0043429FH, CustomGarrison
		DD 00457304H, BuilderSound
		DD 0044DE47H, MoreLang
		DD 00414ADAH, AddUnitZPosition
		DD 004C9E7DH, Offset AdvAdjacentMode
		;DD 005634DBH, TerrainCollision
		;DD 004D4FB5H, Offset CustomAll
		;DD 004E8DE7H, Offset CustomIcon1
		;DD 00516EC0H, Offset CustomIcon2
		DD 2, Offset __ExTriggers_Jmps
		DD 2, Offset __Editor_Jmps
		DD 2, Offset __CustomSLP_Jmps
		DD 2, Offset __ExTerrains_Jmps
		DD 0


Const0001 DD 0.001



.Data?

CustomTagLocation DD ?


.Data

CustomSLPTag DB 'waifor-slp: ', 0
CustomSLPTagPattern DB 'waifor-slp: %60[^"/\', 0DH, 0AH, 9, ']', 0
CutsomSLPPattern DB '%s%s_%s.slp', 0
CustomSlotIconUnit DB 'unit', 0
CustomSlotIconBuild DB 'build', 0
CustomSlotIconTech DB 'tech', 0
TerrNameAcacia DB 'Acacia Forest', 0
TerrNameLava DB 'Lava', 0
TerrNameBaobab DB 'Baobab Forest', 0
TerrNameSnow DW 10666, 3, 0, 2
TerrNameRock DW 5520, 10896

IntNamePattern DB '%s{%s}, %d', 0
IntNamePattern2 DB '%s, %d', 0
UnitInfoPattern DB 'Class:%d, LangId:%d, Icon:%d', 10, 13
	DB 'Stand:%d %d, Dying:%d %d, Walk:%d %d, Attack:%d', 10, 13
	DB 'Garrison:%d, Foundation:%d, Snow:%d', 10, 13
	DB 'Select:%d, Move:%d, Attack:%d, Train:%d, Build:%d', 10, 13
	DB 'Restrict:%d, DeadUnit:%d', 10, 13
	DB 0

Align 4
Buffer DB 256 Dup(0)
HotKeySwitchFlag DD 0


.Code


; Entry, can't be ignored
; However, you can write more commands here
DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	Invoke GetCurrentProcess
	Mov Eax, TRUE
	Ret
DllEntryPoint EndP


; Show Resource quantity in game when resid set to -10 and quantity set to pointing resid
PowerShow:
	Movsx Edi, Word Ptr Ds:[Ebx + 4CH]
.If Edi == -10
	Mov Eax, 9
	Mov DWord Ptr Ss:[Esp + 10H], Eax

	Sub Esp, 4H
	Fld DWord Ptr Ds:[Ebx + 44H]
	Fistp DWord Ptr Ss:[Esp]
	Mov Eax, DWord Ptr Ss:[Esp]
	Add Esp, 4H

	Mov Ecx, DWord Ptr Ds:[Ebx + 0CH]
	Cmp Eax, DWord Ptr Ds:[Ecx + 0A4H]
PowerShow_01:
	FakeJae 0044EAC2H
	Mov Ecx, DWord Ptr Ds:[Ecx + 0A8H]
	Fld DWord Ptr Ds:[Ecx + Eax * 4]
	Mov Edi, 9 ; Set Icon
	Or Eax, 0FFFFFFFFH
PowerShow_2:
	FakeJmp 0044EA13H
.Else
	Cmp Edi, 38H
PowerShow_1:
	FakeJmp 0044E9B5H
.EndIf


; Minimap mode: 11-lined square, 12-X
MoreOnMinimap1: ; 00432C61h - Flare X
	Cmp Byte Ptr Ds:[Edx + 096H], 12
MoreOnMinimap1_01:
	FakeJe 00432C69H
	Cmp Word Ptr Ds:[Edx + 10H], 112H
MoreOnMinimap1_1:
	FakeJmp 00432C67H

MoreOnMinimap2: ; 00432F1Eh - Wonder lined square
	Cmp Byte Ptr Ds:[Eax + 096H], 11
	Mov Eax, 4
MoreOnMinimap2_01:
	FakeJe 00432F2EH
	Cmp Cx, 114H
MoreOnMinimap2_1:
	FakeJmp 00432F23H

MoreOnMinimap3: ; 004337C7h - Wonder Patch 2
	Cmp DWord Ptr Ss:[Esp + 10H], 11
MoreOnMinimap3_01:
	FakeJe 004337D6H
MoreOnMinimap3_1:
	FakeJmp 00433892H


ColoredUnit: ;005862A9H
	Push Ecx
	Mov Ecx, Esi
	Call ColoredUnit_GetColor
	Pop Ecx
ColoredUnit_1:
	FakeJmp 005862AFH

ColoredUnit2: ;004CEDE7H
	Push Ecx
	Mov Ecx, Esi
	Call ColoredUnit_GetColor
	Mov Edx, Eax
	Pop Ecx
ColoredUnit2_1:
	FakeJmp 004CEDEDH


ColoredUnit_GetColor:
	Push Esi
	Push Edi
	Push Ebx
	Push Edx
	Mov Esi, Ecx
	Mov Edi, DWord Ptr Ds:[Esi + 0CH]
	Mov Eax, DWord Ptr Ds:[Esi + 08H]
;	Cmp Byte Ptr Ds:[Eax + 4H], 70 ; Only 70+ Units
;	Jl ColoredUnit_GetColor_Normal
	;Mov Ax, Word Ptr Ds:[Eax + 0EH] ; (Unused)"Language DLL Creation", ColorMask = 0C800H(51200)
	;Cmp Ah, 0C8H - 100H
	Mov Al, Byte Ptr Ds:[Eax + 56H] ; "Hide In Editor", [64,127]
.If Al >= 64
	Sub Al, 64
	Mov Ebx, DWord Ptr Ds:[Edi + 8CH]
	Mov Ecx, DWord Ptr Ds:[Ebx + 78H]
	Movzx Eax, Al
	.If Al == 63
		Mov Al, Byte Ptr Ds:[681A20H] ; Time
		And Al, 7
	.EndIf
	.If Al >= Cl
		Xor Al, Al
	.EndIf
	Mov Esi, DWord Ptr Ds:[Ebx + 7CH]
	Mov Eax, DWord Ptr Ds:[Eax * 4 + Esi]
.Else
;ColoredUnit_GetColor_Normal:
	Mov Eax, DWord Ptr Ds:[Edi + 160H]
.EndIf
	Pop Edx
	Pop Ebx
	Pop Edi
	Pop Esi
	Retn


; Allow garrison by id of task
CustomGarrison: ; 0043429FH, EDX = Shelter, EBP = Unit
	Push Esi
	Push Edi
	Push Ebp
	Push Eax

	Mov Ax, Word Ptr Ds:[Edx + 10H]
	Mov Edi, DWord Ptr Ds:[Ebp + 0FCH]
	Test Edi, Edi
	Je CustomGarrison_Skip
	Mov Esi, DWord Ptr Ds:[Edi + 8H]
	Test Esi, Esi
	Je CustomGarrison_Skip
	Mov Ebp, DWord Ptr Ds:[Edi + 4H]
.Repeat
	Mov Edi, DWord Ptr Ds:[Ebp]
	Cmp Ax, Word Ptr Ds:[Edi + 0AH]
	Je CustomGarrison_Do
	Add Ebp, 4
	Dec Esi
.Until Zero?
CustomGarrison_Skip:
	Pop Eax
	Pop Ebp
	Pop Edi
	Pop Esi
	Cmp Byte Ptr Ds:[Edx + 4H], 50H
CustomGarrison_01:
	FakeJne 004343FCH
CustomGarrison_1:
	FakeJmp 004342A5H

CustomGarrison_Do:
	Add Esp, 10H
	Mov Eax, Edi
	Pop Edi
	Pop Esi
	Pop Ebp
	Pop Ebx
	Add Esp, 18H
	Retn 20H

; Allow Custom Builder Sound (Attack Sound)
BuilderSound: ;00457304h
	Mov Al, Byte Ptr Ds:[Ecx + 110H]
	Cmp Al, 2
BuilderSound_01:
	FakeJe 0045730DH
	Cmp Al, 1
BuilderSound_02:
	FakeJe 0045731EH
	Push Esi
	Mov Edx, DWord Ptr Ds:[Ecx]
	Call DWord Ptr Ds:[Edx + 30H]
BuilderSound_1:
	FakeJmp 0045732DH


; Allow units to have 32768 to 65534 lang ids
MoreLang:  ;0044DE47h
	Mov Ax, Word Ptr Ds:[Edx + 0CH]
	Cmp Ax, -1
MoreLang_01:
	FakeJe 0044DEDDH
MoreLang_1:
	FakeJmp 0044DE54H


AddUnitZPosition: ; 00414ADAh
	Push 1H
	Push 3F800000H
	Push Ecx
AddUnitZPosition_1:
	FakeJmp 00414ADFH


; Make units behave well on #41+ terrains
;TerrainCollision: ; 005634DBH
;	Mov Dl, Byte Ptr Ds:[Edi]
;	Add Edi, 20H
;	Cmp Dl, 41
;	Jl TerrainCollision_Skip
;	Mov Dl, 1 ; 01-water, 02-beach, 04-land
;TerrainCollision_Skip:
;TerrainCollision_1:
;	FakeJmp 005634E0H


; Advanced Adjacent Mode
AdvAdjacentMode: ; @004C9E7DH
	Call DWord Ptr Ds:[Edx + 304H]
	Mov Ecx, DWord Ptr Ds:[Esi + 8H]
	Movzx Eax, Byte Ptr Ds:[Ecx + 1C8H] ; Adj.Mode
	Dec Eax
.If Al >= 2
AdvAdjacentMode_1:
	FakeJmp 004C9E83H
.EndIf
	Jmp DWord Ptr Ds:[Eax * 4 + Offset AdvAdjacentMode_Table]

AdvAdjacentMode_Ortho: ; Like RA2
	Xor Edx, Edx
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Test Eax, Eax
.If !Zero?
	Or Dl, 1
.EndIf
	Mov Eax, DWord Ptr Ss:[Esp + 08H]
	Test Eax, Eax
.If !Zero?
	Or Dl, 2
.EndIf
	Mov Eax, DWord Ptr Ss:[Esp + 0CH]
	Test Eax, Eax
.If !Zero?
	Or Dl, 4
.EndIf
	Mov Eax, DWord Ptr Ss:[Esp + 04H]
	Test Eax, Eax
.If !Zero?
	Or Dl, 8
.EndIf
	Push Edx
	;Mov Ecx, Esi
AdvAdjacentMode_2:
	FakeJmp 004C9F04H
AdvAdjacentMode_3:
	FakeCall 004D3A20H

AdvAdjacentMode_Table:
	DD 004C9E83H, Offset AdvAdjacentMode_Ortho


; NOTE: This is just for syntax correct.
End DllEntryPoint
