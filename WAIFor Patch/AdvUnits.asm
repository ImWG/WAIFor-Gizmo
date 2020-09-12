;EasyCodeName=AdvUnits,1
.Const

__AdvUnits_Patches DD 0 ;004D110FH, Offset FullDamageImage, 1
	DD 0

__AdvUnits_Addrs DD AnnexTask_1, AnnexTask2_1, AnnexTask2_2, AnnexTask3_1, AutoTrain_1
	DD Crusher_1, Healer_1
	DD 0

__AdvUnits_Addrs2 DD 0

__AdvUnits_Dircts DD 0

__AdvUnits_Jmps DD 005C6853H, AnnexTask
	DD 005C8039H, AnnexTask2
	DD 00467981H, AnnexTask3
	DD 0

$AdvUnits DD Offset AdvUnits


.Data?

.Data

; Make 100% damage image visible
FullDamageImage DB 65H


Float1000 DD 1000.0


.Code

AdvUnits:
	Push Esi

	Mov Esi, Ecx
	Mov Ecx, Esi
	Call AnnexMove
	Mov Ecx, Esi
	Call Crusher
	;Mov Ecx, Esi
	;Call TrainMove

	Pop Esi
	Retn


AnnexUnitCheck: ; Check if ECX is a annex-moving unit
	Xor Eax, Eax
	Mov Edx, [Ecx + 8]
.If Byte Ptr Ds:[Edx + 4] == 80
	Test Byte Ptr Ds:[Edx + 1D6H], 10H
	Setne Al
.EndIf
	Retn


AnnexMove: ; Move annex units along with head unit
	Push Edi
	Push Esi
	Push Ebx
	Mov Ecx, Esi
	Call AnnexUnitCheck
	Test Al, Al
