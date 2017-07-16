;EasyCodeName=Module,1
Include	Protounits.asm

.Const

; ==== Interfaces ====
; NOTE: If you don't create either conditions nor effects, you can remove them both in ASM and DEF files.

; Effects
__EffectCount  DD 12
__EffectNames  DD Offset Name1, Offset Name2, Offset Name3, Offset Name4, Offset Name5, Offset Name6
		DD Offset Name7, Offset Name8, Offset Name9, Offset Name10, Offset Name11, Offset Name12
; Inputs:Dword, Necessary Inputs:Dword
__EffectInputs DD INE_TEXT + INE_FROMPLAYER + INE_RESOURCE, 0
		DD INE_RESOURCE + INE_FROMPLAYER + INE_TOPLAYER + INE_QUANTITY + INE_NUMBER + INE_DIPLOMACY, 0
		DD INE_TEXT + INE_FROMPLAYER, 0
		DD INE_TEXT + INE_FROMPLAYER, 0
		DD INE_QUANTITY + INE_PROTOUNIT + INE_UNIT_FILTER + INE_FROMPLAYER + INE_TOPLAYER + INE_NUMBER, 0
		DD INE_QUANTITY + INE_TIMER + INE_PROTOUNIT + INE_TOPLAYER + INE_NUMBER, INE_PROTOUNIT + INE_TOPLAYER
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_NUMBER, 0
		DD INE_TIMER + INE_QUANTITY + INE_NUMBER + INE_TOPLAYER, 0
		DD INE_QUANTITY + INE_PROTOUNIT + INE_FROMPLAYER + INE_AREA + INE_NUMBER, INE_PROTOUNIT + INE_FROMPLAYER + INE_AREA
		DD INE_QUANTITY + INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_NUMBER, 0
		DD INE_TEXT + INE_PROTOUNIT + INE_FROMPLAYER + INE_TARGET, INE_PROTOUNIT + INE_FROMPLAYER + INE_TARGET
		DD INE_TOPLAYER + INE_PROTOUNIT + INE_FROMPLAYER + INE_UNIT_FILTER + INE_NUMBER, 0

__Effects      DD Offset ChoiceBox
		DD Offset ResModifier
		DD Offset SaveResources
		DD Offset LoadResources
		DD Offset SetResourceStorage
		DD Offset Protounit
		DD Offset ModifierSelect
		DD Offset Modifier
		DD Offset CreateUnitsInArea
		DD Offset ChangeObject
		DD Offset WAIForTyper
		DD Offset FocusObject

; Conditions
__ConditionCount  DD 0
__ConditionNames  DD Offset CName1
__ConditionInputs DD INC_FROMPLAYER + INC_QUANTITY, 0
__Conditions      DD Offset Civilization

; Address List To Change (Offset 1, For FakeJmp and FakeCall)
__Addresses    DD Offset ChangeIcon_1, Offset WAIForTyper_1, Offset CreateUnitsInArea_1, Offset CreateUnitsInArea_2
		DD Offset ChangeObject_1, Offset ChangeObject_2, Offset ChangeObject_3, Offset ChangeObject_4
		DD Offset FocusObject_1, Offset FocusObject_2, Offset Modifier_1, 0
; Address List To Change (Offset 2, For Fake Conditional Jumps)
__Addresses2   DD Offset Civilization_01, 0


.Data?

.Data

Name1 DB 'Show Choice Box', 0
Name2 DB 'Resource Modifier', 0
Name3 DB 'Save Resources To File', 0
Name4 DB 'Load Resources From File', 0
Name5 DB 'Set Resource Storage', 0
Name6 DB 'Protounit Modifier', 0
Name7 DB 'Object Modifier Selector', 0
Name8 DB 'Object Modifier', 0
Name9 DB 'Create Units In Area', 0
Name10 DB 'Change/Replace Object', 0
Name11 DB 'WAIFor Unit Typer', 0
Name12 DB 'Focus Object', 0

CName1 DB 'Civilization', 0

ResSavePattern DB '%s%s.res', 0

