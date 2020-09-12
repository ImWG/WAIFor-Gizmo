;EasyCodeName=Module,1
Include	Protounits.asm

.Const

; ==== Interfaces ====
; NOTE: If you don't create either conditions nor effects, you can remove them both in ASM and DEF files.

; Effects
__EffectCount  DD 20
__EffectNames  DD Offset Name1, Offset Name2, Offset Name3, Offset Name4, Offset Name5, Offset Name6, Offset Name7, Offset Name8
		DD Offset Name9, Offset Name10, Offset Name11, Offset Name12, Offset Name13, Offset Name14, Offset Name15, Offset Name16
		DD Offset Name17, Offset Name18, Offset Name19, Offset Name20 ;, Offset Name21

; Inputs:Dword, Necessary Inputs:Dword
__EffectInputs DD INE_TEXT + INE_FROMPLAYER + INE_RESOURCE + INE_NUMBER, 0 ; ChoiceBox
		DD INE_RESOURCE + INE_FROMPLAYER + INE_TOPLAYER + INE_QUANTITY + INE_NUMBER + INE_DIPLOMACY, 0 ; ResModifier
		DD INE_TEXT + INE_FROMPLAYER, 0 ; SaveResources
		DD INE_TEXT + INE_FROMPLAYER + INE_NUMBER, 0 ; LoadResources
		DD INE_QUANTITY + INE_PROTOUNIT + INE_UNIT_FILTER + INE_FROMPLAYER + INE_TOPLAYER + INE_NUMBER, 0 ; SetResourceStorage
		DD INE_TEXT + INE_PROTOUNIT + INE_FROMPLAYER + INE_NUMBER, INE_PROTOUNIT + INE_FROMPLAYER ; Protounit
		DD INE_TEXT + INE_NUMBER + INE_UNIT_FILTER + INE_FROMPLAYER + INE_PROTOUNIT, 0 ; Modifier
		DD INE_QUANTITY + INE_PROTOUNIT + INE_FROMPLAYER + INE_AREA + INE_NUMBER, INE_PROTOUNIT + INE_FROMPLAYER + INE_AREA ; CreateUnitsInArea
		DD INE_QUANTITY + INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_NUMBER, 0 ; ChangeObject
		DD INE_TEXT + INE_PROTOUNIT + INE_FROMPLAYER + INE_AREA, INE_PROTOUNIT + INE_FROMPLAYER + INE_AREA ; WAIForTyper
		DD INE_TOPLAYER + INE_PROTOUNIT + INE_FROMPLAYER + INE_UNIT_FILTER + INE_NUMBER, 0 ; FocusObject
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_TARGET, 0 ; InstantGarrison
		DD INE_AISIGNAL + INE_QUANTITY, 0 ; PlayDrsSound
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_QUANTITY + INE_NUMBER, 0 ; RotateUnit
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_QUANTITY + INE_NUMBER, 0 ; SetAttachGraphic
		DD INE_AREA + INE_QUANTITY, INE_AREA ; SetTerrain
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_TARGET + INE_NUMBER, 0 ; CloneObject
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_QUANTITY + INE_NUMBER, 0 ; ChangeObjectId
		;DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_QUANTITY + INE_NUMBER, 0 ; ChangeObjectHeight
		DD INE_TEXT + INE_NUMBER + INE_UNIT_FILTER + INE_FROMPLAYER + INE_PROTOUNIT, INE_TEXT ; ShiftObject
		DD INE_PROTOUNIT_FILTER + INE_UNIT_FILTER + INE_QUANTITY + INE_NUMBER, 0 ; TaskObjectByDirection
		;DD INE_TARGET + INE_TIMER + INE_TOPLAYER + INE_AISIGNAL, 0 ; PlayAnimation


__Effects      DD ChoiceBox
		DD ResModifier
		DD SaveResources
		DD LoadResources
		DD SetResourceStorage
		DD Protounit
		DD Modifier
		DD CreateUnitsInArea
		DD ChangeObject
		DD WAIForTyper
		DD FocusObject
		DD InstantGarrison
		DD PlayDrsSound
		DD RotateUnit
		DD SetAttachGraphic
		DD SetTerrain
		DD CloneObject
		DD ChangeObjectId
		DD ShiftObject
		;DD ChangeObjectHeight
		DD TaskObjectByDirection
		;DD PlayAnimation

; Conditions
__ConditionCount  DD 4
__ConditionNames  DD Offset CName1, Offset CName2, Offset CName3, Offset CName4
__ConditionInputs DD 0, 0, INC_QUANTITY, 0
		DD INC_PROTOUNIT_FILTER + INC_QUANTITY + INC_NEXTUNIT, INC_NEXTUNIT
		DD INC_UNIT + INC_NEXTUNIT + INC_QUANTITY + INC_TIMER, INC_UNIT
__Conditions      DD TestCondition, KeyIsDown, UnitsNearObjects, ObjectFacingTo

; Address List To Change (Offset 1, For FakeJmp and FakeCall)
__Addresses    DD ChoiceBox_1, ChoiceBox_2, ChoiceBox_3, ResModifier_1, WAIForTyper_1, CreateUnitsInArea_1, CreateUnitsInArea_2
		DD ChangeObject_1, ChangeObject_2, ChangeObject_3, ChangeObject_4, LoadImageOnMap_1, LoadImageOnMap_2
		DD FocusObject_1, FocusObject_2, Modifier_1, Protounit_Image_1, SetTerrain_1
		DD RotateUnit_1, RotateUnit_2, RotateUnit_3, PlayDrsSound_1, PlayDrsSound_2, PlayDrsSound_3
		DD SetAttachGraphic_1, SetAttachGraphic_2, CloneObject_1, CloneObject_2, CloneObject_3, CloneObject_4
		DD KeyIsDown_1, ShiftObject_1, ShiftObject_2, PlayAnimation_1 ;ChangeObjectHeight_1
		DD 0
; Address List To Change (Offset 2, For Fake Conditional Jumps)
__Addresses2   DD 0


.Data?

.Data

Name1 DB '`%sShow Choice Box (SP)', 0
		DW 57620
Name2 DB '`%sResource Modifier', 0
		DW 57621
Name3 DB '`%sSave Resources To File', 0
		DW 57622
Name4 DB '`%sLoad Resources From File', 0
		DW 57623
Name5 DB '`%sSet Resource Storage', 0
		DW 57624
Name6 DB 'Protounit Modifier', 0
Name7 DB 'Object Modifier', 0
Name8 DB 'Create Units In Area', 0
Name9 DB 'Change/Replace Object', 0
Name10 DB 'WAIFor Unit Typer', 0
Name11 DB 'Focus Object', 0
Name12 DB 'Instant Garrison', 0
Name13 DB 'Play Internal Sound', 0
Name14 DB 'Rotate Objects', 0
Name15 DB 'Set Attaching Graphic', 0
Name16 DB 'Set Terrain', 0
Name17 DB 'Clone Object', 0
Name18 DB 'Change Object Id', 0
;Name19 DB 'Change Object Height', 0
Name19 DB 'Shift Object', 0
Name20 DB 'Task Object By Direction', 0
Name21 DB 'Play Animation At', 0

CName1 DB 'Start / Load Saved Game', 0
CName2 DB 'Key Pressed', 0
CName3 DB 'Units Near Object', 0
CName4 DB 'Object Facing To', 0

;Name1 DB 'Show Choice Box (SP)', 0
;Name2 DB '`%s %s %s', 0
;	DW 9215, 9213, 9735
;Name3 DB '%s %s', 0
;	DW 9272, 9735
;Name4 DB '`%s %s', 0
;	DW 9276, 9735
;Name5 DB '`%s %s', 0
;	DW 9215, 9735
;Name6 DB 'Protounit Modifier', 0
;Name7 DB 'Object Modifier', 0
;Name8 DB 'Create Units In Area', 0
;Name9 DB 'Change/Replace Object', 0
;Name10 DB 'WAIFor Unit Typer', 0
;Name11 DB 'Focus Object', 0
;Name12 DB 'Instant Garrison', 0
;Name13 DB 'Play Internal Sound', 0
;Name14 DB '`%s %s', 0
;	DW 10106, 9733
;Name15 DB 'Set Attaching Graphic', 0
;Name16 DB '`%s %s', 0
;	DW 9215, 10011
;Name17 DB 'Clone Object', 0
;CName1 DB 'Start / Load Saved Game', 0


ResSavePattern DB '%s%s.res', 0
BitmapPattern DB '%s%s.bmp', 0
ShiftPattern DB '%d,%d,%d', 0
ImageUnit Equ 1060 ;253

Align 4
ASCIIPatterns DD 0000000H, 0401084H, 000014AH, 0AFABEAH, 0EA38AEH, 19D1173H, 1F2BCA6H, 0000084H, 0410844H, 0442104H, 04ABAA4H, 0427C84H, 0221000H, 0007C00H, 0020000H, 0111110H
		DD 0E9D72EH, 0E210C4H, 1F1322EH, 0F8320FH, 08FA54CH, 0F83C3FH, 0E8BC2EH, 042221FH, 0E8BA2EH, 0E87A2EH, 0020080H, 0220080H, 18304D8H, 00F83E0H, 0364183H, 040310EH
		DD 0CAF62EH, 11FC544H, 0F8BE2FH, 0E8862EH, 0F94A4FH, 1F0BC3FH, 010BC3FH, 0E8F42EH, 118FE31H, 0E2108EH, 0E8C210H, 1149D31H, 1F08421H, 118D771H, 11CD671H, 0E8C62EH
		DD 010BE2FH, 164D62EH, 114BE2FH, 0F8383EH, 042109FH, 0E8C631H, 0452A31H, 11DD631H, 1151151H, 0421151H, 1F1111FH, 0610846H, 1041041H, 0C4210CH, 0004544H, 1F00000H
		DD 0000104H, 164B906H, 0E93842H, 0C10980H, 0E4B908H, 1C17A4CH, 042789CH, 064392EH, 1293842H, 0E21804H, 0642008H, 1251942H, 0E21086H, 15AD560H, 12949C0H, 0C94980H
		DD 02749C0H, 08725C0H, 0211B40H, 0320980H, 1C27880H, 0E4A520H, 0454A40H, 0AAD6A0H, 0931920H, 0743929H, 0E22380H, 0C2088CH, 0421084H, 0622086H, 0045440H, 1FFFFFFH