.If !Zero?
	Xor Ebx, Ebx
	Mov Bl, 4
	Lea Edi, [Esi + 1B8H]
	Mov Ecx, DWord Ptr Ds:[Esi + 8H]

	; If clearance sizes not equal, positions of x would +1 for negative values
	Mov Eax, DWord Ptr Ds:[Ecx + 64H]
	.If Eax != DWord Ptr Ds:[Ecx + 68H]
		Fld1
	.Else
		Fldz
	.EndIf
	Push Eax
	Fstp DWord Ptr Ss:[Esp]

	; If sizes equal, positions of annex units would rotate
	Mov Eax, DWord Ptr Ds:[Ecx + 34H]
	.If Eax == DWord Ptr Ds:[Ecx + 38H]
		.Repeat
			Mov Edx, [Edi]
			Test Edx, Edx
			.If !Zero?
				Mov Ecx, DWord Ptr Ds:[Esi + 8H]
				Lea Ecx, [Ecx + Ebx * 4 + 1DCH]
				Sub Esp, 0CH

				Fld DWord Ptr Ds:[Esi + 40H]
				Mov Eax, [Edx + 8H]
				.If Byte Ptr Ds:[Eax + 70H] != 0 ; Fly Mode allows unit shift height
					Fadd DWord Ptr Ds:[Eax + 0C4H] ; Selection Height
				.EndIf
				Fstp DWord Ptr Ss:[Esp + 8H]

				; x=-dxcos(a)-dysin(a), y=-dxsin(a)+dycos(a)
				Fld DWord Ptr Ds:[Ecx + 10H] ; dy
				Fld DWord Ptr Ds:[Esi + 94H]
				Fsin
				Fmulp St(1), St
				Fld DWord Ptr Ds:[Ecx] ; dx
				Ftst
				Fstsw Ax
				Test Ah, 1H
				.If !Zero?
					Fadd DWord Ptr Ss:[Esp + 0CH]
				.EndIf
				Fld DWord Ptr Ds:[Esi + 94H]
				Fcos
				Fmulp St(1), St
				Fsubp St(1), St
				Fadd DWord Ptr Ds:[Esi + 38H]
				Fstp DWord Ptr Ss:[Esp]

				Fld DWord Ptr Ds:[Esi + 3CH]
				Fld DWord Ptr Ds:[Ecx + 10H]
				Fld DWord Ptr Ds:[Esi + 94H]
				Fcos
				Fmulp St(1), St
				Fld DWord Ptr Ds:[Ecx]
				Ftst
				Fstsw Ax
				Test Ah, 1H
				.If !Zero?
					Fadd DWord Ptr Ss:[Esp + 0CH]
				.EndIf
				Fld DWord Ptr Ds:[Esi + 94H]
				Fsin
				Fmulp St(1), St
				Faddp St(1), St
				Fsubp St(1), St
				Fstp DWord Ptr Ss:[Esp + 4]

				Mov Ecx, Edx
				Mov Edx, DWord Ptr Ds:[Edx]
				Call DWord Ptr Ds:[Edx + 38H]
				Fstp St
			.EndIf
			Sub Edi, 4
			Dec Bl
		.Until Zero?

	.Else
		.Repeat
			Mov Edx, [Edi]
			Test Edx, Edx
			.If !Zero?
				;Push Eax

				;Mov Ecx, DWord Ptr Ds:[Eax + 6CH]
				;Test Ecx, Ecx
				;.If !Zero? ; Stop Action
				;	Push 0
				;	Mov Edx, DWord Ptr Ds:[Ecx]
				;	Call DWord Ptr Ds:[Edx + 54H]
				;	Mov Eax, DWord Ptr Ss:[Esp]
				;.EndIf

				Mov Ecx, DWord Ptr Ds:[Esi + 8H]
				Lea Ecx, [Ecx + Ebx * 4 + 1DCH]
				Sub Esp, 0CH

				Fld DWord Ptr Ds:[Esi + 40H]
				Mov Eax, [Edx + 8H]
				.If Byte Ptr Ds:[Eax + 70H] != 0 ; Fly Mode allows unit shift height
					Fadd DWord Ptr Ds:[Eax + 0C4H] ; Selection Height
				.EndIf
				Fstp DWord Ptr Ss:[Esp + 8H]

				Fld DWord Ptr Ds:[Esi + 3CH]
				Fadd DWord Ptr Ds:[Ecx + 10H]
				Fstp DWord Ptr Ss:[Esp + 4H]
				Fld DWord Ptr Ds:[Ecx]
				Ftst
				Fstsw Ax
				Test Ah, 1H
				.If !Zero?
					Fadd DWord Ptr Ss:[Esp + 0CH]
				.EndIf
				Fadd DWord Ptr Ds:[Esi + 38H]
				Fstp DWord Ptr Ss:[Esp]
				Mov Ecx, Edx
				Mov Edx, DWord Ptr Ds:[Edx]
				Call DWord Ptr Ds:[Edx + 38H]
				Fstp St ; Or bug making someone teleported to left corner

				;Mov Eax, DWord Ptr Ss:[Esp]
				;Mov Ecx, DWord Ptr Ds:[Eax + 6CH]
				;Test Ecx, Ecx
				;.If !Zero?
				;	Movzx Eax, Byte Ptr Ds:[Ecx + 169H]
				;	Mov Edx, DWord Ptr Ds:[Ecx]
				;	Push Eax
				;	Call DWord Ptr Ds:[Edx + 0C4H]
				;	Mov Eax, DWord Ptr Ss:[Esp]
				;	Mov Ecx, DWord Ptr Ds:[Eax + 6CH]
				;	FakeCall 005F2880H
				;.EndIf

				;Pop Eax
			.EndIf
			Sub Edi, 4
			Dec Bl
		.Until Zero?
	.EndIf
	Pop Edx
.EndIf

; Automatically train available units when queue is empty
; For units of button from 15 to 20
AutoTrain:
	Mov Edx, [Esi + 8]
