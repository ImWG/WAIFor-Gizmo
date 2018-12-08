;EasyCodeName=Main,1
.Const

INIFileName DB 'Gizmo.ini', 0
INIPatches  DB 'Patches', 0
INITriggers DB 'Triggers', 0
INIPattern  DB '%d', 0
ININull DB 0

.Data?

.Data

hGame		DD ?
hInst		HINSTANCE	NULL
hModule		HMODULE NULL
hFunction	DD ?

PathPattern DB '%s%s', 0
PathDll DB 256 Dup(0)
INIFile DB 256 Dup(0)
StringBuffer    DB 256 Dup(0)
StringBuffer2   DB 256 Dup(0)
StringBufferInt DB 8 Dup(0)

MAX_MODULES Equ 10 ; Or this would be killed by anti-virus

.Code

DllMain Proc Uses Esi Edi Ecx hInstance, dwReason, lpvReserved

	Invoke	GetCurrentProcess
	Mov Esi, Eax
	Mov hGame, Eax
	Mov Edi, 1

	; ==== Gizmo ====
	; Get DLL Path
	Invoke GetModuleFileName, hInstance, Addr PathDll, 256
	Mov Ecx, Offset PathDll
	Add Ecx, 255
.While Byte Ptr Ds:[Ecx] != '\'
	Dec Ecx
.EndW
	Inc Ecx
	Xor Al, Al
	Mov Byte Ptr Ds:[Ecx], Al

	; Read INI Gizmo Patches
	Mov Edi, 1
	Invoke wsprintf, Addr INIFile, Addr PathPattern, Addr PathDll, Addr INIFileName

	Invoke wsprintf, Addr StringBufferInt, Addr INIPattern, Edi
	Invoke GetPrivateProfileString, Addr INIPatches, Addr StringBufferInt, Addr ININull, Addr StringBuffer, 256, Addr INIFile
.While Edi > MAX_MODULES || Byte Ptr Ds:[StringBuffer] != 0
	; Load DLL
	Invoke wsprintf, Addr StringBuffer2, Addr PathPattern, Addr PathDll, Addr StringBuffer
	Invoke LoadLibrary, Addr StringBuffer2
	Mov hModule, Eax
	Invoke GizmoPatchLoader, hModule

	Inc Edi
	Invoke wsprintf, Addr StringBufferInt, Addr INIPattern, Edi
	Invoke GetPrivateProfileString, Addr INIPatches, Addr StringBufferInt, Addr ININull, Addr StringBuffer, 256, Addr INIFile

.EndW

	; Read INI Gizmo Triggers
	Mov Edi, 1
	Invoke wsprintf, Addr INIFile, Addr PathPattern, Addr PathDll, Addr INIFileName

	Invoke wsprintf, Addr StringBufferInt, Addr INIPattern, Edi
	Invoke GetPrivateProfileString, Addr INITriggers, Addr StringBufferInt, Addr ININull, Addr StringBuffer, 256, Addr INIFile
.If Byte Ptr Ds:[StringBuffer] != 0
	Invoke GizmoInitialize
	.Repeat
		; Load DLL
		Invoke wsprintf, Addr StringBuffer2, Addr PathPattern, Addr PathDll, Addr StringBuffer
		Invoke LoadLibrary, Addr StringBuffer2
		Mov hModule, Eax
		Invoke GizmoTriggerLoader, hModule

		Inc Edi
		Invoke wsprintf, Addr StringBufferInt, Addr INIPattern, Edi
		Invoke GetPrivateProfileString, Addr INITriggers, Addr StringBufferInt, Addr ININull, Addr StringBuffer, 256, Addr INIFile
	.Until Edi > MAX_MODULES || Byte Ptr Ds:[StringBuffer] == 0

.EndIf

	Ret
DllMain EndP

DllEntryPoint Proc hInstance:HINSTANCE, dwReason:DWord, lpvReserved:LPVOID
	.If dwReason == DLL_PROCESS_ATTACH
		Mov Eax, hInstance
		Mov hInst, Eax
		Invoke DllMain, hInst, dwReason, lpvReserved
	.ElseIf dwReason == DLL_PROCESS_DETACH

	.ElseIf dwReason == DLL_THREAD_ATTACH

	.ElseIf dwReason == DLL_THREAD_DETACH

	.EndIf
	Mov Eax, TRUE ;Return TRUE
	Ret
DllEntryPoint EndP

End DllEntryPoint