;SnowPatterns DB 1, 4, 2, 0, 0, 2, 0, 0, 0, 1, 2, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 3, 3, 0, 0, 0, 0, 0, 0, 0, 5, 5, 0, 0, 0, 5, 3
;SnowTable DB 34, 33, 38, 32, 37 ; Snow Grass, Dirt, Road, Ice and all-Snow


TestFloat DD 10.0
TyperDelta DD 0.16666667
TyperSize DD 1.0
Rate360 DD 360.0
Rate1000 DD 1000.0
RotationDelta DD 0.125
Float2 DD 2.0


.Code

; Entry, can't be ignored
DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	Mov Eax, TRUE
	Ret
DllEntryPoint EndP


; ==== Effects ====


__EffectPostfix__ Macro
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4
EndM


; Show Choice Box (SP Only)
; Resource - choice to send (0 is no, 1 is yes)
; Player - resource owner
ChoiceBox:
	Mov Ecx, DWord Ptr Ds:[Plc]
ChoiceBox_1:
	FakeCall 005EAE90H
	Test Eax, Eax
.If Zero?
	Sub Esp, 100H
	Invoke  GetActiveWindow
	Mov Ebp, Eax
	Mov Esi, Esp

	Invoke  GetWindowText, Ebp, Esi, 255
	Mov Edx, DWord Ptr Ds:[Edi + 6CH]
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	.If Eax == 2
		Mov Eax, MB_ICONINFORMATION + MB_OK
	.ElseIf Eax == 1
		Mov Eax, MB_ICONQUESTION + MB_YESNOCANCEL
	.ElseIf Eax == 9
		Jmp ChoiceBox_Interior
	.Else
		Mov Eax, MB_ICONQUESTION + MB_YESNO
	.EndIf
	Invoke MessageBox, Ebp, Edx, Esi, Eax
	.If Eax != IDOK
		.If Eax == IDYES
			Mov Eax, 1
		.ElseIf Eax == IDCANCEL
			Mov Eax, 2
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
	.EndIf
	Add Esp, 100H
.EndIf
	__EffectPostfix__

ChoiceBox_Interior:
	Add Esp, 100H
	Mov Ecx, 7861B8H
ChoiceBox_3:
	FakeCall 005EE560H
	Mov Ecx, Eax
	Push 0
	Push 0B4H ; Height
	Push 1C2H ; Width
	Push 0066F548H ; Caption? Class?
	Push Edx ; Text
ChoiceBox_2:
    FakeCall 0055F4F0H
	__EffectPostfix__


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
	Mov Ebx, DWord Ptr Ss:[Edi + 64H]
.If Ebx < 10
	.If Ebx >= 5 ; Resource Of Quantity
		Mov Eax, DWord Ptr Ds:[Edi + 10H]
		Mov Esi, DWord Ptr Ss:[Esp + 18H]
		Cmp Eax, 0
		Jge ResModifier_Normal

		Not Eax ; Negative makes random from 0 to that (integer, -T-1)
		Cmp Eax, DWord Ptr Ds:[Esi + 0A4H]
		Jae ResModifier_Skip
		Mov Ecx, DWord Ptr Ds:[Esi + 0A8H]
		Sub Esp, 4
		Fld DWord Ptr Ds:[Eax * 4 + Ecx]
		Fld St
		Fabs
		Fistp DWord Ptr Ss:[Esp] ; =abs(S2)
		Mov Ecx, DWord Ptr Ss:[Esp]
		Test Ecx, Ecx ; Avoid Zero division exception
		.If !Zero?
ResModifier_1:
			FakeCall SUB_RANDOM
			Mov Ecx, DWord Ptr Ss:[Esp]
			Cdq
			IDiv Ecx
			Fldz
			Fcompp
			Fstsw Ax
			Test Ah, 41H
			.If Zero? ; If S2 > 0
				Neg Edx
			.EndIf
			Mov DWord Ptr Ss:[Esp], Edx
		.EndIf
		Fild SDWord Ptr Ss:[Esp]
		Add Esp, 4H
		Jmp ResModifier_

ResModifier_Normal:
		Cmp Eax, DWord Ptr Ds:[Esi + 0A4H]
		Jae ResModifier_Skip
		Mov Ecx, DWord Ptr Ds:[Esi + 0A8H]
		Fld DWord Ptr Ds:[Eax * 4 + Ecx]

ResModifier_:
		Sub Ebx, 5
		Mov Esi, DWord Ptr Ss:[Esp + 20H]
		Mov Esi, DWord Ptr Ds:[Esi + 0A8H]
		Mov Eax, DWord Ptr Ds:[Edi + 14H]
		Fld DWord Ptr Ds:[Esi + Eax * 4]

	.Else ; Instant
		Fild DWord Ptr Ds:[Edi + 10H]
		Mov Esi, DWord Ptr Ss:[Esp + 18H]
		Mov Esi, DWord Ptr Ds:[Esi + 0A8H]
		Mov Eax, DWord Ptr Ds:[Edi + 14H]
		Fld DWord Ptr Ds:[Esi + Eax * 4]

	.EndIf
	Jmp DWord Ptr Ds:[Ebx * 4 + Offset ResModifier_Table]
ResModifier_Set:
	Fstp St
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

; ecx - Source String Addr
; arg1 - Dest. String Addr
; arg2 - Max Range
; Return eax and edx to be range
ResourceFileString:
	Push Ebx
	Push Ebp
	Push Esi
	Push Edi
	Mov Edi, DWord Ptr Ss:[Esp + 14H]
	Mov Esi, Ecx
	Mov Al, [Esi]
	Xor Ecx, Ecx
	Mov Edx, DWord Ptr Ss:[Esp + 18H]
	Test Al, Al
.While !Zero?
	.If Al == ':'
		Xor Eax, Eax
		Mov [Edi], Al
		Inc Esi
		Mov Al, [Esi]
		Test Al, Al
		.While !Zero? ; Start Res
			Sub Al, '0'
			.If Al >= 10
				Mov Eax, DWord Ptr Ss:[Esp + 18H]
				.If Ecx > Eax
					Mov Ecx, Eax
				.EndIf
				Xor Edx, Edx
				Xor Eax, Eax
				Inc Esi
				Mov Al, [Esi]
				Test Al, Al
				.While !Zero? ; End Res
					Sub Al, '0'
					.If Al >= 10
						Mov Eax, DWord Ptr Ss:[Esp + 18H]
						.If Edx > Eax
							Mov Edx, Eax
						.EndIf
						Jmp ResourceFileString_
					.EndIf
					Lea Edx, [Edx * 4 + Edx]
					Lea Edx, [Edx * 2 + Eax] ; ECX = ECX*10 + EAX
					Inc Esi
					Mov Al, [Esi]
					Test Al, Al
				.EndW
				Jmp ResourceFileString_
			.EndIf
			Lea Ecx, [Ecx * 4 + Ecx]
			Lea Ecx, [Ecx * 2 + Eax] ; ECX = ECX*10 + EAX
			Inc Esi
			Mov Al, [Esi]
			Test Al, Al
		.EndW
		Jmp ResourceFileString_
	.EndIf
	Mov [Edi], Al
	Inc Edi
	Inc Esi
	Mov Al, [Esi]
	Test Al, Al
.EndW
	Xor Eax, Eax
	Mov [Edi], Al
ResourceFileString_:
	Mov Eax, Ecx
	Pop Edi
	Pop Esi
	Pop Ebp
	Pop Ebx
	Retn 8

; Load & Save Resources
; Message as file name, pattern like "name:from:to" will load or save certain resources only
SaveResources:
	Lea Esi, [Esp + 39C8H] ; Scenario Directory !
	Sub Esp, 200H
	Lea Eax, [Esp + 100H] ; Dest String
	Mov Ecx, DWord Ptr Ds:[Edi + 6CH] ; String
	Mov Edx, Ss:[Esp + 218H] ; Source Player
	Mov Edx, DWord Ptr Ds:[Edx + 0A4H] ; Resource Size
	Dec Edx
	Push Edx
	Push Eax
	Call ResourceFileString
	Push Edx
	Push Eax

	Lea Eax, [Esp + 108H]
	Lea Edx, [Esp + 8H]
	Invoke wsprintf, Edx, Offset ResSavePattern, Esi, Eax

	Lea Esi, [Esp + 8H]
	Invoke CreateFile, Esi, GENERIC_READ Or GENERIC_WRITE,
				FILE_SHARE_READ, NULL, OPEN_ALWAYS, NULL, NULL
	Test Eax, Eax
.If !Zero?
	Mov Edi, Eax
	Invoke SetFilePointer, Edi, 0H, 0H, FILE_BEGIN

	Pop Eax
	Pop Ebx
	Mov Esi, Ss:[Esp + 218H] ; Source Player
	Inc Ebx
	Sub Ebx, Eax
	Shl Ebx, 2 ; Length
	Mov Esi, [Esi + 0A8H]
	Lea Esi, [Esi + Eax * 4]
	Lea Eax, [Esp]

	Invoke WriteFile, Edi, Esi, Ebx, Eax, 0
	Invoke SetEndOfFile, Edi
	Invoke CloseHandle, Edi