.If Byte Ptr Ds:[Edx + 4] == 80
	Cmp Word Ptr Ds:[Edx + 16H], 1BH ; Not Class 27(walls, unable to train)
.If !Zero? ; No more conditions now, but may cause lag.
	Mov Al, [Esi + 1C8H]
	Test Al, Al
	.If Zero?
		Movzx Ecx, Word Ptr Ds:[Edx + 10H]
		Push Ecx
		Mov Edi, [Esi + 0CH]
		Mov Ebx, [Edi + 70H]
		Mov Edi, [Edi + 74H]
		.Repeat
			Mov Edx, [Edi]
			Test Edx, Edx
			Je AutoTrain_LoopSkip ; Exist
			Cmp Byte Ptr Ds:[Edx + 4], 70
			Jb AutoTrain_LoopSkip ; Type 70+
			Mov Ax, Word Ptr Ds:[Edx + 184H]
			Cmp Ax, Word Ptr Ss:[Esp]
			Jne AutoTrain_LoopSkip ;
			Mov Al, Byte Ptr Ds:[Edx + 5AH]
			Test Al, Al
			Je AutoTrain_LoopSkip
			Mov Al, Byte Ptr Ds:[Edx + 186H]
			Cmp Al, 15
			Jb AutoTrain_LoopSkip
			Cmp Al, 20
			Ja AutoTrain_LoopSkip

			Movzx Edx, Word Ptr Ds:[Edx + 10H]
			Mov Ecx, Esi
			Push 1
			Push Edx
AutoTrain_1:
			FakeCall 004CB770H
AutoTrain_LoopSkip:
			Add Edi, 4
			Dec Ebx
		.Until Zero?
		Pop Ecx
	.EndIf
.EndIf
.EndIf

	Pop Ebx
	Pop Esi
	Pop Edi
	Retn


AnnexTask: ; 005C6853H ; Task annex units along with head unit
	Mov Ecx, Esi
	Call AnnexUnitCheck
	Test Al, Al
.if !zero?
	Push Ebx
	Push Edi
	Push Esi
	Mov Ebx, 4
	Lea Esi, [Esi + 1ACH]
	.Repeat
		Mov Edi, DWord Ptr Ds:[Esi]
		Test Edi, Edi
		.If !Zero?
			Mov Edx, [Edi]
			Mov Eax, DWord Ptr Ss:[Esp + 44H]
			Push 0
			Mov Ecx, DWord Ptr Ds:[Eax + 10H]
			Mov Eax, DWord Ptr Ds:[Eax + 0CH]
			Push Ecx
			Mov Ecx, DWord Ptr Ss:[Esp + 24H]
			Push Eax
			Push Ecx
			Mov Ecx, Edi
			Call DWord Ptr Ds:[Edx + 0A0H]
		.EndIf
		Add Esi, 4
		Dec Ebx
	.Until Zero?
	Pop Esi
	Pop Edi
	Pop Ebx
.EndIf

	Mov Eax, DWord Ptr Ds:[78CC54H]
AnnexTask_1:
	FakeJmp 005C6858H


AnnexTask2: ; 005C8039H ; Set annex units stance along with head unit
	Mov Ecx, Esi
	Call AnnexUnitCheck
	Test Al, Al
.If !Zero?
	Push Ebx
	Push Edi
	Push Esi
	Mov Ebx, 4
	Lea Esi, [Esi + 1ACH]
	.Repeat
		Mov Edi, DWord Ptr Ds:[Esi]
		Test Edi, Edi
		.If !Zero?
			Mov Edx, [Edi]
			Mov Ecx, Edi
AnnexTask2_2:
			FakeCall 005F5FB0H
			Mov Edx, DWord Ptr Ds:[Eax]
			Mov Cl, Byte Ptr Ss:[Ebp + 2]
			Push Ecx
			Mov Ecx, Eax
			Call DWord Ptr Ds:[Edx + 0C4H]
		.EndIf
		Add Esi, 4
		Dec Ebx
	.Until Zero?
	Pop Esi
	Pop Edi
	Pop Ebx
