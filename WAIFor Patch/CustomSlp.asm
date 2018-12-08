;EasyCodeName=CustomSlp,1
.Const

Unit1 Equ 004E8DE7H
Unit2 Equ 00516EC0H
Build1 Equ 004E8E5BH
Build2 Equ 00516FC3H
Tech Equ 00516F0DH



;__CustomSLP_Patches
;	DD 0

__CustomSLP_Addrs DD Offset CustomIcons_1, Offset CustomIcons_2, Offset CustomIcons_3, Offset CustomIcons_4
	DD Offset Custom_LoadName_1, Inflate_1, CustomZipIcons_1, CustomZipIcons_2, CustomZipIcons_3, CustomZipIcons_4
	DD DeleteUnzipFiles_1, UnzipSlpCheck_1, UnzipSlpCheck_2
	DD 004E8DE7H, 00516EC0H, 004E8E5BH, 00516FC3H, 00516F0DH, 00516F5AH
	DD 0

__CustomSLP_Addrs2 DD UnzipSlpCheck_01
	DD 0

__CustomSLP_Dircts DD 004E8DE7H, Offset CustomIcons, 1 ; Unit
	DD 00516EC0H, Offset CustomIcons, 1
	DD 004E8E5BH, Offset CustomIcons, 1 ; Building
	DD 00516FC3H, Offset CustomIcons, 1
	DD 00516F0DH, Offset CustomIcons, 1 ; Tech
	DD 00516F5AH, Offset CustomIcons, 1 ; Command
	DD 0

__CustomSLP_Jmps DD 007C847EH, Offset Custom_LoadName
	DD 007C8554H, Offset UnzipSlpCheck
	DD 0


.Data?

.Data

Align 4
; Include units, buildings, techs and commands.
CustomSLPIds DD 50730, 50706, 50729, 50721, -1
ZippedFlag DD 0

.Code

Custom_LoadName: ; @007C847Eh
	Mov CustomTagLocation, Edx
	Push 007C8ECDH
Custom_LoadName_1:
	FakeJmp 007C8483H


; ecx-some object, arg1-filename, arg2-slp id
CustomIcons:
	Push Esi
	Push Edi
	Push Ebp
	Push Ebx
	Mov Esi, Ecx

	Mov Edi, DWord Ptr Ds:[CustomTagLocation]
	Test Edi, Edi
	Je CustomIcons_Skip
	Push Offset CustomSLPTag
	Push Edi
CustomIcons_1:
	FakeCall 00614E60H
	Add Esp, 8
	Test Eax, Eax
	Je CustomIcons_Skip
	Sub Esp, 160H
	Push Esp
	Push Offset CustomSLPTagPattern
	Push Eax
CustomIcons_4:
	FakeCall 0061567CH ; RegExp
	Add Esp, 0CH
	Cmp Eax, 1
	Jne CustomIcons_Skip_
	Mov Edi, Esp
	Or Ecx, -1
	Xor Eax, Eax
	Repne Scas Byte Ptr Es:[Edi]
	Mov Edi, Esp

	Mov Ecx, DWord Ptr Ss:[Esp + 178H] ; ecx = arg2
	Mov Eax, DWord Ptr Ds:[ZippedFlag]
	Test Eax, Eax
	Jne CustomZipIcons ; If zipped exists, use it instead of separated files.

.If Ecx == 50730
	Mov Ecx, Edi
	Mov Eax, -1
	Mov DWord Ptr Ds:[ZippedFlag], Eax
	Call Inflate
	Mov Ecx, 50730
	Test Eax, Eax
	Jne CustomZipIcons_First
	Mov DWord Ptr Ds:[ZippedFlag], Eax
	Mov Ecx, Offset CustomSlotIconUnit
.ElseIf Ecx == 50706
	Mov Ecx, Offset CustomSlotIconBuild
.ElseIf Ecx == 50729
	Mov Ecx, Offset CustomSlotIconTech
.Else
	Jmp CustomIcons_Skip_
.EndIf
	Mov Ebp, 0018EFACH ; Note: this is a hack way, to get scenario path.
	Lea Eax, [Esp + 60H]
	Invoke wsprintf, Eax, Addr CutsomSLPPattern, Ebp, Edi, Ecx
	Lea Edi, [Esp + 60H]
	Push Edi
CustomIcons_2:
	FakeCall 00543040H
	Add Esp, 4
	Test Al, Al

.If !Zero?
	Add Esp, 160H
	Mov Ecx, Esi
	Push - 1
	Push Edi
.Else
CustomIcons_Skip_:
	Add Esp, 160H
CustomIcons_Skip:
	Mov Ecx, Esi
	Mov Edx, DWord Ptr Ss:[Esp + 14H]
	Mov Eax, DWord Ptr Ss:[Esp + 18H]
	Push Eax
	Push Edx
.EndIf

CustomIcons_3:
	FakeCall 004DAE00H
	Pop Ebx
	Pop Ebp
	Pop Edi
	Pop Esi
	Retn 8H


