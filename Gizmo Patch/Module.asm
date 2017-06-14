;EasyCodeName=Module,1
.Const

; ==== Interfaces ====
; Allowing Gizmo.dll to apply them. Each part ends of a NULL(0) value.
; NOTE: If you don't change some of them, you can remove them both in ASM and DEF files.

; Patches To Write
; Address:DWord, Address Of Patch:DWord, Length:DWord
__Patches DD 0

; Address List To Change (Offset 1, For FakeJmp and FakeCall)
__Addresses DD Offset HotKeySwitch_CasualTerrain_1, Offset HotKeySwitch_HiddenUnit_1, Offset HotKeySwitch_InternalName_1
		DD Offset CasualTerrainB_1, Offset CasualTerrainB2_1, Offset CasualTerrainB2_2, Offset CasualTerrainB3_1
		DD Offset HiddenUnit_1, Offset HiddenUnit2_1, Offset HiddenUnit3_1
		DD Offset InternalName_1
		DD 0

; Address List To Change (Offset 2, For Fake Conditional Jumps)
__Addresses2 DD Offset CasualTerrainB_01, Offset CasualTerrainB2_01, Offset CasualTerrainB3_01, Offset CasualTerrainB3_02
		DD Offset HiddenUnit_01, Offset HiddenUnit_02, Offset HiddenUnit2_01, Offset HiddenUnit2_02, Offset HiddenUnit3_01, Offset HiddenUnit3_02
		DD Offset InternalName_01, Offset InternalName_02
		DD 0

; Address List To Write Direct Address (e.g. Jmp [eax * 4 + Address])
; Address:DWord, Address To Write:DWord, Offset:DWord
__DirectAddresses DD 004F1F82H, Offset HotKeySwitch, 0
		DD 004F1F89H, Offset HotKeySwitch2, 0
		DD 0

; Address List To Jump From EXE to DLL
; Jump From:DWord, Jump To:Dword
__Jumps DD 00461A86H, Offset CasualTerrainB
		DD 00461444H, Offset CasualTerrainB2
		DD 0045F980H, Offset CasualTerrainB3
		DD 004E0AAFH, Offset HiddenUnit
		DD 004E0D8FH, Offset HiddenUnit2
		DD 004E5025H, Offset HiddenUnit3
		DD 004E1056H, Offset InternalName
		DD 0


.Data?

.Data

HotKeySwitchFlag DD 0

.Code

; Entry, can't be ignored
; However, you can write more commands here
DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	Mov Eax, TRUE
	Ret
DllEntryPoint EndP