Align 4
ASCIIPatterns DD 0000000H, 0401084H, 000014AH, 0AFABEAH, 0EA38AEH, 19D1173H, 1F2BCA6H, 0000084H, 0410844H, 0442104H, 04ABAA4H, 0427C84H, 0221000H, 0007C00H, 0020000H, 0111110H
		DD 0E9D72EH, 0E210C4H, 1F1322EH, 0F8320FH, 08FA54CH, 0F83C3FH, 0E8BC2EH, 042221FH, 0E8BA2EH, 0E87A2EH, 0020080H, 0220080H, 18304D8H, 00F83E0H, 0364183H, 040310EH
		DD 0CAF62EH, 11FC544H, 0F8BE2FH, 0E8862EH, 0F94A4FH, 1F0BC3FH, 010BC3FH, 0E8F42EH, 118FE31H, 0E2108EH, 0E8C210H, 1149D31H, 1F08421H, 118D771H, 11CD671H, 0E8C62EH
		DD 010BE2FH, 164D62EH, 114BE2FH, 0F8383EH, 042109FH, 0E8C631H, 0452A31H, 11DD631H, 1151151H, 0421151H, 1F1111FH, 0610846H, 1041041H, 0C4210CH, 0004544H, 1F00000H
		DD 0000104H, 164B906H, 0E93842H, 0C10980H, 0E4B908H, 1C17A4CH, 042789CH, 064392EH, 1293842H, 0E21804H, 0642008H, 1251942H, 0E21086H, 15AD560H, 12949C0H, 0C94980H
		DD 02749C0H, 08725C0H, 0211B40H, 0320980H, 1C27880H, 0E4A520H, 0454A40H, 0AAD6A0H, 0931920H, 0743929H, 0E22380H, 0C2088CH, 0421084H, 0622086H, 0045440H, 1FFFFFFH

TestFloat DD 10.0
TyperDelta DD 0.16666667
TyperSize DD 1.0
Rate360 DD 360.0
Rate1000 DD 1000.0

Align 4
ModifierObjects DD 256 Dup(0)
ModifierObjectCount DD 0


.Code

; Entry, can't be ignored
DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	Mov Eax, TRUE
	Ret
DllEntryPoint EndP


; ==== Effects ====

ChangeIcon:
    Mov Eax, [Esp + 10H]
    Xor Ebp, Ebp
    Cmp Eax, Ebx
    Jle ChangeIcon_back
    Lea Ebx, [Esp + 94H]

ChangeIcon_start:
    Mov Esi, [Ebx]
    Mov Eax, [Esi + 8]
    Cmp Byte Ptr Ds:[Eax + 4], 46H
    Jb ChangeIcon_end
    Mov Ecx, Esi
ChangeIcon_1:
    FakeCall 004C6400H
    Xor Edx, Edx
    Mov Edx, [Edi + 10H]
    Mov Ecx, [Esi + 8]
    Mov Word Ptr Ds:[Ecx + 54H], Dx

ChangeIcon_end:
    Mov Eax, [Esp + 10H]
    Inc Ebp
    Add Ebx, 4
    Cmp Ebp, Eax
    Jl ChangeIcon_start

ChangeIcon_back:
    Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


ChoiceBox:
	Sub Esp, 100H
	Invoke  GetActiveWindow
	Mov Ebp, Eax
	Mov Esi, Esp

	Invoke  GetWindowText, Ebp, Esi, 255
	Mov Edx, DWord Ptr Ds:[Edi + 6CH]
	Invoke  MessageBox, Ebp, Edx, Esi, MB_ICONQUESTION + MB_YESNO
.If Eax == IDYES
	Mov Eax, 1
.Else
	Mov Eax, 0
.EndIf
	Mov [Esp], Eax
	Mov Esi, Ss:[Esp + 118H] ; Source Player
	Mov Ecx, [Edi + 14H] ; Resource Id
.If Ecx < DWord Ptr Ds:[Esi + 0A0H]
	Mov Esi, [Esi + 0A8H]
	Fild DWord Ptr Ds:[Esp]
	Fstp DWord Ptr Ds:[Esi + Ecx * 4]