.EndIf

	Mov Edx, DWord Ptr Ds:[Ebx + 4]
	Mov Ecx, DWord Ptr Ds:[Esi + 0CH]
AnnexTask2_1:
	FakeJmp 005C803FH


AnnexTask3: ; 00467981H ; Set annex units attack ground
	Call DWord Ptr Ds:[Edx + 174H]
	Mov Ecx, Esi
	Call AnnexUnitCheck
	Test Al, Al
.If !Zero?
	Push Ebx
	Push Ebp
	Push Esi
	Mov Ebx, 4
	Lea Esi, [Esi + 1ACH]
	.Repeat
		Mov Ebp, DWord Ptr Ds:[Esi]
		Test Ebp, Ebp
		.If !Zero?
			Mov Eax, DWord Ptr Ds:[Edi + 8]
			Mov Ecx, DWord Ptr Ds:[Edi + 4]
			Push 1
			Push 0
			Push Eax
			Push Ecx
			Mov Edx, [Ebp]
			Mov Ecx, Ebp
			Call DWord Ptr Ds:[Edx + 174H]
		.EndIf
		Add Esi, 4
		Dec Ebx
	.Until Zero?
	Pop Esi
	Pop Ebp
	Pop Ebx
.EndIf
AnnexTask3_1:
	FakeJmp 00467987H



; Crusher
Crusher:
	Push Edi
	Push Esi
	Push Ebx
	Mov Esi, Ecx
	Mov Eax, [Esi + 20H] ; Not Garrison
	Test Eax, Eax
	Jne Crusher_Skip

	Mov Edx, [Esi + 8]
.If Byte Ptr Ds:[Edx + 4] >= 60
.If Byte Ptr Ds:[Edx + 99H] == 7
	Push Edx
	Fld DWord Ptr Ds:[Edx + 168H] ; Shown Attack Delay
	Fmul DWord Ptr Ds:[Float1000]
	Fistp DWord Ptr Ds:[Esp]
	Pop Ecx
	Test Ecx, Ecx
	.If !Zero?
		Mov Edx, [Esi + 0CH]
		Mov Edx, [Edx + 8CH]
		Mov Eax, [Edx + 10H]
		Xor Edx, Edx
		Div Ecx ; ECX = round(Delay * 1000)
		Mov Ecx, 10H
		Push Ecx
		Mov Ecx, DWord Ptr Ds:[Plc]
		Fild DWord Ptr Ss:[Esp]
		Fmul DWord Ptr Ds:[Ecx + 1094H]
		Fistp DWord Ptr Ss:[Esp]
		Pop Ecx
		Cmp Edx, Ecx
		Jae Crusher_Skip
	.EndIf

	Mov Ebx, [Esi + 8]
	.If Byte Ptr Ds:[Ebx + 4] == 60
		Movzx Eax, Word Ptr Ds:[Ebx + 148H]
		Mov Ecx, DWord Ptr Ds:[Esi + 0CH]
		.If Eax < DWord Ptr Ds:[Ecx + 70H]
			Mov Ecx, [Ecx + 74H]
			Mov Ecx, [Ecx + Eax * 4]
			Test Ecx, Ecx
		.If !Zero?
			Push 1
			Mov Edx, [Esi + 40H]
			Mov Eax, [Esi + 3CH]
			Mov Ecx, [Esi + 38H]
			Push Edx
			Push Eax
			Push Ecx
			Movzx Eax, Word Ptr Ds:[Ebx + 148H]
			Mov Ecx, [Esi + 0CH]
			Push Eax