Align 4
HotKeySwitch: ; Function Table
	DB 00H, 0FH, 02H, 03H, 0FH, 0FH, 0FH, 11H, 0FH, 12H, 0FH, 0FH, 04H, 0FH, 05H, 06H ; A~P
	DB 10H, 07H, 01H, 08H, 09H, 0AH, 0BH, 0CH, 0DH, 0EH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH ; Q~Z,[\]^_`
	DB 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH ; a~p
	DB 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0CH, 0DH, 0EH ; q~z

Align 4
HotKeySwitch2:
	DD 004F1F8DH, 004F20EAH, 004F20AAH, 004F202AH
	DD 004F1FAAH, 004F206AH, 004F1FEAH, 004F20CAH
	DD 004F1FCAH, 004F200AH, 004F204AH, 004F208AH
	DD 004F2135H, 004F2179H, 004F2157H, 004F2331H
	DD Offset HotKeySwitch_CasualTerrain, Offset HotKeySwitch_HiddenUnit, Offset HotKeySwitch_InternalName, 0H

;Align 4
;HotKeySwitch_Flag:
;	DD 0H

HotKeySwitch_CasualTerrain: ; Ctrl+Q
	Mov Eax, DWord Ptr Ds:[HotKeySwitchFlag]
	Xor Al, 1H
	Xor Edi, Edi
;HotKeySwitch_CasualTerrain_Attr:
	Mov DWord Ptr Ds:[HotKeySwitchFlag], Eax
	Mov Ecx, DWord Ptr Ds:[Plc]
	Push Edi
	Push Edi
	Inc Edi
	Push Edi
HotKeySwitch_CasualTerrain_1:
	FakeCall 005EB990H
	Mov Eax, Edi
	Pop Edi
	Pop Esi
	Retn 14H

HotKeySwitch_HiddenUnit: ; Ctrl+H
	Mov Eax, DWord Ptr Ds:[HotKeySwitchFlag]
	Xor Al, 2H
	Xor Edi, Edi
;HotKeySwitch_CasualTerrain_Attr:
	Mov DWord Ptr Ds:[HotKeySwitchFlag], Eax
	Mov Ecx, DWord Ptr Ds:[Plc]
	Push Edi
	Push Edi
	Inc Edi
	Push Edi
HotKeySwitch_HiddenUnit_1:
	FakeCall 005EB990H
	Mov Eax, Edi
	Pop Edi
	Pop Esi
	Retn 14H

HotKeySwitch_InternalName: ; Ctrl+J
	Mov Eax, DWord Ptr Ds:[HotKeySwitchFlag]
	Xor Al, 4H
	Xor Edi, Edi
;HotKeySwitch_CasualTerrain_Attr:
	Mov DWord Ptr Ds:[HotKeySwitchFlag], Eax
	Mov Ecx, DWord Ptr Ds:[Plc]
	Push Edi
	Push Edi
	Inc Edi
	Push Edi
HotKeySwitch_InternalName_1:
	FakeCall 005EB990H
	Mov Eax, Edi
	Pop Edi
	Pop Esi
	Retn 14H


CasualTerrainB: ; 00461A86H
	Mov Ecx, DWord Ptr Ss:[Esp + 58H]
	Test DWord Ptr Ds:[HotKeySwitchFlag], 01H
CasualTerrainB_01:
	FakeJne 00461A96H
	Push Eax
CasualTerrainB_1:
	FakeJmp 00461A8BH

CasualTerrainB2: ; 00461444H
	Test DWord Ptr Ds:[HotKeySwitchFlag], 01H
CasualTerrainB2_01:
	FakeJne 00461471H
	Push Edx
CasualTerrainB2_1:
	FakeCall 00460BE0H
CasualTerrainB2_2:
	FakeJmp 0046144AH

CasualTerrainB3: ; 0045F980H
	Mov Eax, DWord Ptr Ss:[Esp + 1CH]
CasualTerrainB3_01:
	FakeJe 0045F9D7H
	Test DWord Ptr Ds:[HotKeySwitchFlag], 01H
CasualTerrainB3_02:
	FakeJne 0045F9D7H
CasualTerrainB3_1:
	FakeJmp 0045F986H


HiddenUnit: ; 004E0AAFH
HiddenUnit_01:
	FakeJne 004E0AB5H
	Test DWord Ptr Ds:[HotKeySwitchFlag], 02H
HiddenUnit_02:
	FakeJe 004E0CC0H
HiddenUnit_1:
	FakeJmp 004E0AB5H

HiddenUnit2: ; 004E0D8FH
HiddenUnit2_01:
	FakeJne 004E0D95H
	Test DWord Ptr Ds:[HotKeySwitchFlag], 02H
HiddenUnit2_02:
	FakeJe 004E145DH
HiddenUnit2_1:
	FakeJmp 004E0D95H

HiddenUnit3: ; 004E5025H
	Test DWord Ptr Ds:[HotKeySwitchFlag], 02H
HiddenUnit3_01:
	FakeJe 004E502BH
	Cmp Byte Ptr Ds:[Eax + 56H], 1
HiddenUnit3_02:
	FakeJe 004E5033H
HiddenUnit3_1:
	FakeJmp 004E502BH


InternalName: ; 004E1056h
	Test DWord Ptr Ds:[HotKeySwitchFlag], 04H
InternalName_01:
	FakeJe 004E105CH
	Cmp Byte Ptr Ds:[Esi + Edx], 0
InternalName_02:
	FakeJne 004E108CH
InternalName_1:
	FakeJmp 004E105CH



End DllEntryPoint
