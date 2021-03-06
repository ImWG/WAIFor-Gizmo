;EasyCodeName=Defines,1
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
INE_AISIGNAL Equ 1H
INE_QUANTITY Equ 2H
INE_RESOURCE Equ 4H
INE_DIPLOMACY Equ 8H
INE_UNIT Equ 30H
INE_PROTOUNIT Equ 40H
INE_FROMPLAYER Equ 80H
INE_TOPLAYER Equ 100H
INE_TECH Equ 200H
INE_TEXT Equ 400H
INE_SOUND Equ 800H
INE_TIMER Equ 1000H
INE_TRIGGER Equ 2000H
INE_TARGET Equ 0C000H
INE_AREA Equ 0F0000H
INE_CLASS Equ 100000H
INE_SUBTYPE Equ 200000H
INE_NUMBER Equ 400000H
INE_PROTOUNIT_FILTER Equ INE_PROTOUNIT + INE_CLASS + INE_SUBTYPE + INE_FROMPLAYER
INE_UNIT_FILTER Equ INE_UNIT + INE_AREA

INC_QUANTITY Equ 1H
INC_RESOURCE Equ 2H
INC_UNIT Equ 4H
INC_NEXTUNIT Equ 8H
INC_PROTOUNIT Equ 10H
INC_FROMPLAYER Equ 20H
INC_TECH Equ 40H
INC_TIMER Equ 80H
INC_TRIGGER Equ 100H
INC_AREA Equ  Equ 1E00H
INC_CLASS Equ 2000H
INC_SUBTYPE Equ 4000H
INC_AISIGNAL Equ 8000H
INC_PROTOUNIT_FILTER Equ INC_PROTOUNIT + INC_CLASS + INC_SUBTYPE + INC_FROMPLAYER
INC_UNIT_FILTER Equ INC_UNIT + INC_AREA