Crusher_1:
			FakeCall SUB_DROPUNIT
		.EndIf
		.EndIf
	.ElseIf Word Ptr Ds:[Ebx + 16H] == 18 && Byte Ptr Ds:[Ebx + 140H] == 3
		Mov Ecx, Esi
		Call Healer
	.Else
		Xor Eax, Eax
		Push Eax
		Push Eax
		Push Esi
		Mov Ecx, DWord Ptr Ds:[Esi + 40H]
		Mov Edx, DWord Ptr Ds:[Esi + 3CH]
		Mov Eax, DWord Ptr Ds:[Esi + 38H]
		Push Ecx
		Push Edx
		Push Eax
		Mov Ecx, Esi
		Mov Edx, [Esi]
		Call DWord Ptr Ds:[Edx + 340H]
	.EndIf
.EndIf
.EndIf
Crusher_Skip:
	Pop Ebx
	Pop Esi
	Pop Edi
	Retn


; Auto Healer
Healer:
	Push Edi
	Push Esi
	Push Ebp
	Mov Esi, Ecx ; Unit Addr.
	Mov Eax, [Esi + 0CH]
	Push Eax ; Source Player
	Mov Edx, [Eax + 8CH]
	Mov Eax, [Edx + 48H] ; Player Count
	Push Eax ; Player Index

	Mov Ecx, DWord Ptr Ds:[Esi + 8H]
	Push Eax
	Fld DWord Ptr Ds:[Ecx + 13CH]
	Fmul St, St
	Fstp DWord Ptr Ss:[Esp] ; power 2 of Blast Width

.Repeat
	Mov Ecx, [Esp + 8H]
	Mov Edx, [Ecx + 8CH]
	Mov Edx, [Edx + 4CH]
	Mov Eax, [Esp + 4H]
	Dec Eax
	Mov Edi, [Edx + Eax * 4] ; Player Addr.
	Test Edi, Edi
	Je Healer_Skip
	;Mov Ecx, [Esp + 8H]
	Movzx Edx, Word Ptr Ds:[Ecx + 9CH]
	Mov Dl, Byte Ptr Ds:[Edi + Edx * 4 + 0E0H]
	Cmp Dl, 1
	Je Healer_
	Cmp Dl, 2
	Jne Healer_Skip
Healer_:
	Movzx Edx, Word Ptr Ds:[Edi + 9CH]
	Mov Dl, Byte Ptr Ds:[Ecx + Edx * 4 + 0E0H]
	Cmp Dl, 1
	Je Healer__ ; Both Allied
	Cmp Dl, 2
	Jne Healer_Skip

