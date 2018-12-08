;EasyCodeName=ExTriggers,1
.Const


__ExTriggers_Patches DD 007D8A94H, Offset ChangeAttackPatch, ChangeAttack - ChangeAttackPatch
	DD 0

__ExTriggers_Addrs DD EnableEffectInputs_Back
	DD DamageUnit_1, DamageUnit_2
	DD SendChat_1, SendChat_2
	DD ChangeDiplomacy_1, ChangeDiplomacy_2, ChangeDiplomacy_3
	DD CustomColorInfo_1, CustomColorInfo_2
	DD CustomColorInfo2_1, CustomColorInfo2_2, KillObject_1
	DD AIScriptGoal_1, AIScriptGoal_2, AIScriptGoal_3, AIScriptGoal_4, AIScriptGoal_5
	DD TaskObject_Teleport_1, ChangeName_1
	DD 0

__ExTriggers_Addrs2 DD SendChat_01, ChangeAttack_01
	DD AIScriptGoal_01, AIScriptGoal_02
	DD TaskObject_01, TaskObject_02, ChangeName_01
	DD 0

__ExTriggers_Dircts DD 007DD6D4H, Offset AIScriptGoal, 0
	DD 007DD714H, Offset ChangeName, 0
	;DD 007DD6C0H, Offset Tribute, 0
	DD 0

__ExTriggers_Jmps DD 007DD2C3H, Offset EnableEffectInputs
	DD 00437D40H, Offset DamageUnit
	DD 00437D36H, Offset DamageUnit2
	DD 0043764FH, Offset SendChat
	DD 00437605H, Offset ChangeDiplomacy
	DD 0051CF28H, Offset CustomColorInfo
	DD 0051C8EEH, Offset CustomColorInfo2
	DD 004379DDH, Offset KillObject
	DD 007D8A98H, Offset ChangeAttack
	DD 00437965H, TaskObject
	DD 0


.Data?

.Data

.Code

EnableNumber Macro _Offset
	Mov Edx, DWord Ptr Ds:[Edi + _Offset]
	Mov Byte Ptr Ds:[Edx + 16H], Al
EndM

__EffectPostfix__ Macro
	Pop Edi
	Pop Esi
	Pop Ebp
	Mov Al, 1
	Pop Ebx
	Add Esp, 2034H
	Retn 4
EndM


; Add "Number" Inputs
EnableEffectInputs:
	; Al = 02020202H, for
	; Cl = 02020202H, for requireds
	Mov DWord Ptr Ds:[Edx + 10H], Eax
	Mov Word Ptr Ds:[Edx + 14H], Ax
	Push Edi
	Mov Edi, DWord Ptr Ds:[Esi + 0CH]
	EnableNumber 04H
	EnableNumber 0CH
	EnableNumber 28H
	EnableNumber 38H
	EnableNumber 60H
	Pop Edi

EnableEffectInputs_Back:
	FakeJmp 007DD2CAH



; ----------------------------
; Extra Sub-effects
; ----------------------------


DamageUnit: ; ST(0) = Quantity
	Mov Eax, DWord Ptr Ds:[Esi]
	Mov Edx, DWord Ptr Ds:[Edi + 64H]
	Cmp Edx, 6
	Ja DamageUnit_
	Jmp DWord Ptr Ds:[Edx * 4 + Offset DamageUnit_Table]

; 1 - Set HP instantly
; 2 - Damage HP by permillage
; 3 - Set HP by permillage
; 4 - Damage HP by current lost HP's permillage
; 5 - Set HP by current HP's permillage
; 6 - Save HP into Resource
; 7 - Load HP from Resource
Align 4
DamageUnit_Table:
	DD Offset DamageUnit_, DamageUnit_1, DamageUnit_Perm, DamageUnit_Perm, DamageUnit_LostPerm
	DD Offset DamageUnit_CurrentPerm, 0

