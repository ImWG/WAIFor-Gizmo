;EasyCodeName=MemoryWriter,1
.Const

.Data?

.Data

OP_JMP  DB 0E9H
OP_CALL DB 0E8H

.Code

_WriteJmp Proc _jmpFrom:DWord, _jmpTo:DWord, _Function:DWord
	Push Esi
	push edi

	Mov Esi, _jmpFrom
	Mov Edi, _jmpTo
	.If _Function != 0
		Invoke	WriteProcessMemory, hGame, Esi, _Function, 1, 0
	.EndIf

	Mov Eax, Esi
	Inc Eax
	Mov _jmpFrom, Eax

	Mov Eax, Edi
	Sub Eax, Esi
	Sub Eax, 5
	Mov _jmpTo, Eax

	Invoke	WriteProcessMemory, hGame, _jmpFrom, Addr _jmpTo, 4, 0

	pop edi
	pop esi

	ret
_WriteJmp EndP

WriteJmp Proc _jmpFrom, _jmpTo
	Invoke _WriteJmp, _jmpFrom, _jmpTo, Addr OP_JMP
	Ret
WriteJmp EndP

WriteJmps Proc _jmpFroms
	push Esi
	push ebx
	Mov Esi, _jmpFroms

	Mov Eax, [Esi]
	Test Eax, Eax
	.While !Zero?
		Add Esi, 4
		Mov Ebx, [Esi]
		Invoke WriteJmp, Eax, Ebx
		Add Esi, 4
		Mov Eax, [Esi]
		Test Eax, Eax
	.EndW
	pop ebx
	pop Esi
	Ret
WriteJmps EndP


WriteDirectAddress Proc _jmpFrom, _jmpTo, _offset
	Mov Eax, _jmpFrom
	Add Eax, _offset
	Mov _jmpFrom, Eax
	Invoke	WriteProcessMemory, hGame, _jmpFrom, Addr _jmpTo, 4, 0

	Ret
WriteDirectAddress EndP

WriteDirectAddresses Proc _jmpFroms
	push Esi
	Push Ebx
	Mov Esi, _jmpFroms

	Mov Eax, [Esi]
	Test Eax, Eax
	.While !Zero?
		Add Esi, 4
		Mov Ebx, [Esi]
		Add Esi, 4
		Mov Edx, [Esi]
		Invoke WriteDirectAddress, Eax, Ebx, Edx
		Add Esi, 4
		Mov Eax, [Esi]
		Test Eax, Eax
	.EndW
	pop ebx
	pop Esi
	Ret
WriteDirectAddresses EndP


WriteAddress Proc _jmpFrom
	push edi
	push Esi
	
	Mov Esi, _jmpFrom
	mov edi, [Esi+1h]
	sub edi, Esi
	Sub Edi, 5
	Mov _jmpFrom, Edi
	Inc Esi
	Invoke	WriteProcessMemory, hGame, Esi, Addr _jmpFrom, 4, 0
	
	pop Esi
	pop edi
	ret
WriteAddress EndP

WriteAddresses Proc _jmpFroms
	push Esi
	push ebx
	Mov Esi, _jmpFroms

	Mov Eax, [Esi]
	Test Eax, Eax
	.While !Zero?
		Invoke WriteAddress, Eax
		Add Esi, 4
		Mov Eax, [Esi]
		Test Eax, Eax
	.EndW
	pop ebx
	pop Esi
	Ret
WriteAddresses EndP


WriteAddress2 Proc _jmpFrom
	push edi
	push Esi
	
	Mov Esi, _jmpFrom
	Mov Edi, [Esi + 2H]
	sub edi, Esi
	Sub Edi, 6
	Mov _jmpFrom, Edi
	Add Esi, 2
	Invoke	WriteProcessMemory, hGame, Esi, Addr _jmpFrom, 4, 0
	
	pop Esi
	pop edi
	ret
WriteAddress2 EndP

WriteAddresses2 Proc _jmpFroms
	push Esi
	push ebx
	Mov Esi, _jmpFroms

	Mov Eax, [Esi]
	Test Eax, Eax
	.While !Zero?
		Invoke WriteAddress2, Eax
		Add Esi, 4
		Mov Eax, [Esi]
		Test Eax, Eax
	.EndW
	pop ebx
	pop Esi
	Ret
WriteAddresses2 EndP


WritePatch Proc _Patch@, _Patch, _PatchN
	Invoke	WriteProcessMemory, hGame, _Patch@, _Patch, _PatchN, 0
	ret
WritePatch EndP

WritePatches Proc _jmpFroms
	push Esi
	Push Ebx
	Mov Esi, _jmpFroms

	Mov Eax, [Esi]
	Test Eax, Eax
	.While !Zero?
		Add Esi, 4
		Mov Ebx, [Esi]
		Add Esi, 4
		Mov Edx, [Esi]
		Invoke WritePatch, Eax, Ebx, Edx
		Add Esi, 4
		Mov Eax, [Esi]
		Test Eax, Eax
	.EndW
	pop ebx
	pop Esi
	Ret
WritePatches EndP