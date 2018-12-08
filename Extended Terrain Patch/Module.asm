;EasyCodeName=Module,1
; =================================================
; Extended Terrains Mod's Gizmo Module
; By WAIFor, 2018
; This is used to load and control new terrains.
; =================================================

.Const

; ==== Interfaces ====
; Allowing Gizmo.dll to apply them. Each part ends of a NULL(0) value.
; NOTE: If you don't change some of them, you can remove them both in ASM and DEF files.

; Patches To Write
; Address:DWord, Address Of Patch:DWord, Length:DWord
__Patches DD 00583A86H, Offset TerrainsLoad, 4
		DD 00583A8BH, Offset TerrainsCount, 4
		;DD 00584E1CH, Offset TerrainsLoad, 4
		DD 0057F087H, Offset SkipBorders, 2
		DD 00584E1CH, Offset TerrainsCount, 1 ; Generate Trees
		DD 0

; Address List To Change (Offset 1, For FakeJmp and FakeCall)
__Addresses DD SetCollisionType_1, ExtendTerrain1_1, ExtendTerrain2_1, BuildRestriction_1
		DD ExtraItems, ExtraItems_1, ExtraItems_2, ExtraItems2, ExtraItems2_1, ExtraItems2_2
		DD ExtendFoundations_1, GenerateTrees_1
		DD GetTerrainName_1, GetTerrainName_2, GetTerrainName_3, GetTerrainName_4, GetTerrainName_5
		DD 0

; Address List To Change (Offset 2, For Fake Conditional Jumps)
__Addresses2 DD ExtendFoundations_01, GenerateTrees_01
		DD 0

; Address List To Write Direct Address (e.g. Jmp [eax * 4 + Address])
; Address:DWord, Address To Write:DWord, Offset:DWord
__DirectAddresses DD 0
		;DD 0

; Address List To Jump From EXE to DLL
; Jump From:DWord, Jump To:Dword
__Jumps DD 005634DBH, SetCollisionType
		DD 00589D35H, BuildRestriction
		DD 004E1727H, ExtraItems
		DD 007BB0E4H, ExtraItems2
		DD 004CC323H, ExtendFoundations
		DD 0058523DH, GenerateTrees
		;DD 005710CEH, ExtendTerrain1 ; Those two patches needn't activate now
		;DD 005710E8H, ExtendTerrain2
		DD 0


.Data?

StringBuffer DB 256 Dup(?)


.Data

C_Gras Equ 0
C_Bech Equ 2
C_Shlw Equ 4
C_Dirt Equ 6
C_Farm Equ 7
C_Road Equ 24

; Define new terrains count and memory size to allocate
ExtensionCount Equ 25
ExtensionSize Equ 467CH + 1B4H * ExtensionCount

; What old terrains do new terrains inherit.
; Building restriction, trail graphic and collision type of each old terrain will be applied.
; Terrain #41 is also included in inherit table.
InheritTable DB 15, C_Bech, C_Bech, C_Bech, C_Dirt, 5, C_Gras, C_Dirt, C_Gras, C_Dirt, C_Dirt
			 DB C_Shlw, C_Shlw, C_Shlw, C_Road, C_Road, C_Road, C_Shlw, C_Shlw, C_Shlw, C_Shlw
			 DB 32, 22, 1, 13, 17
; Terrain names
; Each of them is dword sized, see GetTerrainName for detailed rules.
;TerrainNames DD Offset Name42, Offset Name43, Offset Name44, Offset Name45, Offset Name46
;			 DD Offset Name47, Offset Name48, Offset Name49, Offset Name50, Offset Name51
;			 DD Offset Name52, Offset Name53, Offset Name54, Offset Name55, Offset Name56
;			 DD Offset Name57, Offset Name58, Offset Name59, Offset Name60, Offset Name61
;			 DD Offset Name62, Offset Name63, Offset Name64, Offset Name65, Offset Name66
TerrainNames DW 10647, 5718, 10647, 102H, 10647, 103H, 10642, 10777, 10650, 102H
			 DW 10641, 10777, 10622, 10777, 10640, 10777, 10622, 5259, 10648, 102H
			 DW 10431, 106H, 10431, 107H, 10431, 108H, 10622, 10638, 10645, 10648
			 DW 10645, 5718, 10431, 10647, 5407, 10647, 10627, 102H, 10627, 5718
			 DW 10650, 10666, 10629, 10777, 10624, 10777
			 DD Offset Name65, Offset Name66