DamageUnit_:
	Fsubr DWord Ptr Ds:[Eax + 30H]
DamageUnit_1:
	FakeJmp 00437D45H

DamageUnit_Perm:
	Fmul DWord Ptr Ds:[Const0001]
	Push Eax
	Mov Eax, DWord Ptr Ds:[Eax + 08H]
	Fimul Word Ptr Ds:[Eax + 2AH]
	Pop Eax
	Cmp Dl, 3
	Je DamageUnit_1
	Jmp DamageUnit_

DamageUnit_CurrentPerm:
	Fmul DWord Ptr Ds:[Const0001]
	Fmul DWord Ptr Ds:[Eax + 30H]
	Jmp DamageUnit_1

DamageUnit_LostPerm:
	Fmul DWord Ptr Ds:[Const0001]
	Fld DWord Ptr Ds:[Eax + 30H]
	Push Eax
	Mov Eax, DWord Ptr Ds:[Eax + 08H]
	Fisubr Word Ptr Ds:[Eax + 2AH]
	Pop Eax
	Fmul
	Jmp DamageUnit_

DamageUnit_ToRes:
	Fldz
DamageUnit_ToRes_:
	Mov Eax, DWord Ptr Ds:[Esi]
	Fadd DWord Ptr Ds:[Eax + 30H]
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Inc Ebp
	Add Esi, 4
	Cmp Ebp, Eax
	Jl DamageUnit_ToRes_

	Fidiv DWord Ptr Ss:[Esp + 10H]

	Mov Ebx, DWord Ptr Ss:[Esp + 18H]
	Mov Ebx, DWord Ptr Ss:[Ebx + 0A8H]
	Movsx Eax, Word Ptr Ds:[Edi + 10H]
	Lea Eax, [Eax * 4 + Ebx]
	Fadd DWord Ptr Ds:[Eax]
	Fstp DWord Ptr Ds:[Eax]
DamageUnit_Back:
	__EffectPostfix__

DamageUnit_FromRes:
	Mov Ebx, DWord Ptr Ss:[Esp + 18H]
	Mov Ebx, DWord Ptr Ss:[Ebx + 0A8H]
	Movsx Eax, Word Ptr Ds:[Edi + 10H]
	Lea Eax, [Eax * 4 + Ebx]
	Fld DWord Ptr Ds:[Eax]
	Mov Edx, DWord Ptr Ss:[Esp + 10H]
DamageUnit_FromRes_:
	Mov Eax, DWord Ptr Ds:[Esi]
	Fst DWord Ptr Ds:[Eax + 30H]
	Inc Ebp
	Add Esi, 4
	Cmp Ebp, Edx
	Jl DamageUnit_FromRes_
	Fincstp
	Jmp DamageUnit_Back

DamageUnit2: ; 00437D36H
	Mov Esi, Esp
	Add Esi, 94H
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Cmp Eax, 7
	Je DamageUnit_ToRes
	Cmp Eax, 8
	Je DamageUnit_FromRes
DamageUnit_2:
	FakeJmp 00437D3DH


; Change Diplomacy
; 1 - Change Player Explored
; 2 - Change Player LoS
; 3 - Control Player
ChangeDiplomacy: ; 00437605h
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Cmp Eax, 3
	Je ChangeDiplomacy_Control
	;Cmp Eax, 4
	;Je ChangeDiplomacy_Civil
	Cmp Eax, 1
	Je ChangeDiplomacy_Field
	Cmp Eax, 2
	Jne ChangeDiplomacy_Other

	; Change LoS
	Mov Ebx, 12CH
ChangeDiplomacy_:
	Mov Eax, DWord Ptr Ds:[Edi + 18H]
	And Eax, Eax
	Mov Esi, DWord Ptr Ds:[Esp + 18H]
	Mov Ecx, DWord Ptr Ds:[Edi + 2CH]
	Je ChangeDiplomacy_On
	; ChangeDiplomacy_Off
	Mov Ax, -2 ; 1111...1110
	Shl Ax, Cl
	And Word Ptr Ds:[Esi + Ebx], Ax
	Jmp ChangeDiplomacy_2
