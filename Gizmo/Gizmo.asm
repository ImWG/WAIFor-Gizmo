;EasyCodeName=Gizmo,1
Include	Defines.inc

.Const

; Keys For DLL Interfaces
Gizmo_KeyEffectCount   DB 'EffectCount', 0
Gizmo_KeyEffectNames   DB 'EffectNames', 0
Gizmo_KeyEffectInputs  DB 'EffectInputs', 0
Gizmo_KeyEffects       DB 'Effects', 0
Gizmo_KeyConditionCount  DB 'ConditionCount', 0
Gizmo_KeyConditionNames  DB 'ConditionNames', 0
Gizmo_KeyConditionInputs DB 'ConditionInputs', 0
Gizmo_KeyConditions      DB 'Conditions', 0

Gizmo_KeyPatches         DB 'Patches', 0
Gizmo_KeyAddress         DB 'Addresses', 0
Gizmo_KeyAddress2        DB 'Addresses2', 0
Gizmo_KeyDirectAddresses DB 'DirectAddresses', 0
Gizmo_KeyJumps           DB 'Jumps', 0

; Conditions and Effects
MAX_COUNT Equ 256
Gizmo_EffectList@   Equ 007DD41FH
Gizmo_EffectSpace@  Equ 007DD20CH
Gizmo_EffectSpace2@ Equ 007DD275H
Gizmo_EffectInputs@ Equ 007D8DFBH
Gizmo_Effect@       Equ 004375F8H
;Gizmo_ConditionList@
Gizmo_ConditionSpace@  Equ Offset Gizmo_A_ConditionSpace + 1  ;007DD205H
Gizmo_ConditionSpace2@ Equ Offset Gizmo_A_ConditionSpace2 + 2 ;007DD248H
;Gizmo_ConditionInputs@ Equ 004399F0h
Gizmo_Condition@       Equ 00436B38H

; Adaptions
Gizmo_A_ConditionOrigin@ Equ 007DD205H
Gizmo_A_ConditionList@   Equ 004E1F4AH
Gizmo_A_ConditionSpace@  Equ 007DD204H
Gizmo_A_ConditionSpace2@ Equ 007DD246H
Gizmo_A_ConditionInputs@ Equ 007E2096H


.Data?

Gizmo_EffectCount  DD ?
Gizmo_EffectOrigin DD ? ; = #Effects + 1
Gizmo_ConditionCount  DD ?
Gizmo_ConditionOrigin DD ? ; = #Conditions + 1


.Data

Gizmo_Addresses DD Offset Gizmo_1, Offset Gizmo_2, Offset Gizmo_3, Offset Gizmo_4
	DD Offset Gizmo_A_1, Offset Gizmo_A_2, Offset Gizmo_A_3, Offset Gizmo_A_4, Offset Gizmo_A_5
	DD 0
Gizmo_Addresses2 DD Offset Gizmo_01, Offset Gizmo_02, Offset Gizmo_A_01, 0

String DB MAX_COUNT Dup(0)

Gizmo_TableEffectNames  DD MAX_COUNT Dup(0)
Gizmo_TableEffectInputs DD MAX_COUNT * 2 Dup(0)
Gizmo_TableEffects      DD MAX_COUNT Dup(0)
Gizmo_TableConditionNames  DD MAX_COUNT Dup(0)
Gizmo_TableConditionInputs DD MAX_COUNT * 2 Dup(0)
Gizmo_TableConditions      DD MAX_COUNT Dup(0)


.Code


; ==== Related to Effects ====

Gizmo_EffectList: ; 007DD420H
	Push Esi
	Push Ebx
	Push Ebp
	Mov Ebp, DWord Ptr Ds:[Edi + 0DF4H]
	Mov Ebx, Gizmo_EffectOrigin
	Mov Esi, Offset Gizmo_TableEffectNames

.While DWord Ptr Ds:[Esi] != 0
	Push Ebx
	Mov Eax, DWord Ptr Ds:[Esi]
	Push Eax
Gizmo_2:
	FakeCall 00550840H
	Inc Ebx
	Add Esi, 4
	Mov Ecx, Ebp