.EndIf
	Add Esp, 100H
	Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


; Resource Modifier
; 0 - P2.R = X
; 1 - P2.R = P1.R + X
; 2 - P2.R = P1.R * X
; 3 - P2.R = P1.R / X
; 4 - P2.R = X / P1.R
; 5 - P2.R = P1.X
; 6 - P2.R += P1.X
; 7 - P2.R *= P1.X
; 8 - P2.R /= P1.X
; 9 - P2.R = P1.X / P2.R
; Diplomacy - allied is normal, neutrual is divided by 360, enemy is divided by 1000
ResModifier:
	Mov Edx, DWord Ptr Ss:[Edi + 64H]
.If Edx < 10
	.If Edx >= 5
		Mov Eax, DWord Ptr Ds:[Edi + 10H]
		Mov Esi, DWord Ptr Ss:[Esp + 18H]
		Cmp Eax, DWord Ptr Ds:[Esi + 0A4H]
		Jae ResModifier_Skip
		Mov Ecx, DWord Ptr Ds:[Esi + 0A8H]
		Fld DWord Ptr Ds:[Eax * 4 + Ecx]
		Sub Edx, 5

		Mov Esi, DWord Ptr Ss:[Esp + 20H]
		Mov Esi, DWord Ptr Ds:[Esi + 0A8H]
		Mov Eax, DWord Ptr Ds:[Edi + 14H]
		Fld DWord Ptr Ds:[Esi + Eax * 4]
	.Else
		Fild DWord Ptr Ds:[Edi + 10H]

		Mov Esi, DWord Ptr Ss:[Esp + 18H]
		Mov Esi, DWord Ptr Ds:[Esi + 0A8H]
		Mov Eax, DWord Ptr Ds:[Edi + 14H]
		Fld DWord Ptr Ds:[Esi + Eax * 4]
	.EndIf
	Jmp DWord Ptr Ds:[Edx * 4 + Offset ResModifier_Table]
ResModifier_Set:
	Fincstp
ResModifier_Do:
	Mov Al, Byte Ptr Ds:[Edi + 18H]
	.If Al == 1
		Fdiv Rate360
	.ElseIf Al == 3
		Fdiv Rate1000
	.EndIf
	Mov Esi, DWord Ptr Ss:[Esp + 20H]
	Mov Esi, DWord Ptr Ds:[Esi + 0A8H]
	Mov Eax, DWord Ptr Ds:[Edi + 14H]
	Fstp DWord Ptr Ds:[Esi + Eax * 4]
.EndIf
ResModifier_Skip:
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4

ResModifier_Add:
	Faddp St(1), St
	Jmp ResModifier_Do
ResModifier_Mul:
	Fmulp St(1), St
	Jmp ResModifier_Do
ResModifier_Div:
	Fxch
	Fdivp St(1), St
	Jmp ResModifier_Do
ResModifier_Dii:
	Fdivp St(1), St
	Jmp ResModifier_Do

Align 4
ResModifier_Table:
	DD Offset ResModifier_Set, Offset ResModifier_Add, Offset ResModifier_Mul, Offset ResModifier_Div, Offset ResModifier_Dii


SaveResources:
	Lea Esi, [Esp + 39C8H] ; Scenario Directory !
	Sub Esp, 100H
	Mov Eax, Esp

	Invoke wsprintf, Eax, Offset ResSavePattern, Esi, DWord Ptr Ds:[Edi + 6CH]

	Mov Esi, Esp
	Invoke CreateFile, Esi, GENERIC_READ Or GENERIC_WRITE,
				FILE_SHARE_READ, NULL, OPEN_ALWAYS, NULL, NULL
	Test Eax, Eax
.If !Zero?
	Mov Edi, Eax
	Invoke SetFilePointer, Edi, 0H, 0H, FILE_BEGIN

	Mov Esi, Ss:[Esp + 118H] ; Source Player
	Mov Ebx, [Esi + 0A4H] ; Resource Size
	Shl Ebx, 2
	Mov Esi, [Esi + 0A8H]
	Lea Eax, [Esp]

	Invoke WriteFile, Edi, Esi, Ebx, Eax, 0
	Invoke CloseHandle, Edi