ChangeDiplomacy_On:
	Mov Ax, 1
	Shl Ax, Cl
	Or Word Ptr Ds:[Esi + Ebx], Ax
ChangeDiplomacy_2:
	FakeJmp 0043761DH

ChangeDiplomacy_Field:
	Mov Ebx, 12AH
	Jmp ChangeDiplomacy_

ChangeDiplomacy_Other:
	Mov Eax, DWord Ptr Ds:[Edi + 18H]
	Mov Ecx, DWord Ptr Ss:[Esp + 18H]
ChangeDiplomacy_1:
	FakeJmp 0043760CH

ChangeDiplomacy_Control:
	Mov Ecx, DWord Ptr Ds:[Plc]
ChangeDiplomacy_3:
	FakeCall 005EAE80H
	Cmp Eax, DWord Ptr Ds:[Edi + 28H]
	Jne ChangeDiplomacy_2
    Mov Ecx, DWord Ptr Ds:[Plc]
    Mov Eax, [Ecx]
    Push DWord Ptr Ds:[Edi + 2CH]
    Call DWord Ptr Ds:[Eax + 14H]
	Jmp ChangeDiplomacy_2


; Send Chat
; 1 - make cheats from source player
SendChat: ; 043764F
	Mov Ecx, DWord Ptr Ds:[Plc]
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Cmp Eax, 1
SendChat_01:
	FakeJne 00437655H
	Push DWord Ptr Ds:[Edi + 6CH] ; arg2: Message
	Push DWord Ptr Ds:[Edi + 28H] ; arg1: Player Id
SendChat_1:
	FakeCall 00443EB0H
SendChat_2:
	FakeJmp 0043770DH


; Message Color
; Pattern: <=FFFF>
CustomColorInfo:
	Add Esp, 8
	Test Eax, Eax
	Je CustomColorInfo_Other
CustomColorInfo_1: ; White
	FakeJmp 0051CF2FH
; Esi = String Addr, [Esp + 14H] = Text Color, [Esp + 20H] = Outline Color
CustomColorInfo_Other:
	Lea Edx, [Esp + 20H]
	Lea Eax, [Esp + 14H]
	Push Edx
	Push Eax
	Push Esi
	Call CustomColorInfoAnalyze
	Test Eax, Eax
.If !Zero?
	Add Esi, 7
.EndIf
CustomColorInfo_2: ; Normal
	FakeJmp 0051CF36H

; Chat Color
CustomColorInfo2:
	Add Esp, 8
	Test Eax, Eax
	Je CustomColorInfo2_Other
CustomColorInfo2_1: ; White
	FakeJmp 0051C8F9H
; [Ebp] = String Addr, [Esp + 14H] = Text Color, [Esp + 20H] = Outline Color
CustomColorInfo2_Other:
	Mov Ecx, DWord Ptr Ss:[Ebp]
	Lea Edx, [Esp + 20H]
	Lea Eax, [Esp + 14H]
	Push Ebx
	Push Edi
	Push Ecx
	Call CustomColorInfoAnalyze
	Test Eax, Eax
.If !Zero?
	Mov Ecx, DWord Ptr Ss:[Ebp]
	Add Ecx, 7
	Mov DWord Ptr Ss:[Ebp], Ecx
.EndIf
CustomColorInfo2_2: ; Normal
	FakeJmp 0051C9F9H


CustomColorInfoAnalyze:
	Push Edi
	Push Esi
	Push Ebx
	Push Edx
	Push Ebp