.EndIf
	Add Esp, 200H
	Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


LoadResources:
	Lea Esi, [Esp + 39C8H] ; Scenario Directory !
	Sub Esp, 200H
	Lea Eax, [Esp + 100H] ; Dest String
	Mov Ecx, DWord Ptr Ds:[Edi + 6CH] ; String
	Mov Edx, Ss:[Esp + 218H] ; Source Player
	Mov Edx, DWord Ptr Ds:[Edx + 0A4H] ; Resource Size
	Dec Edx
	Push Edx
	Push Eax
	Call ResourceFileString
	Push Edx
	Push Eax

	Lea Eax, [Esp + 108H]
	Lea Edx, [Esp + 8H]
	Cmp DWord Ptr Ds:[Edi + 64H], 9
	Je LoadImageOnMap
	Invoke wsprintf, Edx, Offset ResSavePattern, Esi, Eax

	Lea Esi, [Esp + 8H]
	Invoke CreateFile, Esi, GENERIC_READ,
				FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL
	Test Eax, Eax
.If !Zero?
	Mov Edi, Eax
	Invoke SetFilePointer, Edi, 0H, 0H, FILE_BEGIN

	Pop Eax
	Pop Ebx
	Mov Esi, Ss:[Esp + 218H] ; Source Player
	Inc Ebx
	Sub Ebx, Eax
	Shl Ebx, 2 ; Length
	Mov Esi, [Esi + 0A8H]
	Lea Esi, [Esi + Eax * 4]
	Lea Eax, [Esp]

	Invoke ReadFile, Edi, Esi, Ebx, Eax, 0
	Invoke CloseHandle, Edi

.EndIf
	Add Esp, 200H
	Pop Edi
    Pop Esi
    Pop Ebp
    Mov Al, 1
    Pop Ebx
    Add Esp, 2034H
    Retn 4


LoadImageOnMap: ; An easten egg loading a bitmap file on map, forked from Load Resources
	Invoke wsprintf, Edx, Offset BitmapPattern, Esi, Eax
	Lea Esi, [Esp + 8H]
	Invoke CreateFile, Esi, GENERIC_READ,
				FILE_SHARE_READ, NULL, OPEN_EXISTING, NULL, NULL
	Test Eax, Eax
.If !Zero?
	Mov Edi, Eax
	Pop Eax
	Pop Eax
	Invoke SetFilePointer, Edi, 0H, 0H, FILE_BEGIN
	Lea Eax, [Esp + 4H]
	Mov Edx, Esp
	Invoke ReadFile, Edi, Edx, 2, Eax, 0 ; Check Header
	Mov Ax, Word Ptr Ss:[Esp]
	Cmp Ax, 4D42H
	Jne LoadImageOnMap_Skip
	Invoke SetFilePointer, Edi, 10H, 0H, FILE_CURRENT
	Lea Edx, [Esp + 8H]
	Mov Eax, Esp
	Invoke ReadFile, Edi, Eax, 8, Edx, 0 ; Read Image Size
	Mov Eax, DWord Ptr Ss:[Esp + 8H]
	Cmp Eax, 8
	Jne LoadImageOnMap_Skip

	Mov Ebp, DWord Ptr Ds:[Plc]
	Mov Ebp, DWord Ptr Ds:[Ebp + 424H]
	Mov Ebp, DWord Ptr Ds:[Ebp + 4CH]
	Mov Ebp, DWord Ptr Ds:[Ebp] ; =GAIA

	; Set Special Attributes
	Mov Esi, DWord Ptr Ds:[Ebp + 74H]
	Mov Esi, DWord Ptr Ds:[Esi + ImageUnit * 4]
	Mov Byte Ptr Ds:[Esi + 0B4H], 1

	; Remove Previous Units
	Mov Esi, DWord Ptr Ds:[Ebp + 78H]
	Push Ebp
	Mov Ebp, DWord Ptr Ds:[Esi + 4H]
	Mov Ebx, DWord Ptr Ds:[Esi + 8H] ; Unit Count
	Test Ebx, Ebx
	Jle LoadImageOnMap_RemoveEnd
LoadImageOnMap_RemoveLoop:
	Mov Ecx, DWord Ptr Ss:[Ebp]
	Mov Eax, DWord Ptr Ds:[Ecx + 8H]
	.If Word Ptr Ds:[Eax + 10H] == ImageUnit
		.If Byte Ptr Ds:[Eax + 96H] == 4
			Xor Eax, Eax ; By setting both HP and resource as zero
			Mov DWord Ptr Ds:[Ecx + 30H], Eax
			Mov DWord Ptr Ds:[Ecx + 44H], Eax
		.EndIf
	.EndIf
	Add Ebp, 4
	Dec Ebx
	Jne LoadImageOnMap_RemoveLoop
LoadImageOnMap_RemoveEnd:
	Pop Ebp

	; Go Offset By Palette Size
	Invoke SetFilePointer, Edi, 032H, 0H, FILE_BEGIN
	Lea Edx, [Esp + 8H]
	Lea Eax, [Esp + 60H]
	Invoke ReadFile, Edi, Edx, 1, Eax, 0
	Movzx Eax, Byte Ptr Ds:[Esp + 8H]
	Lea Eax, [Eax * 4 + 36H]
	Invoke SetFilePointer, Edi, Eax, 0H, FILE_BEGIN

	; Start Draw Image!
	Mov Ebx, DWord Ptr Ss:[Esp + 4H] ; Height
LoadImageOnMap_Loop:
	Xor Esi, Esi
LoadImageOnMap_Loop2:
	Push 1
	Push 0
	Push Ebx
	Push Esi
	Fild DWord Ptr Ss:[Esp + 4H]
	Fsub DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp + 04H]
	Fild DWord Ptr Ss:[Esp]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
	Push ImageUnit ; Pile Of Wood
	Mov Ecx, Ebp
LoadImageOnMap_1:
	FakeCall SUB_DROPUNIT
	Push Esi
	Mov Esi, Eax
	Mov Ecx, Esi
LoadImageOnMap_2:
	FakeCall SUB_UNIQUEUNIT
	Mov Ecx, [Esi + 8H]
	Mov Byte Ptr Ds:[Ecx + 96H], 4
	Pop Esi
	Lea Edx, [Ecx + 98H]
	Lea Eax, [Esp + 60H]
	Invoke ReadFile, Edi, Edx, 1, Eax, 0 ; Set Color
	;Mov Byte Ptr Ds:[Ecx + 98H], Al

	Inc Esi
	Cmp Esi, DWord Ptr Ss:[Esp] ; Width
	.If Zero?
		Dec Ebx
		Test Ebx, Ebx
		Je LoadImageOnMap_End
		mov eax, DWord Ptr Ss:[Esp]
		mov edx, eax
		and edx, -4
		.if edx != eax ; Residue Code for non-4-times width
			and eax ,3
			neg eax
			Add Eax, 4
			Invoke SetFilePointer, Edi, Eax, 0H, FILE_CURRENT
		.EndIf
		Jmp LoadImageOnMap_Loop
	.EndIf
	Jmp LoadImageOnMap_Loop2

LoadImageOnMap_End: ; Restore attributes
	Mov Esi, DWord Ptr Ds:[Ebp + 74H]
	Mov Esi, DWord Ptr Ds:[Esi + ImageUnit * 4]
	Mov Byte Ptr Ds:[Esi + 0B4H], 0

LoadImageOnMap_Skip:
	Invoke CloseHandle, Edi
.EndIf
	Add Esp, 200H
	__EffectPostfix__


WAIForTyper:
	Mov Esi, Ss:[Esp + 18H] ; Source Player
	Mov Edx, [Esi + 74H]
	Mov Ebx, [Edi + 24H] ; Protounit

	Sub Esp, 20H
	Fild DWord Ptr Ds:[Edi + 50H]
	Fst DWord Ptr Ss:[Esp + 14H]
	Fstp DWord Ptr Ss:[Esp + 4H]
	Fild DWord Ptr Ds:[Edi + 4CH]
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
	Push 0 ; Mode:Techtree
	Mov Esi, DWord Ptr Ds:[Edi + 6CH]
	Sub Esp, 4H
	Jmp Modifier_Loop

; Object Modifier
; 0 - Set attribute
; 1 - Add attribute
; 2 - Set attribute by resource(by quantity)
Modifier:
	Lea Esi, [Esp + 94H]
	Mov Ebp, DWord Ptr Ds:[Esp + 10H]
	Cmp Ebp, Ebx
	Jle Modifier_

	Mov Ebx, Ebp
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
	Lea Esi, [Esp + 94H]
	push esi
	Mov Esi, DWord Ptr Ds:[Edi + 6CH]
	Sub Esp, 4H
Modifier_Loop:
	Xor Eax, Eax
	Xor Ecx, Ecx
	Mov Cl, Byte Ptr Ds:[Esi]
.While Cl >= '0' && Cl <= '9'
	Sub Cl, '0'
	IMul Eax, 10
	Add Eax, Ecx
	Inc Esi
	Mov Cl, Byte Ptr Ds:[Esi]
.EndW
	Mov DWord Ptr Ds:[Edi + 3CH], Eax
	Xor Eax, Eax
	Inc Esi
	Mov Cl, Byte Ptr Ds:[Esi]
	Xor Bl, Bl
.If Cl == '-'
	Mov Bl, 1
	Inc Esi
	Mov Cl, Byte Ptr Ds:[Esi]
.EndIf
.While Cl >= '0' && Cl <= '9'
	Sub Cl, '0'
	IMul Eax, 10
	Add Eax, Ecx
	Inc Esi
	Mov Cl, Byte Ptr Ds:[Esi]
.EndW
	Test Bl, Bl
.If !Zero?
	Neg Eax