.EndIf
	Add Esp, 100H
	Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


LoadResources:
	Lea Esi, [Esp + 39C8H] ; Scenario Directory !
	Sub Esp, 100H
	Mov Eax, Esp

	Invoke wsprintf, Eax, Offset ResSavePattern, Esi, DWord Ptr Ds:[Edi + 6CH]

	Mov Esi, Esp
	Invoke CreateFile, Esi, GENERIC_READ,
				FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL
	Test Eax, Eax
.If !Zero?
	Mov Edi, Eax
	Invoke SetFilePointer, Edi, 0H, 0H, FILE_BEGIN

	Mov Esi, Ss:[Esp + 118H] ; Source Player
	Mov Ebx, [Esi + 0A4H] ; Resource Size
	Shl Ebx, 2
	Mov Esi, [Esi + 0A8H]
	Lea Eax, [Esp]

	Invoke ReadFile, Edi, Esi, Ebx, Eax, 0
	Invoke CloseHandle, Edi

.EndIf
	Add Esp, 100H
	Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


WAIForTyper:
	Mov Esi, Ss:[Esp + 18H] ; Source Player
	Mov Edx, [Esi + 74H]
	Mov Ebx, [Edi + 24H] ; Protounit

	Sub Esp, 20H
	Fild DWord Ptr Ds:[Edi + 48H]
	Fst DWord Ptr Ss:[Esp + 14H]
	Fstp DWord Ptr Ss:[Esp + 4H]
	Fild DWord Ptr Ds:[Edi + 44H]
	Fadd DWord Ptr Ss:[TyperSize]
	Fst DWord Ptr Ss:[Esp + 10H]
	Fstp DWord Ptr Ss:[Esp]

	Xor Eax, Eax
	Mov Ebp, DWord Ptr Ds:[Edi + 6CH]
	Mov DWord Ptr Ss:[Esp + 0CH], Ebp
	Mov Al, Byte Ptr Ds:[Ebp]
.Repeat
	.If Al == 13
		Fld DWord Ptr Ss:[Esp + 14H]
		Fstp DWord Ptr Ss:[Esp + 4H]
	.ElseIf Al == 10
		Fld DWord Ptr Ss:[Esp]
		Fsub DWord Ptr Ss:[TyperSize]
		Fstp DWord Ptr Ss:[Esp]
	.Else
		Sub Al, ' '
		Mov Edi, [Eax * 4 + Offset ASCIIPatterns]

		Mov Eax, 5
		Push Eax
		Push Eax
		Sub Esp, 8H
		Fld DWord Ptr Ss:[Esp + 14H]
		Fstp DWord Ptr Ss:[Esp + 04H]
		Fld DWord Ptr Ss:[Esp + 10H]
		Fstp DWord Ptr Ss:[Esp]
		.Repeat
			.Repeat
				Test Edi, 1H
				.If !Zero?
					Push 1
					Push 0
					Sub Esp, 8H
					Fld DWord Ptr Ss:[Esp + 14H]
					Fstp DWord Ptr Ss:[Esp + 04H]
					Fld DWord Ptr Ss:[Esp + 10H]
					Fstp DWord Ptr Ss:[Esp]
					Push Ebx
					Mov Ecx, Esi