@StackSize Equ 18H

	Mov Esi, DWord Ptr Ss:[Esp + @StackSize]
	Cmp Byte Ptr Ds:[Esi], '<'
	Jne CustomColorInfo_Normal
	Cmp Byte Ptr Ds:[Esi + 1], '='
	Jne CustomColorInfo_Normal
	Cmp Byte Ptr Ds:[Esi + 6], '>'
	Jne CustomColorInfo_Normal
	Xor Ebx, Ebx
	;Mov Ebp, DWord Ptr Ss:[Esp + @StackSize + 4H]

	Mov Cl, Byte Ptr Ds:[Esi + 2]
	Call GetHexValue
	Cmp Ax, 0
	Jl CustomColorInfo_Normal
	Mov Bl, Al
	Mov Cl, Byte Ptr Ds:[Esi + 3]
	Call GetHexValue
	Cmp Ax, 0
	Jl CustomColorInfo_Normal
	Shl Bl, 4
	Or Bl, Al

	Mov Cl, Byte Ptr Ds:[Esi + 4]
	Call GetHexValue
	Cmp Ax, 0
	Jl CustomColorInfo_Normal
	Mov Bh, Al
	Mov Cl, Byte Ptr Ds:[Esi + 5]
	Call GetHexValue
	Cmp Ax, 0
	Jl CustomColorInfo_Normal
	Shl Bh, 4
	Or Bh, Al

	Mov Edi, DWord Ptr Ss:[Esp + @StackSize + 4H]
	Mov Byte Ptr Ds:[Edi], Bl
	Mov Edi, DWord Ptr Ss:[Esp + @StackSize + 8H]
	Mov Byte Ptr Ds:[Edi], Bh

	Xor Eax, Eax
	Mov Al, 1
	Jmp CustomColorInfo_
CustomColorInfo_Normal:
	Xor Eax, Eax
CustomColorInfo_:
	Pop Ebp
	Pop Edx
	Pop Ebx
	Pop Esi
	Pop Edi
	Retn 0CH

; CL - Hex char
; return - value or -1(invalid)
GetHexValue:
	Xor Eax, Eax
.If Cl <= '9'
	Sub Cl, '0'
	Cmp Cl, 9
	Ja GetHexValue_Invalid
.ElseIf Cl <= 'F'
	Sub Cl, 'A'
	Cmp Cl, 5
	Ja GetHexValue_Invalid
	Add Cl, 10
.Else
GetHexValue_Invalid:
	Not Eax
	Retn
.EndIf
	Mov Al, Cl
	Retn


; 1 - Make units invulnerable
KillObject: ; 004379DDH
	Mov Edx, [Edi + 64H]
	Lea Edi, [Esp + 94H]
	Dec Edx
.If !Zero?
KillObject_1:
	FakeJmp 004379E4H
.EndIf
.Repeat
	Mov Ecx, DWord Ptr Ds:[Edi]
	Mov Eax, 7F800000H
	Mov DWord Ptr Ds:[Ecx + 30H], Eax
	Mov Eax, DWord Ptr Ss:[Esp + 10H]
	Inc Esi
	Add Edi, 4
.Until Esi >= Eax
	__EffectPostfix__


; ChangeAttack
; 2 - Add unit's projectile count
; 3 - Set unit's projectile count
ChangeAttackPatch:
	Dec Edx
	Cmp Edx, 3
ChangeAttack:
ChangeAttack_01:
	FakeJae 00437F2BH
	Jmp DWord Ptr Ds:[Edx * 4 + Offset ChangeAttack_Table]
ChangeAttack_SetPrj:
	Fild DWord Ptr Ds:[Edi + 10H]
	Xor Esi, Esi
.Repeat
	Mov Ecx, DWord Ptr Ds:[Ebp]
	Mov Edx, DWord Ptr Ds:[Ecx + 8]
	.If Byte Ptr Ds:[Edx + 4] >= 70
		Fst DWord Ptr Ds:[Ecx + 17CH]
	.EndIf
	Inc Esi
	Add Ebp, 4
.Until Esi >= Eax
	Fstp St
	__EffectPostfix__