.EndW

	Pop Ebp
	Pop Ebx
	Pop Esi
Gizmo_1:
	FakeJmp 004E1F10H


Gizmo_EffectInputs: ; ESI = Source, [ESI+0c] = Input Table addr.
	Push Esi
	Push Ebx
	Push Ebp
	Push Eax
	Mov Eax, Gizmo_EffectCount
	Push Eax
	Mov Esi, DWord Ptr Ds:[Esi + 0CH]
	Mov Ebx, Gizmo_EffectOrigin
	Lea Esi, [Esi + Ebx * 4]
	Mov Ebx, Offset Gizmo_TableEffectInputs

.While DWord Ptr Ds:[Esp] != 0
	Mov Ebp, DWord Ptr Ds:[Esi]

	Mov Edx, DWord Ptr Ds:[Ebx] ; Optional Inputs
	Xor Eax, Eax
	.Repeat
		Test Edx, 1
		.If !Zero?
			Mov Byte Ptr Ds:[Ebp + Eax], 2
		.EndIf
		Shr Edx, 1
		Inc Eax
	.Until Edx == 0

	Add Ebx, 4H
	Mov Edx, DWord Ptr Ds:[Ebx] ; Necessary Inputs
	Xor Eax, Eax
	.Repeat
		Test Edx, 1
		.If !Zero?
			Mov Byte Ptr Ds:[Ebp + Eax], 1
		.EndIf
		Shr Edx, 1
		Inc Eax
	.Until Edx == 0

	Add Ebx, 4H
	Add Esi, 4H
	Mov Eax, [Esp]
	Dec Eax
	Mov [Esp], Eax
.EndW

	Add Esp, 4H
	Pop Eax
	Pop Ebp
	Pop Ebx
	Pop Esi
Gizmo_3:
	FakeJmp 00439835H


Gizmo_Effect:
	Sub Eax, Gizmo_EffectOrigin
	Inc Eax
	Cmp Eax, Gizmo_EffectCount
Gizmo_01:
	FakeJae 00437FDAH
	Jmp DWord Ptr Ds:[Offset Gizmo_TableEffects + Eax * 4]



Gizmo_A_ConditionList:
	Push Esi
	Push Ebx
	Push Ebp
	Mov Ebp, DWord Ptr Ds:[Edi + 0DECH]
	Mov Ebx, Gizmo_ConditionOrigin
	Mov Esi, Offset Gizmo_TableConditionNames

.While DWord Ptr Ds:[Esi] != 0
	Mov Ecx, Ebp
	Push Ebx
	Mov Eax, DWord Ptr Ds:[Esi]
	Push Eax
Gizmo_4:
	FakeCall 00550840H
	Inc Ebx
	Add Esi, 4
.EndW

	Pop Ebp
	Pop Ebx
	Pop Esi
	Mov Ecx, DWord Ptr Ds:[Edi + 0DECH]
Gizmo_A_5:
	FakeJmp 004E1F50H


Gizmo_A_ConditionSpace:
	Push 11111111H
Gizmo_A_1:
	FakeCall 006137B0H
Gizmo_A_2:
	FakeJmp 007DD20BH

Gizmo_A_ConditionSpace2:
	Cmp Edi, 11111111H
Gizmo_A_01:
	FakeJl 007DD220H
Gizmo_A_3:
	FakeJmp 007DD24BH

Gizmo_A_ConditionInputs:

	Push Esi
	Push Ebx
	Push Ebp
	Push Eax
	Push Edx
	Push Ecx
	Mov Eax, Gizmo_ConditionCount
	Push Eax
	Mov Esi, DWord Ptr Ds:[Esi + 08H]
	Mov Ebx, Gizmo_ConditionOrigin
	Lea Esi, [Esi + Ebx * 4]
	Mov Ebx, Offset Gizmo_TableConditionInputs