WAIForTyper_1:
					FakeCall SUB_DROPUNIT
				.EndIf
				Shr Edi, 1
				Fld DWord Ptr Ss:[Esp + 4H]
				Fadd DWord Ptr Ds:[TyperDelta]
				Fstp DWord Ptr Ss:[Esp + 4H]

				Mov Eax, DWord Ptr Ss:[Esp + 8H]
				Dec Eax
				Mov DWord Ptr Ss:[Esp + 8H], Eax
			.Until Zero?
			Mov Eax, 5
			Mov DWord Ptr Ss:[Esp + 8H], Eax

			Fld DWord Ptr Ss:[Esp + 14H]
			Fstp DWord Ptr Ss:[Esp + 4H]
			Fld DWord Ptr Ss:[Esp]
			Fsub DWord Ptr Ds:[TyperDelta]
			Fstp DWord Ptr Ss:[Esp]

			Mov Eax, DWord Ptr Ss:[Esp + 0CH]
			Dec Eax
			Mov DWord Ptr Ss:[Esp + 0CH], Eax
		.Until Zero?
		Add Esp, 10H
		Fld DWord Ptr Ss:[Esp + 4H]
		Fadd DWord Ptr Ss:[TyperSize]
		Fstp DWord Ptr Ss:[Esp + 4H]
	.EndIf

	Mov Ebp, DWord Ptr Ss:[Esp + 0CH]
	Inc Ebp
	Mov DWord Ptr Ss:[Esp + 0CH], Ebp
	Mov Al, Byte Ptr Ds:[Ebp]
	Test Al, Al
.Until Zero?
	Add Esp, 20H
	Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


; Protounit Modifier
; 0 - Set attribute
; 1 - Add attribute
; 2 - Set attribute by resource(by quantity)
Protounit:
	Mov Ebx, DWord Ptr Ds:[Edi + 3CH] ; ebx = Attribute ID
	Mov Ecx, DWord Ptr Ss:[Esp + 20H] ; Player
	Sub Esp, 4H
	Push 0 ; Mode:Techtree
Protounit_:
	Push Edi ; Trigger
	Mov Eax, DWord Ptr Ds:[Edi + 64H] ; Mode
.If Eax > 2
	Push 0
.Else
	Push Eax
.EndIf
.If Ebx > ATTRIBUTES_COUNT
	Mov Ebx, DEFAULT_ATTRIBUTE
.EndIf
	Mov Ebx, [Ebx * 4 + Offset Protounit_Attribute_Table]
	Xor Edx, Edx
	Mov Dx, Bx ; Offset
	Shr Ebx, 10H
	Xor Eax, Eax
	Mov Al, Bl ; Min "Type"
	Push Eax
	Push Edx
	Shr Ebx, 8H

	Call DWord Ptr Ds:[Ebx * 4 + Offset Protounit_CallTable]
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4


; Object Modifier
; 0 - Set attribute
; 1 - Add attribute
; 2 - Set attribute by resource(by quantity)
Modifier:
	Mov Ebx, ModifierObjectCount
	Cmp Ebx, 0
	Jle Modifier_
	Mov Esi, Offset ModifierObjects
.Repeat
	Mov Ecx, DWord Ptr Ds:[Esi]
	Mov Eax, DWord Ptr Ds:[Ecx + 8H]
.If Byte Ptr Ds:[Eax + 4] >= 70
Modifier_1:
	FakeCall 004C6400H
.EndIf
	Add Esi, 4
	Dec Ebx
.Until Zero?
Modifier_:
	Mov Ebx, DWord Ptr Ds:[Edi + 3CH] ; ebx = Attribute ID
	Mov Ecx, DWord Ptr Ss:[Esp + 20H] ; Player
	Mov Eax, ModifierObjectCount
	Push Eax
	Push Offset ModifierObjects
	Jmp Protounit_


__Protounit_Functions__

Align 4
Protounit_Attribute_Table:
__Protounit_Table__

Align 4
Protounit_CallTable:
	DD Offset Protounit_Char, Offset Protounit_Word, Offset Protounit_DWord, Offset Protounit_Float
	DD Offset Protounit_Image, Offset Protounit_Sound, Offset Protounit_Attack, Offset Protounit_Defense, 0


; Create Unit In Area
; 0 - Check restrictions
; 1 - Don't check restrictions
; Quantity - 0 is random, others set directions
CreateUnitsInArea:
	Mov Ecx, DWord Ptr Ds:[Edi + 24H]
	Mov Eax, DWord Ptr Ss:[Esp + 18H]
	Mov Edx, DWord Ptr Ds:[Eax + 74H]
	Mov Ecx, DWord Ptr Ds:[Ecx * 4 + Edx]
	Xor Ebx, Ebx
	Cmp Ecx, Ebx
	Je CreateUnitsInArea_Skip

	Mov Ebp, Edi

	Mov Ebx, Ecx
	Mov Edx, DWord Ptr Ds:[Ebp + 24H]
	Mov Ecx, Eax
	Mov Esi, DWord Ptr Ds:[Ebp + 4CH]
	Mov Edi, DWord Ptr Ds:[Ebp + 50H]