; Load icons from zip file
CustomZipIcons_First:
	Xor Eax, Eax
	Mov Al, 5 ; Buildings would load 5 times for each civ
	Mov DWord Ptr Ds:[ZippedFlag], Eax
	Jmp CustomZipIcons_

CustomZipIcons:
	Cmp Ecx, 50706
	Jne CustomZipIcons_
	Mov Eax, DWord Ptr Ds:[ZippedFlag]
	Dec Eax
	Mov DWord Ptr Ds:[ZippedFlag], Eax ; End of Zipped

CustomZipIcons_:
	Add Esp, 160H
	Push Ecx
	Mov Edx, DWord Ptr Ds:[Plc]
	Mov Edx, DWord Ptr Ds:[Edx + 28H]
	Lea Edx, [Edx + 187BH] ; RM Path
	Push Edx
	Push 7C8EC4H ; Pattern
	Push 785FB8H ; Target Str
CustomZipIcons_2:
	FakeCall 0061442BH
	Mov Eax, 785FB8H
	Add Esp, 10H
	Mov Edi, Eax
	Push Edi
CustomZipIcons_3:
	FakeCall 00543040H
	Add Esp, 4
	Test Al, Al
.If Zero? ; No alternative file
	Mov Ecx, Esi
	Mov Edx, DWord Ptr Ss:[Esp + 14H]
	Mov Eax, DWord Ptr Ss:[Esp + 18H]
	Push Eax
	Push Edx
CustomZipIcons_4:
	FakeCall 004DAE00H

.Else ; Alternative is available
	Mov Ecx, Esi
	Push - 1 ; Id, -1 is file only
	Push Edi ; Filename
CustomZipIcons_1:
	FakeCall 004DAE00H

	Mov Edx, DWord Ptr Ss:[Esp + 18H]
	Cmp Edx, 50706
	.If Zero?
		Mov Edx, DWord Ptr Ds:[ZippedFlag]
		Test Dl, Dl
		.If Zero?
			Push Eax
			Call DeleteUnzipFiles
;			Push Eax
;			Mov Edx, DWord Ptr Ds:[Plc]
;			Mov Edx, DWord Ptr Ds:[Edx + 28H]
;			Lea Edx, [Edx + 187BH] ; RM Path
;			Invoke  wsprintf, 785FB8H, Offset RemoveZipSLPPattern, Edx
;			;Invoke  DeleteFile, 785FB8H
			Pop Eax
		.EndIf
	.EndIf

.EndIf
	Pop Ebx
	Pop Ebp
	Pop Edi
	Pop Esi
	Retn 8H


Inflate:
	Push Esi
	Push Edi
	Sub Esp, 164H
	Mov Esi, Ecx
	Mov Edi, Esp
	Mov Ecx, Edi
.Repeat
	Mov Al, Byte Ptr Ds:[Esi]
	Mov Byte Ptr Ds:[Edi], Al
	Inc Esi
	Inc Edi
	Test Al, Al
.Until Zero?
	Dec Edi
	Mov DWord Ptr Ds:[Edi], 70697A2EH
	Mov Byte Ptr Ds:[Edi + 4], Al
	Push 0D44H
	Push Ecx
	Xor Ecx, Ecx
Inflate_1:
	FakeCall 007C80F0H
	Add Esp, 164H
	Pop Edi
	Pop Esi
	Retn

; Remove extracted files
DeleteUnzipFiles:
	Push Esi
	Push Ebp
	Mov Ebp, Offset CustomSLPIds
	Mov Edx, DWord Ptr Ds:[Plc]
	Mov Edx, DWord Ptr Ds:[Edx + 28H]
	Lea Esi, [Edx + 187BH] ; RM Path
	Mov Eax, DWord Ptr Ds:[Ebp]
	Cmp Eax, -1
.While !Zero?
	Push Eax
	Push Esi
	Push 7C8EC4H ; Pattern
	Push 785FB8H ; Target Str
DeleteUnzipFiles_1:
	FakeCall 0061442BH
	Add Esp, 10H
	Invoke  DeleteFile, 785FB8H
	Add Ebp, 4
	Mov Eax, DWord Ptr Ds:[Ebp]
	Cmp Eax, -1
.EndW
	Pop Ebp
	Pop Esi
	Retn


; Check for zip types:
UnzipSlpCheck:
	Mov Eax, DWord Ptr Ds:[ZippedFlag]
	Test Eax, Eax
.If Zero?
	Cmp Edx, 303531H ; Terrain
UnzipSlpCheck_1:
	FakeJmp 007C855AH
.EndIf
	Cmp Edx, 373035H ; Icon
UnzipSlpCheck_01:
	FakeJne 007C8587H
UnzipSlpCheck_2:
	FakeJmp 007C858DH


;Invoke  GetActiveWindow ; Debug code
;Invoke  MessageBox, Eax, Addr TerrNameAcacia, Addr TerrNameAcacia, MB_OK