ChangeAttack_AddPrj:
	Sub Esp, 4H
	Fild DWord Ptr Ds:[Edi + 10H]
	Fst DWord Ptr Ss:[Esp]
	Xor Esi, Esi
.Repeat
	Mov Ecx, DWord Ptr Ds:[Ebp]
	Mov Edx, DWord Ptr Ds:[Ecx + 8]
	.If Byte Ptr Ds:[Edx + 4] >= 70
		Fadd DWord Ptr Ds:[Ecx + 17CH]
		Fstp DWord Ptr Ds:[Ecx + 17CH]
		Fld DWord Ptr Ss:[Esp]
	.EndIf
	Inc Esi
	Add Ebp, 4
.Until Esi >= Eax
	Fstp St
	Add Esp, 4H
	__EffectPostfix__

Align 4
ChangeAttack_Table:
	DD 007D8A9DH, Offset ChangeAttack_AddPrj, Offset ChangeAttack_SetPrj


; AIScriptGoal
; 1 - Set goal off
; 8 - Set player's color
; 9 - Set player's civilization(Culture only, including new trained units)
; In 8 and 9, goal #256 would change in random.
AIScriptGoal:
	Mov Ecx, DWord Ptr Ds:[Edi + 64H]
	Test Ecx, Ecx
AIScriptGoal_01:
	FakeJle 00437895H
	Cmp Ecx, 1
	Je AIScriptGoal_Off
	Cmp Ecx, 8
	Je AIScriptGoal_Color
	Cmp Ecx, 9
AIScriptGoal_02:
	FakeJne 00437895H

AIScriptGoal_Civil:
	Mov Esi, DWord Ptr Ss:[Esp + 18H]
	Mov Ecx, DWord Ptr Ds:[Edi + 0CH]
	Mov Eax, DWord Ptr Ds:[Esi + 8CH] ; Check maximum
	Mov Eax, DWord Ptr Ds:[Eax + 50H]
	Cmp Ecx, 255
	Jl AIScriptGoal_Civil_
	Je AIScriptGoal_Civil_NoGaia
	Mov Ebp, Eax
AIScriptGoal_4:
	FakeCall SUB_RANDOM
	Cdq
	IDiv Ebp
	Mov Cl, Dl
	Mov Eax, Ebp
	Jmp AIScriptGoal_Civil_
AIScriptGoal_Civil_NoGaia:
	Mov Ebp, Eax
	Dec Ebp
AIScriptGoal_5:
	FakeCall SUB_RANDOM
	Cdq
	IDiv Ebp
	Inc Dl
	Mov Cl, Dl
	Inc Ebp
	Mov Eax, Ebp
AIScriptGoal_Civil_:
	Cmp Cl, Al
	Jge AIScriptGoal_
	Mov Byte Ptr Ds:[Esi + 15DH], Cl
	Mov Ecx, DWord Ptr Ds:[Plc]
AIScriptGoal_2:
	FakeCall 005EAE80H
    Mov Ecx, DWord Ptr Ds:[Plc]
    Mov Ebx, [Ecx]
    Push Eax
    Call DWord Ptr Ds:[Ebx + 14H]
	Jmp AIScriptGoal_

AIScriptGoal_Off:
    Mov Ecx, [Esp + 18H]
    mov edx,[edi+0Ch]
    push edx
    mov eax,[ecx]
    call AIScriptGoalOff
    __EffectPostfix__

AIScriptGoal_Color:
	Mov Esi, DWord Ptr Ss:[Esp + 18H]
	Mov Ebx, DWord Ptr Ds:[Edi + 0CH]
	Mov Eax, DWord Ptr Ds:[Esi + 8CH] ; Check maximum
	Mov Eax, DWord Ptr Ds:[Eax + 78H]
	Cmp Ebx, 255
	Jl AIScriptGoal_Color_
	Je AIScriptGoal_Color_8P
	Mov Ebp, Eax
	Jmp AIScriptGoal_3
