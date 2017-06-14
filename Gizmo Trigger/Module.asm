;EasyCodeName=Module,1
.Const

; ==== Interfaces ====
; NOTE: If you don't create either conditions nor effects, you can remove them both in ASM and DEF files.

; Effects
__EffectCount  DD 4
__EffectNames  DD Offset Name1, Offset Name2, Offset Name3, Offset Name4
; Inputs:Dword, Necessary Inputs:Dword
__EffectInputs DD INE_QUANTITY + INE_PROTOUNIT_FILTER + INE_UNIT_FILTER, 0
		DD INE_TEXT + INE_FROMPLAYER + INE_RESOURCE, 0
		DD INE_TEXT + INE_FROMPLAYER, 0
		DD INE_TEXT + INE_FROMPLAYER, 0
__Effects      DD Offset ChangeIcon
		DD Offset ChoiceBox
		DD Offset SaveResources
		DD Offset LoadResources

; Conditions
__ConditionCount  DD 1
__ConditionNames  DD Offset CName1
__ConditionInputs DD INC_FROMPLAYER + INC_QUANTITY, 0
__Conditions      DD Offset Civilization

; Address List To Change (Offset 1, For FakeJmp and FakeCall)
__Addresses    DD Offset ChangeIcon_1, 0
; Address List To Change (Offset 2, For Fake Conditional Jumps)
__Addresses2   DD Offset Civilization_01, 0


.Data?

.Data

Name1 DB 'Change Icon', 0
Name2 DB 'Show Choice Box', 0
Name3 DB 'Save Resources To File', 0
Name4 DB 'Load Resources From File', 0

CName1 DB 'Civilization', 0

ResSavePattern DB '%s%s.res', 0


.Code

; Entry, can't be ignored
DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	Mov Eax, TRUE
	Ret
DllEntryPoint EndP


; ==== Effects ====

ChangeIcon:
    Mov Eax, [Esp + 10H]
    xor ebp,ebp
    cmp eax,ebx
    Jle ChangeIcon_back
    lea ebx,[esp+94h]
    
ChangeIcon_start:
    mov esi,[ebx]
    mov eax,[esi+8]
    Cmp Byte Ptr Ds:[Eax + 4], 46H
    Jb ChangeIcon_end
    Mov Ecx, Esi
ChangeIcon_1:
    FakeCall 004C6400H
    Xor Edx, Edx
    Mov Edx, [Edi + 10H]
    mov ecx,[esi+8]
    Mov Word Ptr Ds:[Ecx + 54H], Dx
    
ChangeIcon_end: ;loc_7DD497
    mov eax,[esp+10h]
    inc ebp
    add ebx,4
    cmp ebp, eax
    Jl ChangeIcon_start
    
ChangeIcon_back:
    pop edi
    pop esi
    pop ebp
    mov al, 1
    pop ebx
    add esp,2034h
    Retn 4


ChoiceBox:
	Sub Esp, 100H
	Invoke  GetActiveWindow
	Mov Ebp, Eax
	Mov Esi, Esp

	Invoke  GetWindowText, Ebp, Esi, 255
	Mov Edx, DWord Ptr Ds:[Edi + 6CH]
	Invoke  MessageBox, Ebp, Edx, Esi, MB_ICONQUESTION + MB_YESNO
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
    pop esi
    pop ebp
    mov al, 1
    pop ebx
    add esp,2034h
    Retn 4


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
    pop esi
    pop ebp
    mov al, 1
    pop ebx
    add esp,2034h
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
    pop esi
    pop ebp
    mov al, 1
    pop ebx
    add esp,2034h
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
    pop ebp
    pop ebx
    add esp,0Ch
    retn 8



End DllEntryPoint