.EndIf
	Mov DWord Ptr Ds:[Edi + 10H], Eax
	Mov DWord Ptr Ss:[Esp], Esi
	Mov Esi, DWord Ptr Ss:[Esp + 4H]

	Mov Ebx, DWord Ptr Ds:[Edi + 3CH] ; ebx = Attribute ID
	Mov Ecx, DWord Ptr Ss:[Esp + 20H] ; Player
	Push Ebp
	Push Esi

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
	Mov Eax, DWord Ptr Ss:[Esp + 8H]
	Test Eax, Eax
	.If !Zero?
		.If Bl < 70
			Mov Bl, 70
		.EndIf
	.EndIf
	Movzx Eax, Bl ; Min "Type"
	Push Eax
	Push Edx
	Shr Ebx, 8H
	Call DWord Ptr Ds:[Ebx * 4 + Offset Protounit_CallTable]

	Mov Esi, DWord Ptr Ss:[Esp]
	Mov Cl, Byte Ptr Ds:[Esi]
	Test Cl, Cl
	Je Modifier_End
.If Cl < '0' || Cl > '9'
	.Repeat
		Inc Esi
		Mov Cl, Byte Ptr Ds:[Esi]
	.Until Cl >= '0' && Cl <= '9'
	Jmp Modifier_Loop
.EndIf
Modifier_End:
	add esp, 8h
Modifier_:
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4


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
	Jle ChangeObject_
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
	Mov Ecx, DWord Ptr Ss:[Esp + 28H]
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
	Mov Ecx, DWord Ptr Ss:[Esp + 2cH]
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


; Instant Garrison
InstantGarrison:
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Xor Esi, Esi
	Cmp Eax, Ebx
	Jle InstantGarrison_Skip
	Lea Ebp, [Esp + 94H]
	Mov Esi, DWord Ptr Ss:[Esp + 10H]
	Mov Edx, DWord Ptr Ds:[Esp + 24H]
	Test Edx, Edx
.If !Zero?
	.Repeat
		Mov Ecx, DWord Ptr Ss:[Ebp]
		Mov Edx, DWord Ptr Ds:[Esp + 24H]
		Push Ecx
		Mov Eax, DWord Ptr Ds:[Edx]
		Mov Ecx, Edx
		Call DWord Ptr Ds:[Eax + 0E8H] ; 4D27A0H
		Add Ebp, 4H
		Dec Esi
	.Until Zero?
.EndIf
InstantGarrison_Skip:
	__EffectPostfix__