.While DWord Ptr Ds:[Esp] != 0
	Mov Ebp, DWord Ptr Ds:[Esi]

	Mov Edx, DWord Ptr Ds:[Ebx] ; Optional Inputs
	Xor Eax, Eax
	.Repeat
		Test Edx, 1
		.If !Zero?
			Mov Byte Ptr Ds:[Ebp + Eax], 2
		.EndIf
		Shr Edx, 1
		Inc Eax
	.Until Edx == 0

	Add Ebx, 4H
	Mov Edx, DWord Ptr Ds:[Ebx] ; Necessary Inputs
	Xor Eax, Eax
	.Repeat
		Test Edx, 1
		.If !Zero?
			Mov Byte Ptr Ds:[Ebp + Eax], 1
		.EndIf
		Shr Edx, 1
		Inc Eax
	.Until Edx == 0

	Add Ebx, 4H
	Add Esi, 4H
	Mov Eax, [Esp]
	Dec Eax
	Mov [Esp], Eax
.EndW

	Add Esp, 4H
	Pop Ecx
	Pop Edx
	Pop Eax
	Pop Ebp
	Pop Ebx
	Pop Esi
Gizmo_A_4:
	FakeJmp 00439DE4H


Gizmo_Condition:
	Sub Eax, Gizmo_ConditionOrigin
	Inc Eax
	Cmp Eax, Gizmo_ConditionCount
Gizmo_02:
	FakeJae 00437024H
	Jmp DWord Ptr Ds:[Offset Gizmo_TableConditions + Eax * 4]


Align 4
GizmoInitialize Proc Uses Esi Edi Ebx
	Local @Space

	Mov Esi, DWord Ptr Ds:[Gizmo_EffectSpace@]
	Mov Ebx, Esi
	Shr Ebx, 2
	Mov Gizmo_EffectOrigin, Ebx
	Xor Eax, Eax
	Mov Gizmo_EffectCount, Eax

	Movsx Esi, Byte Ptr Ds:[Gizmo_A_ConditionOrigin@]
	Mov Ebx, Esi
	Mov @Space, Ebx
	Shr Ebx, 2
	Mov Gizmo_ConditionOrigin, Ebx
	Xor Eax, Eax
	Mov Gizmo_ConditionCount, Eax
	Invoke WritePatch, Gizmo_ConditionSpace@, Addr @Space, 4
	Invoke WritePatch, Gizmo_ConditionSpace2@, Addr @Space, 4

	; Changes For Effects
	Invoke  WriteJmp, Gizmo_EffectList@, Offset Gizmo_EffectList
	Invoke  WriteJmp, Gizmo_EffectInputs@, Offset Gizmo_EffectInputs
	Invoke  WriteDirectAddress, Gizmo_Effect@, Addr Gizmo_Effect, 2 ; Jump if above
	Invoke  WriteAddress2, Gizmo_Effect@

;	; Changes For Conditions
	Invoke  WriteJmp, Gizmo_A_ConditionList@, Offset Gizmo_A_ConditionList
	Invoke  WriteJmp, Gizmo_A_ConditionInputs@, Offset Gizmo_A_ConditionInputs
	Invoke  WriteJmp, Gizmo_A_ConditionSpace@, Offset Gizmo_A_ConditionSpace
	Invoke  WriteJmp, Gizmo_A_ConditionSpace2@, Offset Gizmo_A_ConditionSpace2
	Invoke  WriteDirectAddress, Gizmo_Condition@, Addr Gizmo_Condition, 2
	Invoke  WriteAddress2, Gizmo_Condition@

	; Miscellaneous Changes
	Invoke  WriteAddresses, Addr Gizmo_Addresses
	Invoke  WriteAddresses2, Addr Gizmo_Addresses2

	Ret
GizmoInitialize EndP


Align 4
GizmoTriggerLoader Proc Uses Esi Edi Ebx, _hModule
	Local @Fig, @CurrentEffectCount

	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyEffectCount
	Test Eax, Eax
.If !Zero?
	Mov Eax, DWord Ptr Ds:[Eax]
	Test Eax, Eax