; Instant string names. Not all of them are used.
Name42 DB 'Beach (Grass)', 0
Name43 DB 'Beach 2', 0
Name44 DB 'Beach 2 (Grass)', 0
Name45 DB 'Dirt 4', 0
Name46 DB 'Leaves 2', 0
Name47 DB 'Grass 4', 0
Name48 DB 'Dirt 5', 0
Name49 DB 'Grass 5', 0
Name50 DB 'Cracked Dirt', 0
Name51 DB 'Desert 2', 0
Name52 DB 'Water Farm 2', 0
Name53 DB 'Water Farm 3', 0
Name54 DB 'Water Farm 4', 0
Name55 DB 'Dark Dirt', 0
Name56 DB 'Road (Desert)', 0
Name57 DB 'Road (Grass)', 0
Name58 DB 'Water Farm', 0
Name59 DB 'Water Farm Abandoned', 0
Name60 DB 'Shallow 2', 0
Name61 DB 'Shallow (Tree)', 0
Name62 DB 'Leaves (Snow)', 0
Name63 DB 'Water 4', 0
Name64 DB 'Water 5', 0
Name65 DB 'Baobab Forest', 0
Name66 DB 'Acacia Forest', 0

; Some Patches
SkipBorders   DB 0EBH, 06H
TerrainsCount DD 42 + ExtensionCount
TerrainsLoad  DD ExtensionSize


.Code

; Entry, can't be ignored
; However, you can write more commands here
DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	Mov Eax, TRUE
	Ret
DllEntryPoint EndP

; cl = old id, al = new id
GetNewId:
	Mov Al, Cl
	Sub Cl, 41
	Jl GetNewId_Skip
	Cmp Cl, ExtensionCount
	Ja GetNewId_Skip
	Movzx Ecx, Cl
	Mov Al, Byte Ptr Ds:[Offset InheritTable + Ecx]
GetNewId_Skip:
	Retn

; Set collision types when game starts or savegame loaded.
; In game, there are 3 collision types for each tarrain:
; 01-water(boats only), 02-shallow(both), 04-land(land units only)
SetCollisionType: ;005634DBH
	Mov Dl, Byte Ptr Ds:[Edi]
	Push Ecx
	Push Eax
	Mov Cl, Dl
	Call GetNewId
	Mov Dl, Al
; Hack: Change actual terrain to inherited ones, so that
; new terrains are only different in visual.
	Mov Byte Ptr Ds:[Edi + 1AH], Al
	Pop Eax
	Pop Ecx
	Add Edi, 20H
SetCollisionType_1:
	FakeJmp 005634E0H


; Change building restriction reference
; Within hack, this is only used in scenario editor.
BuildRestriction: ;00589D35h
	Shl Esi, 5
	Mov Dl, Byte Ptr Ds:[Esi + Eax + 1FH]
	Push Ecx
	Mov Cl, Dl
	Call GetNewId
	Mov Dl, Al
	Pop Ecx
BuildRestriction_1:
	FakeJmp 00589D3CH

ExtendFoundations: ;004CC323H
	Push Ecx
	Mov Cl, Al
	Call GetNewId
	Pop Ecx
ExtendFoundations_Skip:
	Cmp Bl, 1BH
ExtendFoundations_01:
	FakeJe 004CC32EH
ExtendFoundations_1:
	FakeJmp 004CC328H