; Rotate Objects
; 0 - Set angle by degrees
; 1 - Add angle by degrees
; 2 - Set angle by image
; 3 - Add angle by image
; 4 - Set image angle by degrees
; 5 - Add image angle by degrees
; 6 - Set image angle by image
; 7 - Add image angle by image
; 8 - Set frame index
; 9 - Add frame index (won't be out of frames)
; In adding effects except 5, setting quantity to 0 leads a random result.
RotateUnit:
    Mov Ebp, [Esp + 10H]
    Cmp Ebp, Ebx
    Jle RotateUnit_Back
    Lea Ebx, [Esp + 94H]

	Mov Eax, [Edi + 64H]
	Mov Ecx, Eax
	Shr Eax, 1
	Cmp Eax, 4
	Je RotateUnit_Frame

	Push Ecx
	Push DWord Ptr Ds:[Edi + 10H]
	Test Byte Ptr Ds:[Esp + 4], 2
	Je RotateUnit_ByAngle

; === By Image ===

RotateUnit_II: ; Image By Image
	Mov Esi, [Ebx]
    Mov Edx, [Esi + 10H] ; Graphic
    Test Edx, Edx
.If !Zero?
	Mov Al, Byte Ptr Ds:[Esp]
	Test Byte Ptr Ds:[Esp + 4], 1
	.If !Zero?
		Test Al, Al
		.If Zero?
RotateUnit_3:
			FakeCall SUB_RANDOM
		.Else
			Add Al, Byte Ptr Ds:[Esi + 35H] ; Current Angle
		.EndIf
		Movzx Ax, Al
		Mov Cx, Word Ptr Ds:[Edx + 60H]
		Test Cx, Cx
		.If Zero?
			Xor Al, Al
		.Else
			Cwd
			IDiv Cx
			Mov Al, Dl
		.EndIf
	.EndIf
	Mov Byte Ptr Ds:[Esi + 35H], Al
.EndIf
    Add Ebx, 4
    Dec Ebp
    Jg RotateUnit_II

	Test Byte Ptr Ds:[Esp + 4], 4
	Jne RotateUnit_II_
	Lea Ebx, [Esp + 09CH]
	Mov Ebp, [Esp + 18H]
RotateUnit_AI: ; Angle By Image
	Mov Esi, [Ebx]
    Mov Edx, [Esi + 10H] ; Current Graphic
    Test Edx, Edx
.If !Zero?
	Cmp Word Ptr Ds:[Edx + 60H], 0
	.If !Zero?
		Movzx Eax, Byte Ptr Ds:[Esi + 35H]
		Push Eax
		Fild DWord Ptr Ss:[Esp]
		Fidiv Word Ptr Ds:[Edx + 60H]
		Fadd DWord Ptr Ds:[RotationDelta]
		Fldpi
		Fldpi
		Faddp St(1), St
		Fmulp St(1), St
		Fstp DWord Ptr Ss:[Esp]
		Mov Ecx, Esi
		Mov Eax, [Esi]
		Call DWord Ptr Ds:[Eax + 0C0H]
	.EndIf
.EndIf
    Add Ebx, 4
    Dec Ebp
    Jg RotateUnit_AI
RotateUnit_II_:
	Add Esp, 8H
RotateUnit_Back:
	__EffectPostfix__

RotateUnit_Frame:
	And Ecx, 1
	Push Ecx
    Push DWord Ptr Ds:[Edi + 10H]
RotateUnit_Frame_Loop:
    Mov Esi, [Ebx]
    Mov Eax, [Esi + 10H]
    Test Eax, Eax
.If !Zero?
	Mov Edx, DWord Ptr Ss:[Esp]
	Mov Ecx, DWord Ptr Ss:[Esp + 4]
	Test Ecx, Ecx
	.If !Zero?
		Test Edx, Edx
		.If Zero?
RotateUnit_1:
			FakeCall SUB_RANDOM
		.Else
			Mov Edi, Edx
			Mov Ecx, [Esi + 18H]
			Mov Edx, [Ecx]
			Mov Eax, [Esi + 10H]
			Push Eax
			Call DWord Ptr Ds:[Edx + 4]
			Add Eax, Edi
		.EndIf
		Mov Ecx, [Esi + 10H]
		Movzx Ecx, Word Ptr Ds:[Ecx + 5EH] ; Frame Count
		Test Ecx, Ecx
		.If Zero?
			Xor Edx, Edx
		.Else
			Cdq
			IDiv Ecx
		.EndIf
		Mov Eax, [Esi + 10H]
	.EndIf
	Mov Ecx, [Esi + 18H]
	Mov Edi, [Ecx]
	Push Edx
	Push Eax
	Call DWord Ptr Ds:[Edi + 1CH]
.EndIf
    Add Ebx, 4
    Dec Ebp
    Jg RotateUnit_Frame_Loop
    Add Esp, 8
RotateUnit_Frame_Back:
	__EffectPostfix__

RotateUnit_ByAngle: ; === By Angle ===
	Test Byte Ptr Ds:[Esp + 4], 4
	Je RotateUnit_AA_

RotateUnit_IA: ; Image By Angle
	Mov Esi, [Ebx]
    Mov Edx, [Esi + 10H] ; Graphic
    Test Edx, Edx
.If !Zero?
	Fild DWord Ptr Ds:[Esp]
	Fdiv DWord Ptr Ds:[Rate360]
	Fimul Word Ptr Ds:[Edx + 60H]
	Sub Esp, 4
	Fistp Word Ptr Ds:[Esp]
	Pop Eax
	Movsx Eax, Ax
	Test Byte Ptr Ds:[Esp + 4], 1
	.If !Zero?
		Xor Cx, Cx
		Movzx Cx, Byte Ptr Ds:[Esi + 35H]
		Add Ax, Cx
	.EndIf
	Mov Cx, Word Ptr Ds:[Edx + 60H]
	Test Cx, Cx
	.If Zero?
		Xor Al, Al
	.Else
		Cwd
		IDiv Cx
		Mov Al, Dl
	.EndIf
	Mov Byte Ptr Ds:[Esi + 35H], Al
.EndIf
    Add Ebx, 4
    Dec Ebp
    Jg RotateUnit_IA
	Add Esp, 8H
	__EffectPostfix__

RotateUnit_AA_: ; Angle By Angle
	Mov Eax, DWord Ptr Ss:[Esp]
	Mov Ecx, 360
	Cdq
	IDiv Ecx
	Mov DWord Ptr Ds:[Esp], Edx
	Fild DWord Ptr Ds:[Esp]
	Fdiv DWord Ptr Ds:[Rate360]
	Test Byte Ptr Ds:[Esp + 4], 1
	.If Zero? ; If is set
		Fadd DWord Ptr Ds:[RotationDelta]
	.EndIf
	Fldpi
	Fldpi
	Faddp St(1), St
	Fmulp St(1), St
	Fstp DWord Ptr Ss:[Esp]
RotateUnit_AA:
	Mov Esi, [Ebx]
    Mov Edx, [Esi + 10H] ; Graphic
    Test Edx, Edx
.If !Zero?
	Fld DWord Ptr Ss:[Esp]
	Test Byte Ptr Ss:[Esp + 4], 1
	.If !Zero? ; If is add
		Mov Eax, DWord Ptr Ss:[Esp]
		Mov Ecx, DWord Ptr Ds:[Edi + 10H]
		Test Ecx, Ecx
		.If Zero? ; If random!
RotateUnit_2:
			FakeCall SUB_RANDOM
			Mov Ecx, 360
			Cdq
			IDiv Ecx
			Sub Esp, 4
			Mov DWord Ptr Ss:[Esp], Edx
			Fstp St(0)
			Fild DWord Ptr Ss:[Esp]
			Pop Eax
			Fdiv DWord Ptr Ds:[Rate360]
			Fldpi
			Fldpi
			Faddp St(1), St
			Fmulp St(1), St
		.Else
			Fadd DWord Ptr Ds:[Esi + 94H]
			Fldz
			Fcomp
			Fstsw Ax
			Test Ah, 41H
			.If Zero? ; If St(0) < 0
				Fldpi
				Fldpi
				Faddp St(1), St
				Faddp St(1), St
			.Else
				Fldpi
				Fldpi
				Faddp St(1), St
				Fcom
				Fstsw Ax
				Test Ah, 01H
				.If !Zero? ; If St(0) >= 2pi
					Fsubp St(1), St
				.Else
					Fstp St(0)
				.EndIf
			.EndIf
		.EndIf
	.EndIf
	Sub Esp, 4
	Fstp DWord Ptr Ss:[Esp] ; Adjust Again
	Mov Ecx, Esi
	Mov Eax, [Esi]
	Call DWord Ptr Ds:[Eax + 0C0H]
.EndIf
    Add Ebx, 4
    Dec Ebp
    Jg RotateUnit_AA
	Add Esp, 8H
	__EffectPostfix__


; Play Internal Sound
; Play game sound by quantity. AI Signal determines civilization id.
; AI 255 is "chorus" - play all civ sounds at once.
; AI 256 chooses civs randomly.
PlayDrsSound:
	Mov Esi, DWord Ptr Ds:[Plc]
	Mov Esi, DWord Ptr Ds:[Esi + 424H]
	Mov Eax, DWord Ptr Ds:[Edi + 10H]
.If Eax < DWord Ptr Ds:[Esi + 38H]
	Mov Ecx, DWord Ptr Ds:[Esi + 3CH]
	Mov Ecx, DWord Ptr Ds:[Ecx + Eax * 4]
	Mov Edx, DWord Ptr Ds:[Edi + 0CH]
	Mov Ebp, DWord Ptr Ds:[Esi + 50H] ; Civ. count

	Cmp Edx, 255
	Je PlayDrsSound_Chorus
	Jg PlayDrsSound_Random
PlayDrsSound_Normal:
	Cmp Edx, Ebp
	Jge PlayDrsSound_Skip
	Jmp PlayDrsSound_
PlayDrsSound_Random:
	Push Ecx
PlayDrsSound_3: ; Random
	FakeCall SUB_RANDOM
	Cdq
	IDiv Ebp
	Pop Ecx

PlayDrsSound_:
	Or Eax, -1
	Push Eax
	Push Edx
	Push Ebx
	Push Ebx
	Push 1
PlayDrsSound_1:
	FakeCall 004DAC20H
.EndIf
PlayDrsSound_Skip:
	__EffectPostfix__

PlayDrsSound_Chorus:
	Mov Esi, Ecx
.Repeat
	Dec Ebp
	Or Eax, -1
	Push Eax
	Push Ebp
	Push Ebx
	Push Ebx
	Push 1
	Mov Ecx, Esi
PlayDrsSound_2:
	FakeCall 004DAC20H
	Test Ebp, Ebp
.Until Zero?
	__EffectPostfix__


; Attach Graphics on units
; Quantity - graphic id
; Number - layer, 0 to 4 is lower, 5 to 8 is higher than unit, 9 is remove
SetAttachGraphic:
	Mov Eax, DWord Ptr Ds:[Esp + 10H]
	Cmp Eax, Ebx
	Jle SetAttachGraphic_Skip
	Mov Ebp, Eax

	Mov Esi, DWord Ptr Ds:[Plc]
	Mov Esi, DWord Ptr Ds:[Esi + 424H]
	Mov Eax, DWord Ptr Ds:[Edi + 10H]
	Mov Ecx, DWord Ptr Ds:[Esi + 40H]
	Cmp Eax, Ecx
	Jae SetAttachGraphic_Remove
	Mov Ecx, DWord Ptr Ds:[Esi + 44H]
	Mov Esi, DWord Ptr Ds:[Ecx + Eax * 4]

	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Cmp Eax, 9
	Ja SetAttachGraphic_Skip
	Shl Eax, 1
	Lea Eax, [Eax * 4 + Eax + 10] ; EAX = (quantity+1) * 10
	Lea Edi, [Esp + 94H]
	Push Eax
.Repeat
	Mov Ecx, DWord Ptr Ds:[Edi]
	Mov Ecx, DWord Ptr Ds:[Ecx + 18H]
	Xor Edx, Edx
	Mov Eax, DWord Ptr Ds:[Esp]
	Push Edx
	Push Edx
	Push Edx
	Push Eax
	Push Esi
SetAttachGraphic_1:
	FakeCall 005ECD40H
	Add Edi, 4
	Dec Ebp
.Until Zero?
	Pop Eax
SetAttachGraphic_Skip:
	__EffectPostfix__

SetAttachGraphic_Remove: ; Remove Attachment
	Neg Eax
	Cmp Eax, Ecx
	Jae SetAttachGraphic_Skip
	Mov Ecx, DWord Ptr Ds:[Esi + 44H]
	Mov Esi, DWord Ptr Ds:[Ecx + Eax * 4]
	Lea Edi, [Esp + 94H]
.Repeat
	Mov Ecx, DWord Ptr Ds:[Edi]
	Mov Ecx, DWord Ptr Ds:[Ecx + 18H]
	Push Esi
SetAttachGraphic_2:
	FakeCall 005ECE00H
	Add Edi, 4
	Dec Ebp
.Until Zero?
	Jmp SetAttachGraphic_Skip


; Set terrain in area
SetTerrain:
	Mov Eax, DWord Ptr Ds:[Edi + 10H]
	Cmp Eax, DWord Ptr Ds:[00583A8BH]
	Jae SetTerrain_Skip
	Mov Esi, DWord Ptr Ds:[Plc]
	Mov Esi, DWord Ptr Ds:[Esi + 424H]
	Mov Esi, DWord Ptr Ds:[Esi + 34H]
	Push Esi ; = Terrain Ptr
	Mov Ebp, DWord Ptr Ds:[Esi + 04H]
	Push Eax ; = Terrain Id
	Mov Ebx, DWord Ptr Ds:[Edi + 4CH] ; Left
	Mov Ecx, Ebx
	Mov Eax, DWord Ptr Ds:[Edi + 50H] ; Top
	Push Eax ; Current Line
	IMul Eax, DWord Ptr Ds:[Esi + 08H]
	Add Eax, Ebx
	Shl Eax, 5H
	Lea Esi, [Eax + Ebp + 5H]
	Mov Eax, DWord Ptr Ss:[Esp + 4H]
	Mov Edx, DWord Ptr Ds:[Edi + 54H] ; Right Border
SetTerrain_Loop:
	Mov Byte Ptr Ds:[Esi], Al
	Add Esi, 20H
	Inc Ecx
	Cmp Ecx, Edx
	Jle SetTerrain_Loop
	Mov Eax, DWord Ptr Ss:[Esp]
	Cmp Eax, DWord Ptr Ds:[Edi + 58H] ; Bottom Border
	Jge SetTerrain_End
	Inc Eax
	Mov DWord Ptr Ss:[Esp], Eax

	Mov Eax, DWord Ptr Ss:[Esp + 08H] ; Terrain Ptr
	Mov Ecx, DWord Ptr Ds:[Eax + 08H]
	Mov Ebx, DWord Ptr Ds:[Edi + 4CH]
	Lea Ecx, [Ecx + Ebx - 1]
	Sub Ecx, Edx
	Shl Ecx, 5
	Add Esi, Ecx
	Mov Ecx, Ebx
	Mov Eax, DWord Ptr Ss:[Esp + 4H]
	Jmp SetTerrain_Loop
SetTerrain_End:
	Xor Esi, Esi
	Mov Ebp, DWord Ptr Ss:[Esp + 08H]
	Mov Eax, DWord Ptr Ss:[Esp + 04H]
	Push Esi
	Push Esi
	Push Eax
	Mov Edx, DWord Ptr Ds:[Edi + 58H]
	Push Edx
	Mov Ecx, DWord Ptr Ds:[Edi + 54H]
	Mov Eax, DWord Ptr Ds:[Edi + 50H]
	Mov Edx, DWord Ptr Ds:[Edi + 4CH]
	Push Ecx
	Push Eax
	Push Edx
	Push Esi
	Push Esi
	Mov Ecx, Ebp
SetTerrain_1:
	FakeCall 00585230H ; Adujst terrain blending
	Add Esp, 0CH
SetTerrain_Skip:
	__EffectPostfix__

;	Push Eax
;	Push 1
;	Push 5
;	Push 5
;	Push - 1
;	Push - 1
;	Mov Esi, DWord Ptr Ds:[Plc]
;	Mov Ecx, DWord Ptr Ds:[Esi + 424H]
;	Mov Ecx, DWord Ptr Ds:[Ecx + 34H]
;SetTerrain_1:
;	FakeCall 004614A0H
;	__EffectPostfix__


; Clone Object
; 0,1-Clone units at target point
; 2,3-Clone units at target point with offset(anchored by area left)
; 4,5-Clone units at target point with offset(anchored by area center)
; Odds would copy properties to new units
CloneObject:
    Mov Ebp, [Esp + 10H]
    Cmp Ebp, Ebx
    Jle CloneObject_Back
    Lea Esi, [Esp + 94H]
    Mov Ecx, DWord Ptr Ss:[Esp + 24H] ; Target unit
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
    Push Eax ; Flag
    Test Ecx, Ecx
.If Zero?
	Sub Esp, 8H
	Fild DWord Ptr Ds:[Edi + 48H]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp + 4H]
	Fild DWord Ptr Ds:[Edi + 44H]
	Fadd DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