CreateUnitsInArea_Loop:
	Push Edx
	Push Ecx
	Push Esi
	Push Edi
	Cmp DWord Ptr Ds:[Ebp + 64H], 0
.If Zero?
	Xor Eax, Eax
	Push Eax
	Push Eax
	Push 1
	Push 1
	Push Eax
	Push Eax
	Push 1
	Push Eax
	Push Eax
	Push Edi
	Fild DWord Ptr Ss:[Esp]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
	Mov Edi, [Esp]
	Push Esi
	Fild DWord Ptr Ss:[Esp]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
	Mov Esi, [Esp]
	Push Ecx
	Mov Ecx, Ebx
CreateUnitsInArea_2:
	FakeCall 00463370H
	Test Al, Al
	Jne CreateUnitsInArea_Continue

	Mov Edx, DWord Ptr Ss:[Esp + 0CH]
	Mov Ecx, DWord Ptr Ss:[Esp + 08H]

	Push 1
	Push 0
	Push Edi
	Push Esi
.Else
	Push 1
	Push 0
	Push Edi
	Fild DWord Ptr Ss:[Esp]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
	Push Esi
	Fild DWord Ptr Ss:[Esp]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
.EndIf
	Push Edx
CreateUnitsInArea_1:
	FakeCall SUB_DROPUNIT
	Mov Cl, [Ebp + 10H]
	Cmp Cl, 0
	Jle CreateUnitsInArea_Continue ; Adjusting rotations
	Dec Cl
	Mov Byte Ptr Ds:[Eax + 35H], Cl
CreateUnitsInArea_Continue:
	Pop Edi
	Pop Esi
	Pop Ecx
	Pop Edx

	Inc Esi
	Cmp Esi, DWord Ptr Ds:[Ebp + 54H]
	Jle CreateUnitsInArea_Loop
	Cmp Edi, DWord Ptr Ds:[Ebp + 58H]
	Jge CreateUnitsInArea_Skip
	Mov Esi, DWord Ptr Ds:[Ebp + 4CH]
	Inc Edi
	Jmp CreateUnitsInArea_Loop

CreateUnitsInArea_Skip:
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4


; Change/Replace Object:
; 0 - Change objects instantly (must be Type 70+)
; 1 - Remove objects, then create changed units
; 2 - Create changed units on objects
ChangeObject:
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Xor Esi, Esi
	Cmp Eax, Ebx
	Jl ChangeObject_
	Mov Ebp, Eax
	Mov Esi, DWord Ptr Ss:[Esp + 18H]

	Mov Eax, DWord Ptr Ds:[Edi + 10H]
	Cmp Eax, DWord Ptr Ds:[Esi + 70H]
	Jae ChangeObject_
	Mov Ecx, DWord Ptr Ds:[Edi + 64H]
	Cmp Ecx, 1
	Je ChangeObject_Replace
	Cmp Ecx, 2
	Je ChangeObject_Attach

	Mov Ebx, DWord Ptr Ds:[Esi + 74H]
	Mov Ebx, DWord Ptr Ds:[Eax * 4 + Ebx]
	Test Ebx, Ebx
	Je ChangeObject_
	Lea Edi, [Esp + 94H]
.Repeat
	Mov Ecx, DWord Ptr Ds:[Edi]
	Mov Esi, [Ecx + 8H]
	.If Byte Ptr Ds:[Esi + 4H] >= 70
		Push Ebx
ChangeObject_1:
		FakeCall SUB_TRANSFORM
		Mov Ecx, DWord Ptr Ds:[Edi]
		.If Esi != DWord Ptr Ds:[Ecx + 0CH]
ChangeObject_2:
			FakeCall SUB_UNIQUEUNIT
		.EndIf
	.EndIf
	Add Edi, 4
	Dec Ebp