Healer__:
	Mov Eax, [Edi + 78H]
	Mov Edx, DWord Ptr Ds:[Eax + 8H]
	Test Edx, Edx
	Je Healer_Skip
	Push Edx

	Mov Ebp, DWord Ptr Ds:[Eax + 4H]
	.Repeat
		Mov Edi, [Ebp]

		Fld DWord Ptr Ds:[Edi + 3CH]
		Fsub DWord Ptr Ds:[Esi + 3CH]
		Fmul St, St
		Fld DWord Ptr Ds:[Edi + 38H]
		Fsub DWord Ptr Ds:[Esi + 38H]
		Fmul St, St
		Faddp St(1), St

		Fcomp DWord Ptr Ss:[Esp + 4]
		Fstsw Ax
		Test Ah, 41H
		.If !Zero? ; In Range
			Mov Edx, DWord Ptr Ds:[Edi + 8H]
			Fld DWord Ptr Ds:[Edi + 30H]
			Ficom Word Ptr Ds:[Edx + 2AH]
			Fstsw Ax
			Test Ah, 1H
			.If !Zero? ; Damaged
				Push Ebp
				Push Esi
				Mov Eax, [Edi + 8H]
				Mov Esi, [Esi + 8H] ; Healer Protounit
				Mov Edx, [Esi + 12CH] ; By Attack List
				Test Edx, Edx
				.If !Zero?
					Mov Ebp, [Esi + 130H]
					Mov Ax, Word Ptr Ds:[Eax + 16H]
					Push 0
					Push - 1
					.Repeat
						Mov Cx, Word Ptr Ds:[Ebp]
						.If Cx == -1 || Cx == Ax  ; Same Class
							Fiadd Word Ptr Ds:[Ebp + 2]
							Mov Cl, 1
							Mov Byte Ptr Ss:[Esp + 4], Cl ; Is Healing
						.ElseIf Cx == -2 ; Set Healing Graphic
							Movzx Ecx, Word Ptr Ss:[Ebp + 2]
							Mov DWord Ptr Ss:[Esp], Ecx
						.EndIf
						Add Ebp, 4
						Dec Edx
					.Until Zero?
					Mov Edx, [Edi + 8H]
					Ficom Word Ptr Ds:[Edx + 2AH]
					Fstsw Ax
					Test Ah, 1H
					.If Zero? ; Overflow
						Fstp St
						Fild Word Ptr Ds:[Edx + 2AH]
					.EndIf
					Fstp DWord Ptr Ds:[Edi + 30H]

					; Animation
					Mov Cl, Byte Ptr Ss:[Esp + 4]
					Test Cl, Cl
					.If !Zero?
						Mov Esi, [Esp + 8]
						Mov Ecx, [Esi + 0CH]
						Mov Ecx, [Ecx + 8CH]
						Mov Eax, [Esp]
						.If Eax < [Ecx + 40H]
							Mov Edx, [Ecx + 44H]
							Mov Ebp, [Edx + Eax * 4]
							Test Ebp, Ebp
							.If !Zero?
								Push - 1
								Push - 1
								Push 0
								Mov Edx, [Edi + 38H]
								Mov Eax, [Edi + 3CH]
								Mov Ecx, [Edi + 40H]
								Push 0 ; Direction
								Push Ecx
								Push Eax
								Push Edx
								Push Ebp ; Animation ID
								Mov Ecx, [Esi + 0CH]
								Mov Ecx, [Ecx + 8CH]
								Mov Ecx, [Ecx + 70H]
Healer_1:
								FakeCall 004D5890H
							.EndIf
						.EndIf
					.EndIf
					Add Esp, 8
				.EndIf
				Pop Esi
				Pop Ebp
			.EndIf
			Fstp St
		.EndIf

		Add Ebp, 4
		Mov Eax, DWord Ptr Ss:[Esp]
		Dec Eax
		Mov DWord Ptr Ss:[Esp], Eax
	.Until Zero?
	Add Esp, 4H

Healer_Skip:
	Mov Ecx, [Esp + 4H]
	Dec Ecx
	Mov [Esp + 4H], Ecx
.Until Zero?
	Add Esp, 0CH
	Pop Ebp
	Pop Esi
	Pop Edi
	Retn


; Make Train snapped
TrainMove:
	Push Edi
	Push Esi
	Push Ebx
	Mov Esi, Ecx
	Mov Eax, [Esi + 8]
	Cmp Word Ptr Ds:[Eax + 10H], 972
.If Zero?
	Mov Al, Byte Ptr Ds:[Esi + 35H] ; Image Angle
	.If Al == 3 || Al == 7
		Mov Eax, DWord Ptr Ds:[Esi + 40H]
		Push Eax
		Push Eax
		Fld DWord Ptr Ds:[Esi + 3CH]
		Fadd DWord Ptr Ds:[Float05]
		Frndint
		Fsub DWord Ptr Ds:[Float05]
		Fstp DWord Ptr Ss:[Esp]
		Mov Eax, DWord Ptr Ds:[Esi + 38H]
		Push Eax

		Mov Ecx, Esi
		Mov Edx, DWord Ptr Ds:[Esi]
		Call DWord Ptr Ds:[Edx + 38H]
		Fstp St
	.EndIf
.EndIf
	Pop Ebx
	Pop Esi
	Pop Edi
	Retn