.Else
	Mov Eax, DWord Ptr Ds:[Ecx + 38H]
	Mov Edx, DWord Ptr Ds:[Ecx + 3CH]
	Push Edx
	Push Eax
.EndIf
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Shr Eax, 1
	Test Eax, Eax
	Jg CloneObject_WithOffset
CloneObject_Loop:
	Push 1
	Push 0
	Mov Eax, DWord Ptr Ss:[Esp + 0CH]
	Mov Edx, DWord Ptr Ss:[Esp + 08H]
	Push Eax
	Push Edx
	Mov Ebx, DWord Ptr Ds:[Esi]
	Mov Ebx, DWord Ptr Ds:[Ebx + 8H]
	Movsx Eax, Word Ptr Ds:[Ebx + 10H]
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Esi]
	Mov Ecx, DWord Ptr Ds:[Ecx + 0CH] ; Player
CloneObject_1:
	FakeCall SUB_DROPUNIT
	Push Edi
	Mov Edi, Eax
	Mov Eax, DWord Ptr Ds:[Edi + 8H]
	Mov Ebx, DWord Ptr Ds:[Esi]
.If Byte Ptr Ds:[Eax + 4H] >= 70
	Mov Ecx, Edi
	Push Ebx
	Call CloneObject_CopyProp
.EndIf
	Test Byte Ptr Ss:[Esp + 0CH], 1
.If !Zero?
	Mov Ecx, Edi
	Push Ebx
	Call CloneObject_Adjust
.EndIf
	Pop Edi
	Add Esi, 4H
	Dec Ebp
	Jne CloneObject_Loop
	Add Esp, 0CH
CloneObject_Back:
	__EffectPostfix__

CloneObject_WithOffset: ; With Offset By Area Left
	Cmp Eax, 2
	Je CloneObject_WithOffset_Center
	Fld DWord Ptr Ss:[Esp + 4H]
	Fisub DWord Ptr Ds:[Edi + 50H]
	Fsub DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp + 4H]
	Fld DWord Ptr Ss:[Esp]
	Fisub DWord Ptr Ds:[Edi + 4CH]
	Fsub DWord Ptr Ds:[Float05]
	Fstp DWord Ptr Ss:[Esp]
CloneObject_2Loop:
	Push 1
	Push 0
	Sub Esp, 8H
	Mov Ebx, DWord Ptr Ds:[Esi]
	Fld DWord Ptr Ss:[Esp + 14H]
	Fadd DWord Ptr Ds:[Ebx + 3CH]
	Fstp DWord Ptr Ss:[Esp + 04H]
	Fld DWord Ptr Ss:[Esp + 10H]
	Fadd DWord Ptr Ds:[Ebx + 38H]
	Fstp DWord Ptr Ss:[Esp]

	Mov Ebx, DWord Ptr Ds:[Ebx + 8H]
	Movsx Eax, Word Ptr Ds:[Ebx + 10H]
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Esi]
	Mov Ecx, DWord Ptr Ds:[Ecx + 0CH] ; Player
CloneObject_2:
	FakeCall SUB_DROPUNIT
	Push Edi
	Mov Edi, Eax
	Mov Eax, DWord Ptr Ds:[Edi + 8H]
	Mov Ebx, DWord Ptr Ds:[Esi]
.If Byte Ptr Ds:[Eax + 4H] >= 70
	Mov Ecx, Edi
	Push Ebx
	Call CloneObject_CopyProp
.EndIf
	Test Byte Ptr Ss:[Esp + 0CH], 1
.If !Zero?
	Mov Ecx, Edi
	Push Ebx
	Call CloneObject_Adjust
.EndIf
	Pop Edi
	Add Esi, 4H
	Dec Ebp
	Jne CloneObject_2Loop
	Add Esp, 0CH
CloneObject_2Back:
	__EffectPostfix__

CloneObject_WithOffset_Center: ; With Offset By Area Center
	Fild DWord Ptr Ds:[Edi + 50H]
	Fiadd DWord Ptr Ds:[Edi + 58H]
	Fdiv DWord Ptr Ds:[Float2]
	Fadd DWord Ptr Ds:[Float05]
	Fsubr DWord Ptr Ss:[Esp + 4H]
	Fstp DWord Ptr Ss:[Esp + 4H]

	Fild DWord Ptr Ds:[Edi + 4CH]
	Fiadd DWord Ptr Ds:[Edi + 54H]
	Fdiv DWord Ptr Ds:[Float2]
	Fadd DWord Ptr Ds:[Float05]
	Fsubr DWord Ptr Ss:[Esp]
	Fstp DWord Ptr Ss:[Esp]
	Jmp CloneObject_2Loop

; Adjust angle, hp and storage (ecx=source, arg1=reference)
CloneObject_Adjust:
	Push Edi
	Push Esi
	Mov Edi, Ecx
	Mov Esi, DWord Ptr Ss:[Esp + 0CH]
	Mov Eax, DWord Ptr Ds:[Esi + 30H] ; HP
	Mov DWord Ptr Ds:[Edi + 30H], Eax
	Mov Al, Byte Ptr Ds:[Esi + 35H] ; Image Angle
	Mov Byte Ptr Ds:[Edi + 35H], Al
	Mov Eax, DWord Ptr Ds:[Esi + 44H] ; Resource Quantity
	Mov DWord Ptr Ds:[Edi + 44H], Eax
	Mov Ax, Word Ptr Ds:[Esi + 4CH] ; Resource Type
	Mov Word Ptr Ds:[Edi + 4CH], Ax
	Mov Eax, DWord Ptr Ds:[Esi + 94H] ; Rotation
	Mov DWord Ptr Ds:[Edi + 94H], Eax

	Mov Eax, DWord Ptr Ds:[Esi + 10H]
.If Eax == DWord Ptr Ds:[Edi + 10H]
	Push Eax
	Mov Ecx, DWord Ptr Ds:[Esi + 18H]
	Mov Edx, [Ecx]
	Call DWord Ptr Ds:[Edx + 4H] ; Get Frame
	Push Eax
	Push DWord Ptr Ds:[Edi + 10H]
	Mov Ecx, DWord Ptr Ds:[Edi + 18H]
	Mov Edx, [Ecx]
	Call DWord Ptr Ds:[Edx + 1CH] ; Set Frame
.EndIf
	Pop Esi
	Pop Edi
	Retn 4

; Copy Protounit Attributes (ecx=source, arg1=reference)
; Tasks and Damage Graphics are not copied
CloneObject_CopyProp:
	Push Edi
	Push Esi
	Push Ebp
	Push Ebx
	Mov Edi, Ecx
	Mov Esi, DWord Ptr Ss:[Esp + 14H]
	Mov Ebx, DWord Ptr Ds:[Edi + 8H]
	Cmp Ebx, DWord Ptr Ds:[Esi + 8H]
	Je CloneObject_CopyProp_Skip
	Mov Ecx, Edi
CloneObject_3:
	FakeCall SUB_UNIQUEUNIT
	Mov Esi, DWord Ptr Ds:[Esi + 8H]
	Mov Edi, DWord Ptr Ds:[Edi + 8H]
	Mov Edx, DWord Ptr Ds:[Esi + 8H]
	Push Edx
	Lea Ecx, [Edi + 8H]
	Push Ecx
CloneObject_4:
	FakeCall 00568590H ; Set Name
	Add Esp, 8H

	Mov Ax, Word Ptr Ds:[Esi + 124H] ; Default Armor
	Mov Word Ptr Ds:[Edi + 124H], Ax

	Movsx Ebp, Word Ptr Ds:[Edi + 126H] ; Armors
	Test Ebp, Ebp
	Jle CloneObject_NoArmor
.If Bp == Word Ptr Ds:[Esi + 126H]
	Mov Ecx, DWord Ptr Ds:[Esi + 128H]
	Mov Edx, DWord Ptr Ds:[Edi + 128H]
	.Repeat
		Mov Eax, DWord Ptr Ds:[Ecx]
		Mov DWord Ptr Ds:[Edx], Eax
		Add Ecx, 4
		Add Edx, 4
		Dec Ebp
	.Until Zero?
.EndIf
CloneObject_NoArmor:
	Movsx Ebp, Word Ptr Ds:[Edi + 12CH] ; Attacks
	Test Ebp, Ebp
	Jle CloneObject_NoAttack
.If Bp == Word Ptr Ds:[Esi + 12CH]
	Mov Ecx, DWord Ptr Ds:[Esi + 130H]
	Mov Edx, DWord Ptr Ds:[Edi + 130H]
	.Repeat
		Mov Eax, DWord Ptr Ds:[Ecx]
		Mov DWord Ptr Ds:[Edx], Eax
		Add Ecx, 4
		Add Edx, 4
		Dec Ebp
	.Until Zero?
.EndIf

CloneObject_NoAttack:
	Mov Ebp, 1B8H ; Copy the other attributes
.If Byte Ptr Ds:[Edi + 4H] == 80
	Mov Ebp, 218H
.EndIf
	Mov Ecx, 08H
CloneObject_CopyProp_Loop:
	Mov Eax, DWord Ptr Ds:[Esi + Ebp]
	Mov DWord Ptr Ds:[Edi + Ebp], Eax
.If Ebp == 134H ; Attack & Armor
	Sub Ebp, 14H
.ElseIf Ebp == 100H || Ebp == 0A0H ; Tasks & Damage Graphics
	Sub Ebp, 8H
.Else
	Sub Ebp, 4H
