;EasyCodeName=Editor,1
.Const

__Editor_Addrs DD InternalName_1, InternalName_2, InternalName_3, InternalName_4, InternalName_5
	DD InternalName_6, InternalName_7, InternalName_8, InternalName_9
	DD HotKeySwitcher_1, ShowUnitInfo_1
	DD HiddenUnit_1, HiddenUnit2_1, HiddenUnit3_1
	DD TerrainName_1, TerrainName_2, TerrainName_3, TerrainName2_1, TerrainName2_2, TerrainName2_3
	DD TrainName_1
	DD 0 ;1, Offset __CustomSLP_Addrs

__Editor_Addrs2 DD HiddenUnit_01, HiddenUnit_02, HiddenUnit2_01, HiddenUnit2_02
	DD HiddenUnit3_01, HiddenUnit3_02, TerrainName_01, TerrainName2_01
	DD 0

__Editor_Dircts DD 004F1F82H, HotKeySwitch, 0
	DD 004F1F89H, HotKeySwitch2, 0
	DD 0 ;1, Offset __CustomSLP_Dircts

__Editor_Jmps DD 004E0E81H, Offset InternalName1
	DD 004E0F21H, Offset InternalName2
	DD 004E102FH, Offset InternalName3
	DD 004E10EDH, Offset InternalName4
	DD 004E119BH, Offset InternalName5
	DD 004E1230H, Offset InternalName6
	DD 004E12CCH, Offset InternalName7
	DD 004E1399H, Offset InternalName8
	DD 004E141FH, Offset InternalName9
	DD 004E0AAFH, Offset HiddenUnit
	DD 004E0D8FH, Offset HiddenUnit2
	DD 004E5025H, Offset HiddenUnit3
	;DD 007E25AFH, Offset TrainName
	;DD 007BB122H, TerrainName
	;DD 007BB038H, TerrainName2
	DD 0 ;1, Offset __CustomSLP_Jmps


.Code

; 004E0E84h
; ecx-player, arg1-protounit id, arg2-lang pointer; eax-buffer ptr
InternalNameFormat:
	Push Ebp
	Push Ebx
	Push Edi
	Push Esi

	Mov Ebp, DWord Ptr Ss:[Esp + 14H]
	Mov Edx, DWord Ptr Ds:[Ecx + 74H]
	Mov Eax, DWord Ptr Ds:[Ebp * 4 + Edx]
	Mov Edi, DWord Ptr Ds:[Eax + 8H]
	Mov Esi, DWord Ptr Ss:[Esp + 18H]
	Cmp Byte Ptr Ds:[Esi], 0
.If Zero?
	Invoke wsprintf, Addr Buffer, Addr IntNamePattern2, Edi, Ebp
.Else
	Invoke wsprintf, Addr Buffer, Addr IntNamePattern, Esi, Edi, Ebp
.EndIf
	Mov Eax, Offset Buffer

	Pop Esi
	Pop Edi
	Pop Ebx
	Pop Ebp
	Retn 8H

InternalName1: ; Units
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_1:
	FakeJmp 004E0E9CH

InternalName2: ; Units 2
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_2:
	FakeJmp 004E0F3CH

InternalName3: ; Buildings no-dll
	Test Dx, Dx
	Jle InternalName3_None
	Mov Ecx, DWord Ptr Ds:[7912A0H]
	Push 64H
	Push Eax
	Movsx Eax, Dx
	Push Eax
	Mov Edi, DWord Ptr Ds:[Ecx]
	Push 2
	Call DWord Ptr Ds:[Edi + 20H]
InternalName3_None:
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Eax
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_3:
	FakeJmp 004E106EH

InternalName4: ; Heroes
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_4:
	FakeJmp 004E1108H

InternalName5: ; Buildings
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_5:
	FakeJmp 004E11B6H

InternalName6: ; Heroes
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_6:
	FakeJmp 004E124BH

InternalName7: ; Heroes
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_7:
	FakeJmp 004E12E3H

InternalName8: ; Heroes
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Esi
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_8:
	FakeJmp 004E13B4H

InternalName9: ; Heroes
	Mov Ecx, DWord Ptr Ss:[Esp + 24H]
	Push Ebx
	Push Ebp
	Call InternalNameFormat
	Mov Edi, Eax
	Xor Eax, Eax
	Or Ecx, 0FFFFFFFFH
InternalName_9:
	FakeJmp 004E1436H


