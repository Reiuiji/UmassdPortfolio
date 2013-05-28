;Daniel Noyes
;optional lab 8
;Enhanced capture Timer Module ECT
;Engine Controller

;***************************************************************************
; export symbols

			XDEF Entry, _Startup	; export 'Entry' symbol
			ABSENTRY Entry			; for absolute assembly: mark this as entry point

;***************************************************************************
; equates

RAMStart:	EQU		$1000			; absoolute address of the start of RAM: Variables
ROMSTART:	EQU		$C000			; absolute Address to place code/constant Data
RAM_END:	EQU		$3FFF     		; absolute address  of the End of RAM: Variables

;PTP:		EQU		$

TIOS:		EQU		$40
TSCR1:		EQU		$46
TSCR2:		EQU		$4D
TCTL1:		EQU		$48
TCTL2:		EQU		$49
TCTL3:		EQU		$4A
TCTL4:		EQU		$4B
TFLG1:		EQU		$4E
TIE:		EQU		$4C


;***************************************************************************
;variable/data section

    ORG RAMStart

;***************************************************************************
; Code section

    ORG	ROMSTART

Entry:
_Startup:

;***************************************************************************
; Inilitilizing the ECT

LDAA	#$80		;enable timer
ORAA	TSCR1
STAA	TSCR1

LDAA	TSCR2		;set time prescscale
ANDA	#%11111000	;000 = Div by 1
STAA	TSCR2

LDAA	TIOS
ORAA	#%00011110	;set channel 1,2,3,4 as output Compare
ANDA	#%11111110	;set channel 0 as a input capture
STAA	TIOS

LDAA	#%00000001	;set PA for ch 0 for high input(01 rising edge)
STAA	TCTL4

LDAA	#%10101000	;set PA for ch 1-3 as a low output (10 clear)
STAA	TCTL2

LDAA	#%00000010	;set PA for ch 4 as a low output
STAA	TCTL1

LDAA	#%00000001	;clear ch 0 status
STAA	TFLG1