.EndIf
	Cmp Ebp, Ecx
	Ja CloneObject_CopyProp_Loop

CloneObject_CopyProp_Skip:
	Pop Ebx
	Pop Ebp
	Pop Esi
	Pop Edi
	Retn 4


; Change Object Id
; 0 - Set all same ids
; 1 - Set ids increased by 1 or -1 (determined by sign of quantiy)
ChangeObjectId:
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Cmp Eax, Ebx
	Jle ChangeObjectId_Skip
	Lea Ebp, [Esp + 94H]
	Mov Esi, DWord Ptr Ss:[Esp + 10H]
	Test Esi, Esi
.If !Zero?
	Mov Eax, DWord Ptr Ds:[Edi + 10H]
	.Repeat
		Mov Ecx, DWord Ptr Ss:[Ebp]
		Mov DWord Ptr Ds:[Ecx + 4], Eax
		Cmp DWord Ptr Ds:[Edi + 64H], 0
		.If !Zero?
			Cmp Eax, 0
			Jl ChangeObjectId_Nega
			Inc Eax
			Jmp ChangeObjectId_
ChangeObjectId_Nega:
			Dec Eax
ChangeObjectId_:
		.EndIf
		Add Ebp, 4H
		Dec Esi
	.Until Zero?
.EndIf
ChangeObjectId_Skip:
	__EffectPostfix__


;; <NOT USED, REPLACED BY SHIFT OBJECT>
;; Change Object Height (Type 70+ Only)
;; 0 - Set Height(rated by 0.01)
;; 1 - Add Height
;ChangeObjectHeight:
;	Mov Esi, DWord Ptr Ss:[Esp + 10H]
;	Cmp Esi, Ebx
;	Jle ChangeObjectHeight_Skip
;	Lea Ebp, [Esp + 94H]
;	Fild DWord Ptr Ds:[Edi + 10H]
;	Fdiv DWord Ptr Ds:[Float100]
;	Sub Esp, 4H
;	Fstp DWord Ptr Ds:[Esp]
;	.Repeat
;		Mov Ecx, DWord Ptr Ss:[Ebp]
;		Mov Eax, DWord Ptr Ds:[Ecx + 8H]
;		.If Byte Ptr Ds:[Eax + 4] >= 70
;			Fld DWord Ptr Ds:[Esp]
;			Cmp DWord Ptr Ds:[Edi + 64H], 0
;			.If !Zero?
;				 Fadd DWord Ptr Ds:[Ecx + 40H]
;			.EndIf
;			;Fstp DWord Ptr Ds:[Ecx + 40H]
;
;			Sub Esp, 4H
;			Fstp DWord Ptr Ss:[Esp]
;			Push [Ecx + 3CH]
;			Push [Ecx + 38H]
;ChangeObjectHeight_1:
;			FakeCall SUB_TELEPORT
;		.EndIf
;		Add Ebp, 4H
;		Dec Esi
;	.Until Zero?
;	Add Esp, 4H
;ChangeObjectHeight_Skip:
;	__EffectPostfix__


; Task Objects By Certain Direction
; Number decides distance, measured by grid. 0 is by their speed.
; Quantity is direciton. -1 is by their own dirs
TaskObjectByDirection:
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Cmp Eax, Ebx
	Jle TaskObjectByDirection_Skip
	Lea Ebp, [Esp + 94H]
	Mov Esi, DWord Ptr Ss:[Esp + 10H]
	Test Esi, Esi
.If !Zero?
	Cmp DWord Ptr Ds:[Edi + 10H], 0
	Jl TaskObjectByDirection_Own
	Fild DWord Ptr Ds:[Edi + 10H]
	Fdiv DWord Ptr Ds:[Rate360]
	Fadd DWord Ptr Ds:[RotationDelta]
	Fldpi
	Fldpi
	Faddp St(1), St
	Fmulp St(1), St
	Sub Esp, 0CH
	Fst DWord Ptr Ss:[Esp] ; Angle
	Fsin
	Fstp DWord Ptr Ds:[Esp + 4] ; Sine
	Fld DWord Ptr Ss:[Esp]
	Fcos
	Fstp DWord Ptr Ds:[Esp + 8] ; Cosine
	.Repeat
		Mov Ecx, DWord Ptr Ss:[Ebp]
		Mov Eax, DWord Ptr Ds:[Ecx + 8H]
		.If Byte Ptr Ds:[Eax + 4] >= 70
			Mov Edx, DWord Ptr Ds:[Edi + 64H] ; Number
			Test Edx, Edx
			.If Zero?
				Fld DWord Ptr Ds:[Eax + 0C8H]
			.Else
				Fild DWord Ptr Ds:[Edi + 64H]
			.EndIf
			Fstp DWord Ptr Ss:[Esp]

			Push 0
			Push Ecx
			Fld DWord Ptr Ss:[Esp + 0CH]
			Fmul DWord Ptr Ss:[Esp + 8H]
			Fadd DWord Ptr Ds:[Ecx + 3CH]
			Fstp DWord Ptr Ss:[Esp]
			Push Ecx
			Fld DWord Ptr Ss:[Esp + 14H]
			Fmul DWord Ptr Ss:[Esp + 0CH]
			Fadd DWord Ptr Ds:[Ecx + 38H]
			Fstp DWord Ptr Ss:[Esp]
			Push 0 ; Target
			Mov Edx, [Ecx]
			Call DWord Ptr Ds:[Edx + 0A0H]

		.EndIf
		Add Ebp, 4H
		Dec Esi
	.Until Zero?
	Add Esp, 0CH
.EndIf
TaskObjectByDirection_Skip:
	__EffectPostfix__

TaskObjectByDirection_Own:
	Sub Esp, 4H
.Repeat
	Mov Ecx, DWord Ptr Ss:[Ebp]
	Mov Eax, DWord Ptr Ds:[Ecx + 8H]
	.If Byte Ptr Ds:[Eax + 4] >= 70
		Mov Edx, DWord Ptr Ds:[Edi + 64H] ; Number
		Test Edx, Edx
		.If Zero?
			Fld DWord Ptr Ds:[Eax + 0C8H]
		.Else
			Fild DWord Ptr Ds:[Edi + 64H]
		.EndIf
		Fstp DWord Ptr Ss:[Esp]

		Push 0
		Push Ecx
		Fld DWord Ptr Ds:[Ecx + 94H]
		Fsin
		Fmul DWord Ptr Ss:[Esp + 8H]
		Fadd DWord Ptr Ds:[Ecx + 3CH]
		Fstp DWord Ptr Ss:[Esp]
		Push Ecx
		Fld DWord Ptr Ds:[Ecx + 94H]
		Fcos
		Fmul DWord Ptr Ss:[Esp + 0CH]
		Fadd DWord Ptr Ds:[Ecx + 38H]
		Fstp DWord Ptr Ss:[Esp]
		Push 0 ; Target
		Mov Edx, [Ecx]
		Call DWord Ptr Ds:[Edx + 0A0H]
	.EndIf
	Add Ebp, 4H
	Dec Esi
.Until Zero?
	Add Esp, 4H
	Jmp TaskObjectByDirection_Skip


; Shift Objects By Pattern "X,Y,Z" By 0.01
; Number determines which value is set instead of add.
ShiftObject:
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Cmp Eax, Ebx
	Jle ShiftObject_Skip
	Sub Esp, 10H
	Lea Edx, [Esp] ; Load Figures
	Lea Eax, [Esp + 4]
	Lea Ecx, [Esp + 8]
	Push Ecx
	Push Eax
	Push Edx
	Push Offset ShiftPattern
	Mov Esi, DWord Ptr Ds:[Edi + 6CH]
	Push Esi
ShiftObject_1:
	FakeCall 0061567CH
	Add Esp, 14H
	Mov Ebp, Eax
	Xor Eax, Eax
.If Ebp < 3
	Mov DWord Ptr Ss:[Esp + 8H], Eax
	.If Ebp < 2
		Mov DWord Ptr Ss:[Esp + 4H], Eax
		.If Ebp < 1
			Jmp ShiftObject_Skip
		.EndIf
	.EndIf
.EndIf
	Fild DWord Ptr Ss:[Esp]
	Fmul QWord Ptr Ds:[6374D8H] ; =0.01
	Fstp DWord Ptr Ss:[Esp]
	Fild DWord Ptr Ss:[Esp + 4H]
	Fmul QWord Ptr Ds:[6374D8H]
	Fstp DWord Ptr Ss:[Esp + 4H]
	Fild DWord Ptr Ss:[Esp + 8H]
	Fmul QWord Ptr Ds:[6374D8H]
	Fstp DWord Ptr Ss:[Esp + 8H]

	Lea Ebp, [Esp + 0A4H]
	Mov Esi, DWord Ptr Ss:[Esp + 20H]
	Mov Bl, Byte Ptr Ds:[Edi + 64H] ; Type Flags
	.Repeat
		Mov Ecx, DWord Ptr Ss:[Ebp]
		Mov Eax, DWord Ptr Ds:[Ecx + 8H]
		.If Byte Ptr Ds:[Eax + 4] >= 70
			Sub Esp, 0CH
			Fld DWord Ptr Ss:[Esp + 14H]
			Test Bl, 4
			.If Zero?
				Fadd DWord Ptr Ds:[Ecx + 40H]
			.EndIf
			Fstp DWord Ptr Ss:[Esp + 8H]
			Fld DWord Ptr Ss:[Esp + 10H]
			Test Bl, 2
			.If Zero?
				Fadd DWord Ptr Ds:[Ecx + 3CH]
			.EndIf
			Fstp DWord Ptr Ss:[Esp + 4H]
			Fld DWord Ptr Ss:[Esp + 0CH]
			Test Bl, 1
			.If Zero?
				Fadd DWord Ptr Ds:[Ecx + 38H]
			.EndIf
			Fstp DWord Ptr Ss:[Esp]