AIScriptGoal_Color_8P:
	Mov Ebp, 8
AIScriptGoal_3:
	FakeCall SUB_RANDOM
	Cdq
	IDiv Ebp
	Mov Ebx, Edx
	Mov Eax, Ebp
AIScriptGoal_Color_:
	Cmp Ebx, Eax
	Jge AIScriptGoal_
	Mov Ecx, Esi
	Push Ebx
AIScriptGoal_1:
	FakeCall 00555E40H
AIScriptGoal_:
	__EffectPostfix__

AIScriptGoalOff:
    Mov Eax, [Esp + 04H]
    Push Eax
    Call UnsetAIScriptGoal
    Pop Ecx
    Retn 4
UnsetAIScriptGoal:
    Mov Eax, [Esp + 04H]
    Mov DWord Ptr Ds:[Eax * 4 + 006B39A0H], 0
    Retn


; Task Object
; 2 - Teleport all without restriction
TaskObject: ; 00437965h
TaskObject_01:
	FakeJle 00437FDAH
	Mov Eax, DWord Ptr Ds:[Edi + 64H]
	Cmp Eax, 2
TaskObject_02:
	FakeJne 0043796BH
	Lea Ebp, [Esp + 94H] ; Teleport all
	Mov Esi, DWord Ptr Ss:[Esp + 10H]
	Mov Edx, DWord Ptr Ds:[Esp + 24H]
	Sub Esp, 8H
	Test Edx, Edx
	Jle TaskObject_Teleport_Point
	Fld DWord Ptr Ds:[Edx + 38H]
	Fld DWord Ptr Ds:[Edx + 3CH]
	Jmp TaskObject_Teleport_
TaskObject_Teleport_Point:
	Fild DWord Ptr Ds:[Edi + 44H]
	Fild DWord Ptr Ds:[Edi + 48H]
TaskObject_Teleport_:
	Fstp DWord Ptr Ss:[Esp + 4H]
	Fstp DWord Ptr Ss:[Esp]
.Repeat
	Mov Ecx, DWord Ptr Ss:[Ebp]
	Mov Ebx, [Ecx + 8H]
	.If Byte Ptr Ds:[Ebx + 4H] >= 70
		Mov Edx, DWord Ptr Ss:[Esp + 4H]
		Mov Eax, DWord Ptr Ss:[Esp]
		Push 0
		Push Edx
		Push Eax
		Mov DWord Ptr Ds:[Ecx + 0C8H], Edx
		Mov DWord Ptr Ds:[Ecx + 0C0H], Eax
TaskObject_Teleport_1:
		FakeCall SUB_TELEPORT
	.EndIf
	Add Ebp, 4H
	Dec Esi
.Until Zero?
	Add Esp, 8H
	__EffectPostfix__


; Change Name
; 2 - Set Protounit's Name
ChangeName:
	Cmp DWord Ptr Ds:[Edi + 64H], 2
ChangeName_01:
	FakeJne 00437E3BH
	Mov Esi, DWord Ptr Ss:[Esp + 18H]
	Mov Eax, DWord Ptr Ds:[Edi + 24H] ; Protounit id
	Mov Ecx, DWord Ptr Ds:[Esi + 70H]
.If Eax < Ecx
	Mov Ecx, DWord Ptr Ds:[Esi + 74H]
	Mov Ebx, DWord Ptr Ds:[Ecx + Eax * 4]
	Test Ebx, Ebx
	.If !Zero?
		Mov Cx, Word Ptr Ds:[Edi + 34H]
		Mov Word Ptr Ds:[Ebx + 0CH], Cx
		Mov Edx, DWord Ptr Ds:[Edi + 6CH]
		Add Ebx, 8H
		Push Edx
		Push Ebx
ChangeName_1:
		FakeCall 00568590H
		Add Esp, 8H
	.EndIf
.EndIf
	__EffectPostfix__