.Until Zero?
ChangeObject_:
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4

ChangeObject_Replace:
	Mov Ebx, Eax
	Lea Edi, [Esp + 94H]
.Repeat
	Mov Esi, DWord Ptr Ds:[Edi]

	Mov Edx, DWord Ptr Ss:[Esp + 18H]
	Push 1
	Push 0
	Mov Eax, DWord Ptr Ds:[Esi + 3CH]
	Push Eax
	Mov Eax, DWord Ptr Ds:[Esi + 38H]
	Push Eax
	Push Ebx
	Mov Ecx, Edx
ChangeObject_3:
	FakeCall SUB_DROPUNIT
	Mov Eax, DWord Ptr Ds:[Esi + 8]
	.If Byte Ptr Ds:[Eax + 4] == 50H
		Mov Edx, DWord Ptr Ds:[Esi + 1A8H]
		Test Edx, Edx
		.If !Zero?
			Mov Esi, Edx
		.EndIf
	.EndIf
	Mov Ecx, Esi
	Mov Eax, DWord Ptr Ds:[Ecx]
	Call DWord Ptr Ds:[Eax + 70H]

	Add Edi, 4
	Dec Ebp
.Until Zero?
	Jmp ChangeObject_

ChangeObject_Attach:
	Mov Ebx, Eax
	Lea Edi, [Esp + 94H]
.Repeat
	Mov Esi, DWord Ptr Ds:[Edi]
	Mov Edx, DWord Ptr Ss:[Esp + 18H]
	Push 1
	Push 0
	Mov Eax, DWord Ptr Ds:[Esi + 3CH]
	Push Eax
	Mov Eax, DWord Ptr Ds:[Esi + 38H]
	Push Eax
	Push Ebx
	Mov Ecx, Edx
ChangeObject_4:
	FakeCall SUB_DROPUNIT
	Add Edi, 4
	Dec Ebp
.Until Zero?
	Jmp ChangeObject_


; Set Resource Storage
; 0 - Set resource
; 1 - Add resource
; 2 - Load resource from target player
; 3 - Save resource to target player
SetResourceStorage:
    Mov Eax, [Esp + 10H]
    Xor Ebp, Ebp
    Cmp Eax, Ebx
    Jle SetResourceStorage_Skip
    Lea Ebx, [Esp + 94H]
    Mov Eax, DWord Ptr Ds:[Edi + 64H]
.If Eax >= 4
	Xor Eax, Eax
.EndIf
	Jmp [Eax * 4 + Offset SetResourceStorage_Table]

SetResourceStorage_Set:
    Mov Esi, [Ebx]
    Fild DWord Ptr Ds:[Edi + 10H]
	Fstp DWord Ptr Ds:[Esi + 44H]
    Mov Eax, [Esp + 10H]
    Inc Ebp
    Add Ebx, 4
    Cmp Ebp, Eax
    Jl SetResourceStorage_Set

SetResourceStorage_Skip:
    Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4

SetResourceStorage_Add:
    Mov Esi, [Ebx]
    Fild DWord Ptr Ds:[Edi + 10H]
	Fadd DWord Ptr Ds:[Esi + 44H]
	Fstp DWord Ptr Ds:[Esi + 44H]
    Mov Eax, [Esp + 10H]
    Inc Ebp
    Add Ebx, 4
    Cmp Ebp, Eax
    Jl SetResourceStorage_Add
    Jmp SetResourceStorage_Skip

SetResourceStorage_Load:
	Mov Ecx, DWord Ptr Ss:[Esp + 20H]
	Mov Eax, DWord Ptr Ds:[Edi + 10H]
	Cmp Eax, DWord Ptr Ds:[Ecx + 0A0H]
	Jae SetResourceStorage_Skip
	Mov Ecx, DWord Ptr Ds:[Ecx + 0A8H]
    Lea Ecx, [Eax * 4 + Ecx]
    Fld DWord Ptr Ds:[Ecx]
    Mov Eax, [Esp + 10H]