ShiftObject_2:
			FakeCall SUB_TELEPORT
		.EndIf
		Add Ebp, 4H
		Dec Esi
	.Until Zero?
	Add Esp, 10H
ShiftObject_Skip:
	__EffectPostfix__


PlayAnimation:
	Mov Esi, DWord Ptr Ss:[Esp + 20H]
	Test Esi, Esi
	Je PlayAnimation_Skip
	Mov Ecx, [Esi + 8CH]
	Mov Eax, DWord Ptr Ds:[Edi + 3CH]
	.If Eax < [Ecx + 40H]
		Mov Edx, [Ecx + 44H]
		Mov Ebp, [Edx + Eax * 4]
		Test Ebp, Ebp
		Je PlayAnimation_Skip

		Push - 1
		Push - 1
		Push 0
		Push 0 ; Direction

		Mov Ebx, DWord Ptr Ds:[Edi + 28H]
		.If Ebx == -1
			Push 0
			Sub Esp, 8H
			Fild DWord Ptr Ds:[Edi + 44H]
			Fstp DWord Ptr Ss:[Esp]
			Fild DWord Ptr Ds:[Edi + 48H]
			Fstp DWord Ptr Ss:[Esp + 4]
		.Else
			Mov Ebx, DWord Ptr Ss:[Esp + 34H]
			Test Ebx, Ebx
			.If Zero?
				Add Esp, 10H
				Jmp PlayAnimation_Skip
			.EndIf
			Mov Edx, [Ebx + 38H]
			Mov Eax, [Ebx + 3CH]
			Mov Ecx, [Ebx + 40H]
			Push Ecx
			Push Eax
			Push Edx
		.EndIf
		Push Ebp ; Animation Addr
		Mov Ecx, [Esi + 8CH]
		Mov Ecx, [Ecx + 70H]
PlayAnimation_1:
		FakeCall 004D5890H
	.EndIf
PlayAnimation_Skip:
	__EffectPostfix__



; ==== Conditions ====


__ConditionPostfix__ Macro
	Pop Edi
    Pop Esi
    Pop Ebp
    Pop Ebx
    Add Esp, 0CH
    Retn 8
EndM


; On start or load scenario: By checking gaia OLD-ACADMY's extra attribute - Flying Mode+1
; To make it available only at saved loading, please make another trigger with this condition to enable the looped one.
TestCondition:
	Mov Ecx, DWord Ptr Ds:[Plc]
	Mov Ecx, DWord Ptr Ds:[Ecx + 424H]
	Mov Eax, DWord Ptr Ds:[Ecx + 4CH]
	Mov Edi, DWord Ptr Ds:[Eax] ; GAIA
	Xor Eax, Eax
	Test Edi, Edi
.If !Zero?
	Mov Edx, DWord Ptr Ds:[Edi + 74H]
	Mov Ecx, DWord Ptr Ds:[Edx] ; OLD-ACADMY
	Test Ecx, Ecx
	.If !Zero?
		Mov Bl, Byte Ptr Ds:[Ecx + 71H] ; Flying Mode+1 := 255
		And Dl, -1
		Cmp Bl, Dl
		Mov Byte Ptr Ds:[Ecx + 71H], Dl
		Setne Al
	.EndIf
.EndIf
	__ConditionPostfix__


; Key Pressed (SP Only)
KeyIsDown:
    Mov Ecx, DWord Ptr Ds:[Plc]
KeyIsDown_1:
    FakeCall 005EAE90H
    Test Eax, Eax
.If Zero?
    Mov Ecx, DWord Ptr Ds:[Esi + 0CH]
	Invoke GetKeyState, Ecx
	Mov Edx, Eax
	Xor Eax, Eax
	Test Dx, Dx
	Setl Al
.Else
	Xor Eax, Eax
.EndIf
	__ConditionPostfix__


; Units near Objects (Including self)
; Quantity = Distance * 65536 + Count (max 65535)
UnitsNearObjects:
	Mov Ecx, DWord Ptr Ss:[Esp + 24H] ; Player
	Test Ecx, Ecx
	Je UnitsNearObjects_Skip
	Mov Edi, DWord Ptr Ds:[Ecx + 78H]
	Mov Eax, DWord Ptr Ds:[Edi + 8H] ; Player Units Count
	Test Eax, Eax
	Je UnitsNearObjects_Skip ; eax == 0 at here

	Mov Edi, DWord Ptr Ds:[Edi + 4H] ; Units Table
	Mov Ebp, DWord Ptr Ss:[Esp + 18H] ; Next Object
	Mov Ebx, Eax
	Xor Ecx, Ecx
	Movzx Eax, Word Ptr Ds:[Esi + 0EH] ; Upper 16-bits as distance
	Push Eax ; Min-distance
	Push Ecx
.Repeat
	Mov Ecx, DWord Ptr Ds:[Edi] ; Unit
	Mov Eax, DWord Ptr Ds:[Ecx + 8H] ; Unit Group Check
	Mov Dx, Word Ptr Ds:[Esi + 1CH]
	Cmp Dx, 0
	Jl UnitsNearObjects_NoUnit
	Cmp Dx, Word Ptr Ds:[Eax + 10H] ; ID
	Jne UnitsNearObjects_LoopSkip
	Jmp UnitsNearObjects_
UnitsNearObjects_NoUnit:
	Mov Dx, Word Ptr Ds:[Esi + 40H]
	Cmp Dx, 0
	Jl UnitsNearObjects_NoClass
	Cmp Dx, Word Ptr Ds:[Eax + 16H] ; Class
	Jne UnitsNearObjects_LoopSkip
	Jmp UnitsNearObjects_
UnitsNearObjects_NoClass:
	Mov Dl, Byte Ptr Ds:[Esi + 44H]
	Cmp Dl, 0
	Jl UnitsNearObjects_
	Cmp Dl, Byte Ptr Ds:[Eax + 94H] ; SubType
	Jne UnitsNearObjects_LoopSkip

UnitsNearObjects_:
	Fld DWord Ptr Ds:[Ebp + 38H]
	Fsub DWord Ptr Ds:[Ecx + 38H] ; X Delta
	Fld DWord Ptr Ds:[Ebp + 3CH]
	Fsub DWord Ptr Ds:[Ecx + 3CH] ; Y Delta

	Mov Ecx, DWord Ptr Ds:[Ecx + 8H] ; Unit Data
	Mov Edx, DWord Ptr Ds:[Ebp + 8H] ; Next Unit Data
	Fabs
	Fisub DWord Ptr Ss:[Esp + 4H]
	Fsub DWord Ptr Ds:[Float0001] ; Tolerance
	Fsub DWord Ptr Ds:[Ecx + 38H]
	Fsub DWord Ptr Ds:[Edx + 38H] ; Y Size
	Fldz
	Fcompp
	Fstsw Ax
	Test Ah, 41H
	.If Zero? ; If <= 0
		Fabs
		Fisub DWord Ptr Ss:[Esp + 4H]
		Fsub DWord Ptr Ds:[Float0001] ; Tolerance
		Fsub DWord Ptr Ds:[Ecx + 34H]
		Fsub DWord Ptr Ds:[Edx + 34H] ; X Size
		Fldz
		Fcompp
		Fstsw Ax
		Test Ah, 41H
		.If Zero? ; If <= 0
			Mov Eax, DWord Ptr Ss:[Esp]
			Inc Eax
			Mov DWord Ptr Ss:[Esp], Eax
		.EndIf
	.Else
		Fstp St
	.EndIf

UnitsNearObjects_LoopSkip:
	Add Edi, 4H
	Dec Ebx
.Until Zero?
	Pop Ebx
	Pop Edx
	Movzx Edx, Word Ptr Ds:[Esi + 0CH] ; Lower 16-bits as count
	Cmp Ebx, Edx
	Setns Al
UnitsNearObjects_Skip:
	__ConditionPostfix__


; Object Facing to
; If quantity is between 0 and 359, check if direction of the object equals to it (clockwise).
; Else, object faces equals to next object add quantity.
; Timer is tolerance.
ObjectFacingTo:
	Sub Esp, 4H
	Mov Edi, DWord Ptr Ss:[Esp + 18H] ; Object
	Test Edi, Edi
.If !Zero?
	Fld DWord Ptr Ds:[Edi + 94H]
	Mov Ax, Word Ptr Ds:[Esi + 0CH]
	.If Ax >= 360 ; Not Between 0 and 359
		Mov Eax, DWord Ptr Ss:[Esp + 1CH]
		Test Eax, Eax
		.If Zero?
			Fstp St
			Jmp ObjectFacingTo_Skip
		.EndIf
		Fsub DWord Ptr Ds:[Eax + 94H]
	.EndIf
	Fldpi
	Fldpi
	Faddp St(1), St
	Fdivp St(1), St
	Fmul DWord Ptr Ds:[Rate360]
	Fistp Word Ptr Ss:[Esp]
	Pop Eax
	Mov Dx, Word Ptr Ds:[Esi + 0CH] ; Quantity
	Sub Ax, Dx
	.If Dx < 360
		Sub Ax, 45
	.EndIf
	Mov Cx, 360
	Cwd
	IDiv Cx
	Cmp Dx, 0
	Jge ObjectFacingTo_
	Neg Dx
ObjectFacingTo_:
	.If Dx > 180
		Mov Cx, 360
		Sub Cx, Dx
		Mov Dx, Cx
	.EndIf
	Cmp Dx, Word Ptr Ds:[Esi + 28H] ; Timer
	Setle Al
.Else
ObjectFacingTo_Skip:
	Xor Al, Al
.EndIf
	__ConditionPostfix__



End DllEntryPoint