.If !Zero?
	Mov @CurrentEffectCount, Eax
	Mov Esi, DWord Ptr Ds:[Gizmo_EffectSpace@]
	Mov Ebx, Gizmo_EffectCount
	Add Eax, Ebx
	Lea Esi, [Esi + Eax * 4]
	Mov Gizmo_EffectCount, Eax
	Mov @Fig, Esi

	; Import Effect Names
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyEffectNames
	Mov Esi, Eax
	Mov Eax, @CurrentEffectCount
	Shl Eax, 2
	Lea Edi, [Offset Gizmo_TableEffectNames + Ebx * 4]
	Invoke  WritePatch, Edi, Esi, Eax

	; Import Effect Inputs
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyEffectInputs
	Mov Esi, Eax
	Mov Eax, @CurrentEffectCount
	Shl Eax, 3
	Lea Edi, [Offset Gizmo_TableEffectInputs + Ebx * 8]
	Invoke  WritePatch, Edi, Esi, Eax

	; Import Effects
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyEffects
	Mov Esi, Eax
	Mov Eax, @CurrentEffectCount
	Shl Eax, 2
	Lea Edi, [Offset Gizmo_TableEffects + Ebx * 4]
	Invoke  WritePatch, Edi, Esi, Eax

	; Increase Space Size
	Invoke  WritePatch, Gizmo_EffectSpace@, Addr @Fig, 4
	Invoke  WritePatch, Gizmo_EffectSpace2@, Addr @Fig, 4
.EndIf
.EndIf


	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyConditionCount
	Test Eax, Eax
.If !Zero?
	Mov Eax, DWord Ptr Ds:[Eax]
	Test Eax, Eax
.If !Zero?
	Mov @CurrentEffectCount, Eax
	Mov Esi, Gizmo_ConditionSpace@ ; Adaption !!
	Mov Esi, [Esi]
	Mov Ebx, Gizmo_ConditionCount
	Add Eax, Ebx
	Lea Esi, [Esi + Eax * 4]
	Mov Gizmo_ConditionCount, Eax
	Mov @Fig, Esi

	; Import Condition Names
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyConditionNames
	Mov Esi, Eax
	Mov Eax, @CurrentEffectCount
	Shl Eax, 2
	Lea Edi, [Offset Gizmo_TableConditionNames + Ebx * 4]
	Invoke  WritePatch, Edi, Esi, Eax

	; Import Condition Inputs
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyConditionInputs
	Mov Esi, Eax
	Mov Eax, @CurrentEffectCount
	Shl Eax, 3
	Lea Edi, [Offset Gizmo_TableConditionInputs + Ebx * 8]
	Invoke  WritePatch, Edi, Esi, Eax

	; Import Conditions
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyConditions
	Mov Esi, Eax
	Mov Eax, @CurrentEffectCount
	Shl Eax, 2
	Lea Edi, [Offset Gizmo_TableConditions + Ebx * 4]
	Invoke  WritePatch, Edi, Esi, Eax

	; Increase Space Size
	Invoke  WritePatch, Gizmo_ConditionSpace@, Addr @Fig, 4
	Invoke  WritePatch, Gizmo_ConditionSpace2@, Addr @Fig, 4
.EndIf
.EndIf

	; Write Jmps
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyAddress
	Test Eax, Eax
.If !Zero?
	Invoke  WriteAddresses, Eax
.EndIf

	; Write Jmps2
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyAddress2
	Test Eax, Eax
.If !Zero?
	Invoke  WriteAddresses2, Eax
.EndIf

	Ret
GizmoTriggerLoader EndP


Align 4
GizmoPatchLoader Proc Uses Esi, _hModule

	; Write Patches
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyPatches
	Test Eax, Eax
.If !Zero?
	Invoke  WritePatches, Eax
.EndIf

	; Write Addresses
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyAddress
	Test Eax, Eax
.If !Zero?
	Invoke  WriteAddresses, Eax
.EndIf

	; Write Addresses2
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyAddress2
	Test Eax, Eax
.If !Zero?
	Invoke  WriteAddresses2, Eax
.EndIf

	; Write Direct Addresses
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyDirectAddresses
	Test Eax, Eax
.If !Zero?
	Invoke  WriteDirectAddresses, Eax
.EndIf

	; Write Jumps
	Invoke GetProcAddress, _hModule, Addr Gizmo_KeyJumps
	Test Eax, Eax
.If !Zero?
	Invoke  WriteJmps, Eax
.EndIf

	Ret

GizmoPatchLoader EndP