;EasyCodeName=Defines,1
.Const

.Data?

.Data

.Code

FakeJmp Macro _Address
	DB 0E9H
	DD _Address
EndM

FakeCall Macro _Address
	DB 0E8H
	DD _Address
EndM


FakeJb Macro _Address
	DB 0FH, 82H
	DD _Address
EndM

FakeJae Macro _Address
	DB 0FH, 83H
	DD _Address
EndM

FakeJe Macro _Address
	DB 0FH, 84H
	DD _Address
EndM

FakeJne Macro _Address
	DB 0FH, 85H
	DD _Address
EndM

FakeJbe Macro _Address
	DB 0FH, 86H
	DD _Address
EndM

FakeJa Macro _Address
	DB 0FH, 87H
	DD _Address
EndM

FakeJl Macro _Address
	DB 0FH, 8CH
	DD _Address
EndM

FakeJge Macro _Address
	DB 0FH, 8DH
	DD _Address
EndM

FakeJle Macro _Address
	DB 0FH, 8EH
	DD _Address
EndM

FakeJg Macro _Address
	DB 0FH, 8FH
	DD _Address
EndM


SUB_REFRESH_GRAPHIC Equ 005CDC10H
SUB_TRANSFORM Equ 004C1A50H
SUB_TELEPORT Equ 005CFD90H
SUB_DROPUNIT Equ 00456A40H
SUB_UNIQUEUNIT Equ 004C6400H
SUB_CHECKUNITSPACE Equ 00463370H

SUB_RANDOM Equ 007B2820H

; Constatnt
Plc Equ 007912A0H
Float1 Equ 00635BC8H ; Hero Healing Rate
Float100 Equ 006355D8H
Float05 Equ 00635978H
Float0 Equ 006355C8H
Float0001 Equ 00635970H


; Inputs
IN_QUANTITY Equ 2H ; +1
IN_UNIT Equ 10H ; +4
IN_PROTO Equ 40H + 80H ; +6
IN_RESOURCE Equ 1000H ; +0c
IN_AREA Equ F0000H ; + 10[4]
IN_CLASS Equ 300000H ; +14[2]
IN_NUMBER Equ 800000H ; +16