Align 4
HotKeySwitch: ; Function Table
	DB 00H, 01H, 02H, 03H, 0FH, 0FH, 0FH, 10H, 10H, 0FH, 0FH, 0FH, 04H, 0FH, 05H, 06H ; A~P
	DB 0FH, 07H, 01H, 08H, 09H, 0AH, 0BH, 0CH, 0DH, 0EH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH ; Q~Z,[\]^_`
	DB 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH ; a~p
	DB 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0FH, 0CH, 0DH, 0EH

Align 4
HotKeySwitch2:
	DD 004F1F8DH, 004F20EAH, 004F20AAH, 004F202AH
	DD 004F1FAAH, 004F206AH, 004F1FEAH, 004F20CAH
	DD 004F1FCAH, 004F200AH, 004F204AH, 004F208AH
	DD 004F2135H, 004F2179H, 004F2157H, 004F2331H
	DD Offset HotKeySwitcher

HotKeySwitcher:
.If Eax == 'I' - 'A'  ; Ctrl+I show unit info
	Call ShowUnitInfo
	Xor Eax, Eax
	Pop Edi
	Pop Esi
	Retn 14H
.ElseIf Eax == 'H' - 'A'  ; Ctrl+H toggle hidden units display
	Mov Eax, DWord Ptr Ds:[HotKeySwitchFlag]
	Xor Al, 2H
	Xor Edi, Edi
	Mov DWord Ptr Ds:[HotKeySwitchFlag], Eax
.EndIf
	Mov Ecx, DWord Ptr Ds:[Plc]
	Push Edi
	Push Edi
	Inc Edi
	Push Edi
HotKeySwitcher_1:
	FakeCall 005EB990H
	Mov Eax, Edi
	Pop Edi
	Pop Esi
	Retn 14H

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

_GetUnitGraphic Macro _Offset, _MinType, _ROffset
	Mov Ecx, Esi
	Push _ROffset
	Push _MinType
	Push _Offset
	Call GetUnitGraphic
	Push Eax
EndM

ShowUnitInfo:
	Push Ebp
	Push Ebx
	Mov Ebp, DWord Ptr Ds:[Plc]
	Mov Ecx, Ebp
ShowUnitInfo_1:
	FakeCall 005E7560H
	Mov Esi, Eax
	Movsx Eax, Word Ptr Ds:[Ebp + 42CH] ; Current Protounit
	Test Eax, Eax
	Jge ShowUnitInfo_Do
	Mov Esi, DWord Ptr Ds:[Esi + 1C0H] ; If a living unit is selected
	Test Esi, Esi
	Je ShowUnitInfo_Skip
	Mov Esi, DWord Ptr Ds:[Esi + 8H]
	Movsx Eax, Word Ptr Ds:[Esi + 10H]
	Jmp ShowUnitInfo_BySelect
ShowUnitInfo_Do:
	Mov Ecx, Esi
.If Eax < DWord Ptr Ds:[Ecx + 70H]
	Mov Edi, DWord Ptr Ds:[Ecx + 74H]
	Mov Esi, DWord Ptr Ds:[Edi + Eax * 4]
ShowUnitInfo_BySelect:
	Sub Esp, 200H
	Lea Ebx, [Esp + 180H]
	Invoke wsprintf, Ebx, Addr IntNamePattern2, DWord Ptr Ds:[Esi + 8H], Eax
	Mov Ebx, Esp

	Movsx Ecx, Word Ptr Ds:[Esi + 50H]
	Movsx Eax, Word Ptr Ds:[Esi + 6EH]
	Push Ecx
	Push Eax

	_GetUnitGraphic 1BCH, 80, 0CH
	_GetUnitGraphic 044H, 10, 0CH
	_GetUnitGraphic 114H, 60, 0CH
	_GetUnitGraphic 118H, 60, 0CH
	_GetUnitGraphic 040H, 10, 0CH

	_GetUnitGraphic 1C4H, 80, 72H
	_GetUnitGraphic 1C0H, 80, 72H
	_GetUnitGraphic 1B8H, 70, 72H

	_GetUnitGraphic 120H, 60, 72H
	_GetUnitGraphic 0D0H, 30, 72H
	_GetUnitGraphic 0CCH, 30, 72H
	_GetUnitGraphic 024H, 10, 72H
	_GetUnitGraphic 020H, 10, 72H
	_GetUnitGraphic 01CH, 10, 72H
	_GetUnitGraphic 018H, 10, 72H
	Movsx Edx, Word Ptr Ds:[Esi + 54H]
	Push Edx
	Movsx Edx, Word Ptr Ds:[Esi + 0CH]
	Movsx Ecx, Word Ptr Ds:[Esi + 16H]
	Push Edx
	Push Ecx
	Invoke wsprintf, Ebx, Addr UnitInfoPattern
	Add Esp, 4 * 20
	Lea Edi, [Esp + 180H]
	Invoke GetActiveWindow
	Invoke MessageBox, Eax, Ebx, Edi, MB_ICONINFORMATION
	Add Esp, 200H
.EndIf
ShowUnitInfo_Skip:
	Pop Ebx
	Pop Ebp
	Ret

GetUnitGraphic: ; ecx=protounit, arg1=offset, arg2=unit min type, arg3=resource offset
	Push Esi
	Push Edi
	Push Ebx
	Mov Esi, Ecx
	Or Eax, -1
	Mov Bl, Byte Ptr Ss:[Esp + 14H]
.If Bl <= Byte Ptr Ds:[Esi + 4H]
	Mov Edi, DWord Ptr Ss:[Esp + 10H]
	Mov Edi, DWord Ptr Ds:[Esi + Edi]
	Test Edi, Edi
	.If !Zero?
		Add Edi, DWord Ptr Ss:[Esp + 18H]
 		Movsx Eax, Word Ptr Ds:[Edi]
 	.EndIf
 .EndIf
 	Pop Ebx
	Pop Edi
	Pop Esi
	Retn 0CH


TerrainName: ; 007BB122h
	Cmp Ebx, 16
	Je TerrainName_Custom1
	Cmp Ebx, 26
	Je TerrainName_Custom2
	Cmp Ebx, 27
	Je TerrainName_Custom3
	Cmp Ecx, 3
TerrainName_01:
	FakeJe 007BB145H
TerrainName_1:
	FakeJmp 007BB127H

TerrainName_Custom1: ; Acacia Forest
	Mov Eax, Offset TerrNameAcacia
	Jmp TerrainName_Custom
TerrainName_Custom2: ; Lava
	Mov Eax, Offset TerrNameLava
	Jmp TerrainName_Custom
TerrainName_Custom3: ; Baobab Forest
	Mov Eax, Offset TerrNameBaobab
TerrainName_Custom:
	Push 0
	Push Ebx
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Esi + 9F4H]
TerrainName_2:
	FakeCall 005473A0H ; Create By Instant String
TerrainName_3:
	FakeJmp 007BB1D1H

TerrainName2: ; 007BB038h
	Cmp Ebx, 16
	Je TerrainName2_Custom1
	Cmp Ebx, 26
	Je TerrainName2_Custom2
	Cmp Ebx, 27
	Je TerrainName2_Custom3
	Test Dl, Dl
TerrainName2_01:
	FakeJne 007BB0BFH
TerrainName2_1:
	FakeJmp 007BB03EH

TerrainName2_Custom1: ; Acacia Forest
	Mov Eax, Offset TerrNameAcacia
	Jmp TerrainName2_Custom
TerrainName2_Custom2: ; Lava
	Mov Eax, Offset TerrNameLava
	Jmp TerrainName2_Custom
TerrainName2_Custom3: ; Baobab Forest
	Mov Eax, Offset TerrNameBaobab
TerrainName2_Custom:
	Push Ebx
	Push Eax
	Mov Ecx, DWord Ptr Ss:[Ebp]
TerrainName2_2:
	FakeCall 00550840H ; Create By Instant String
TerrainName2_3:
	FakeJmp 007BB0C9H


; Makes Unnamed units shown by their internal name on train buttons
; Pattern: Create Object <Unit Name>
TrainName: ; 007E25AFH
	Sub Esp, 200H

	Lea Edx, [Esp]
	Push 100H
	Push Edx
	Movzx Eax, Word Ptr Ds:[Edi + 0CH] ; EDI is always to be protounit, though this is just a hack.
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Plc]
	Mov Eax, DWord Ptr Ds:[Ecx]
	Call DWord Ptr Ds:[Eax + 28H] ; Get Unit Name
	Mov Al, Byte Ptr Ss:[Esp]
	Test Al, Al
.If Zero?
	Mov Eax, DWord Ptr Ds:[Edi + 8H]
.Else
	Lea Eax, [Esp]
.EndIf
	Push Eax

	Mov Ecx, DWord Ptr Ds:[Plc]
	Lea Edx, [Esp + 104H]
	Mov Eax, DWord Ptr Ds:[Ecx]
	Push 100H
	Push Edx
	Push 2941H
	Call DWord Ptr Ds:[Eax + 28H] ; Get "Create Unit"

	Pop Eax
	Lea Edx, [Esp + 100H]
	Lea Ecx, [Esp + 0A08H + 200H]
	Invoke wsprintf, Ecx, 0066FB30H, Edx, Eax ; "%s %s"

	;Mov Ecx, DWord Ptr Ds:[7912A0H]
	;Lea Edx, [Esp + 0A08H]
	;Mov Eax, DWord Ptr Ds:[Ecx]
	;Push 200H
	;Push Edx
	;Push 2941H
	;Call DWord Ptr Ds:[Eax + 28H]
	Add Esp, 200H
TrainName_1:
	FakeJmp 007E25CCH