SetResourceStorage_Load_:
    Mov Esi, [Ebx]
	Fst DWord Ptr Ds:[Esi + 44H]
    Inc Ebp
    Add Ebx, 4
    Cmp Ebp, Eax
    Jl SetResourceStorage_Load_
    Fincstp
    Jmp SetResourceStorage_Skip

SetResourceStorage_Save:
	Mov Ecx, DWord Ptr Ss:[Esp + 20H]
	Mov Eax, DWord Ptr Ds:[Edi + 10H]
	Cmp Eax, DWord Ptr Ds:[Ecx + 0A0H]
	Jae SetResourceStorage_Skip
	Mov Ecx, DWord Ptr Ds:[Ecx + 0A8H]
    Lea Ecx, [Eax * 4 + Ecx]
    Mov Esi, [Ebx]
	Fld DWord Ptr Ds:[Esi + 44H]
	Fstp DWord Ptr Ds:[Ecx]
    Jmp SetResourceStorage_Skip

Align 4
SetResourceStorage_Table:
	DD Offset SetResourceStorage_Set, Offset SetResourceStorage_Add, Offset SetResourceStorage_Load, Offset SetResourceStorage_Save


; Focus Object
; 0 - Move sight to object
; 1 - Cut sight to object
FocusObject:
	Cmp Eax, Ebx
	Jle FocusObject_Skip
	Lea Esi, [Esp + 94H]
	Mov Ebx, [Esi]

	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Test Eax, Eax
.If Zero?
	Push Ecx
	Fld DWord Ptr Ds:[Ebx + 3CH]
	Fstp DWord Ptr Ss:[Esp]
	Push Ecx
	Fld DWord Ptr Ds:[Ebx + 38H]
	Fstp DWord Ptr Ss:[Esp]
	Mov Ecx, DWord Ptr Ss:[Esp + 2CH]
FocusObject_1:
	FakeCall 005580D0H
.Else
	Push 0
	Push Ecx
	Fld DWord Ptr Ds:[Ebx + 3CH]
	Fstp DWord Ptr Ss:[Esp]
	Push Ecx
	Fld DWord Ptr Ds:[Ebx + 38H]
	Fstp DWord Ptr Ss:[Esp]
	Mov Ecx, DWord Ptr Ss:[Esp + 2CH]
FocusObject_2:
	FakeCall 00555C30H
.EndIf
FocusObject_Skip:
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4


; Object Modifier Selector
; 0 - Set objects
; 1 - Append objects
; Note: Must be in order (postfix figures should be less than modifier effects)
ModifierSelect:
	Mov Esi, [Esp + 10H]
	Xor Eax, Eax
	Mov Edx, [Edi + 64H]
	Mov Edi, Offset ModifierObjects
.If Edx == 1
	Cmp Esi, Ebx
	Jle ModifierSelect_Skip

	Mov Ebp, ModifierObjectCount
	Lea Edi, [Edi + Ebp * 4]
.Else
	Xor Ebp, Ebp
	Cmp Esi, Ebx
	Jle ModifierSelect_End
.EndIf
	Lea Ebx, [Esp + 94H]
ModifierSelect_Loop:
	Mov Ecx, [Ebx]
	Mov [Edi], Ecx
	Inc Eax
	Inc Ebp
	Add Edi, 4
	Add Ebx, 4

	Cmp Eax, Esi
	Jge ModifierSelect_End
	Cmp Ebp, 256
	Jl ModifierSelect_Loop
ModifierSelect_End:
	Mov ModifierObjectCount, Ebp
ModifierSelect_Skip:
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4


; ==== Conditions ====

Civilization:
    Mov Edx, [Esp + 24H]
    Mov Cl, [Edx + 15DH]
    Mov Al, [Esi + 0CH]
    Cmp Al, Cl
Civilization_01:
    FakeJne 00437029H ; False
    Pop Edi
    Mov Byte Ptr Ds:[Esp + 0FH], 1
    Mov Al, [Esp + 0FH]
    Pop Esi
    Pop Ebp
    Pop Ebx
    Add Esp, 0CH
    Retn 8



End DllEntryPoint