; Create extra terrain items in map editor.
; Get terrain name procedure
; arguments: ecx - static var, arg1 - address
;    return: eax - result
; Resultis determined by most significant byte ([arg1+3])
; If MSB is 00H, returns instant string. (A dll file won't be too large)
; If MSB is 01H, returns a pattern "Terrain N", Terrain is dll string of low word,
; and N is a number by the third byte.
; If most significant word is 0100H, returns dll string pointed by LSW.
; Otherwise, returns "Terrain (Type)", both are strings in dll.
GetTerrainName:
	Push Esi
	Push Ebp
	Mov Esi, DWord Ptr Ss:[Esp + 0CH]
	Mov Ebp, Ecx
	Mov Ax, Word Ptr Ds:[Esi + 2]
	Test Ah, Ah
.If Zero?
	Mov Eax, DWord Ptr Ds:[Esi]
	Pop Ebp
	Pop Esi
	Retn 4
.EndIf
	Cmp Ax, 0100H
	Je GetTerrainName_Single
	Sub Esp, 100H
	Cmp Ah, 1
.If Zero? ; "Terrain N"
	Mov Edx, Esp
	Movzx Eax, Word Ptr Ds:[Esi]
	Push 100H
	Push Eax
	Push Edx
	Mov Ecx, Ebp
GetTerrainName_1:
	FakeCall 004EDC90H
	Mov Eax, Esp
	Movzx Ecx, Byte Ptr Ds:[Esi + 2]
	Push Ecx
	Push Eax
	Push 006784DCH ; "%s %d"

.Else ; "Terrain (Type)"
	Mov Edx, Esp
	Movzx Eax, Word Ptr Ds:[Esi]
	Push 80H
	Push Eax
	Push Edx
	Mov Ecx, Ebp
GetTerrainName_2:
	FakeCall 004EDC90H
	Lea Edx, [Esp + 80H]
	Movzx Eax, Word Ptr Ds:[Esi + 2]
	Push 80H
	Push Eax
	Push Edx
	Mov Ecx, Ebp
GetTerrainName_3:
	FakeCall 004EDC90H
	Lea Edx, [Esp + 80H]
	Mov Eax, Esp
	Push Edx
	Push Eax
	Push 00679C38H ; "%s (%s)"
.EndIf
	Push Offset StringBuffer
GetTerrainName_4:
	FakeCall 0061442BH
	Add Esp, 10H
	Mov Eax, Offset StringBuffer
	Add Esp, 100H
	Pop Ebp
	Pop Esi
	Retn 4

GetTerrainName_Single: ; "Terrain"
	Movzx Eax, Word Ptr Ds:[Esi]
	Push 100H
	Push Eax
	Push Offset StringBuffer
	Mov Ecx, Ebp
GetTerrainName_5:
	FakeCall 004EDC90H
	Mov Eax, Offset StringBuffer
	Pop Ebp
	Pop Esi
	Retn 4


ExtraItems: ;004E1727H
	FakeCall 005472B0H
	Mov Edi, Offset TerrainNames
	Xor Ebp, Ebp
.Repeat
	Mov Ecx, Esi
	Push Edi
	Call GetTerrainName
	Lea Edx, [Ebp + 42]
	Push 0
	Push Edx
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Esi + 9F4H]
ExtraItems_1:
	FakeCall 005473A0H ; Create By Instant String
	Add Edi, 4
	Inc Ebp
	Cmp Ebp, ExtensionCount
.Until Zero?
ExtraItems_2:
	FakeJmp 004E172CH


; Create extra terrain items in map editor.
; You can change jump positions from 007BB0E4H/004EEBB4H to 004EEBAFH/007BB000H
ExtraItems2: ;007BB0E4H
	FakeCall 00550740H
	Push Edi
	Mov Edi, Offset TerrainNames
	Xor Ebx, Ebx
.Repeat
	Mov Ecx, Esi
	Push Edi
	Call GetTerrainName
	Lea Edx, [Ebx + 42]
	Push Edx
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Ebp]
ExtraItems2_1:
	FakeCall 00550840H ; Create By Instant String
	Add Edi, 4
	Inc Ebx
	Cmp Ebx, ExtensionCount
.Until Zero?
	Pop Edi
; Note: it is not recommended to jump from or to userpatch BETA patch segment.
ExtraItems2_2:
	FakeJmp 004EEBB4H
	;FakeJmp 007BB000H

; Generate units on new terrain
GenerateTrees: ; 0058523DH
	Cmp Cx, Word Ptr Ds:[TerrainsCount]
	Mov Word Ptr Ss:[Esp + 6H], Cx
GenerateTrees_01:
	FakeJae 00585413H
GenerateTrees_1:
	FakeJmp 0058524FH

; Unknown Patches
; Might be related with Terrain restriction animations
; Within hack, those are useless. So we won't enable them.
ExtendTerrain1: ;005710CEH
	Mov Al, Byte Ptr Ds:[Eax + 1FH]
	Movsx Ecx, Cx
	Push Ecx
	Mov Cl, Al
	Call GetNewId
	Pop Ecx
ExtendTerrain1_1:
	FakeJmp 005710D4H

ExtendTerrain2: ;005710E8H
	Mov Cl, Byte Ptr Ds:[Ebx + 1FH]
	Push Eax
	Call GetNewId
	Mov Al, Cl
	Pop Eax
ExtendTerrain2_1:
	FakeJmp 005710F0H


End DllEntryPoint
