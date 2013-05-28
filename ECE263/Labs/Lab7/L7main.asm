;Parallel Ports & LED Display
;Daniel Noyes, Andrew Haas, Benjamin Doiron
;Group 11, Lab 5, March 13th, 2013

;***************************************************************************
;Revision Notes;
;
; Revised Lab 4 and created Lab 5 routines [Dan:March-8-2013]
;

;***************************************************************************
; export symbols

			XDEF Entry, _Startup	; export 'Entry' symbol
			ABSENTRY Entry			; for absolute assembly: mark this as entry point

;***************************************************************************
; equates

RAMStart:	EQU		$1000				; absoolute address of the start of RAM: Variables
ROMSTART:	EQU		$C000				; absolute Address to place code/constant Data
RAM_END:	EQU		$3FFF     			; absolute address  of the End of RAM: Variables

PTA:		EQU		$0000				; Port A
PTB:		EQU		$0001				; Port B [LED display]
PTP:		EQU		$0258				; Port P [LED select]
PTH:		EQU		$0260

DDRA:	  	EQU		$0002				; enable port A [bit specific: 1 = output, 0 = input]
DDRB:	  	EQU		$0003				; enable port B [bit specific: 1 = output, 0 = input]
DDRP:		EQU		$025A				; enable port P
DDRH:		EQU		$0262

ATDCTL2:	EQU		$_02
ATDCTL3:	EQU		$_03
ATDCTL4:	EQU		$_04
ATDCTL5:	EQU		$_05
ATDCTL6:	EQU		$_06
ATDDIEN:	EQU		$_0D
ATDDR0:		EQU		$_10
ATDDR1:		EQU		$_12

CRG_FLG:	EQU		$0037				; to clear the interupt by writing 1 to RTIF (%10000000)
CRG_INT:	EQU		$0038				; enable the interrupt
RTI_CTL:	EQU		$003B				; RTI clock rate ($40 ~ 1.024 ms)

TSK_1:		EQU 	$1					; Output LCD Display
TSK_2:		EQU 	$2					; Set the output for task 3
TSK_3:		EQU 	$4					; increment the time value (1s)
MODE_FLG:	EQU		$8
ENTER_FLG:	EQU		$10
TMP_CON_FLG:EQU		$20

T3COUNT:	EQU		100

LED0		EQU		$3F
LED1		EQU		$06
LED2		EQU		$5B
LED3		EQU		$4F
LED4		EQU		$66
LED5		EQU		$6D
LED6		EQU		$7D
LED7		EQU		$07
LED8		EQU		$7F
LED9		EQU		$6F
LEDA		EQU		$77
LEDB		EQU		$7C
LEDC		EQU		$39
LEDD		EQU		$5E
LEDE		EQU		$79
LEDF		EQU		$71
LED10		EQU		$40

DS1			EQU		$E
DS2			EQU		$D
DS3			EQU		$B
DS4			EQU		$7
DS0			EQU		$F

;***************************************************************************
;variable/data section

    ORG RAMStart

NUM_2_DISPLAY:	DS.B	2   					; Number Display (16-bit)
LEDNUM:			DS.B	1
T_FLG:			DS.B 	1
CNTA:			DS.B	1
CNTB:			DS.B	1
CNT2:			DS.B	1
CNTC:			DS.B	1

NUMBERS:		DS.B	4
NUM_SELECT:		DS.B	1

CURRENT_NUM:	DS.B	1
CURRENT_KEY:	DS.B	1
NEW_KEY:		DS.B	1
KEY_COUNT:		DS.B	1

NUM_TABLE:	DC.B	LED0
			DC.B	LED1
			DC.B	LED2
			DC.B	LED3
			DC.B	LED4
			DC.B	LED5
			DC.B	LED6
			DC.B	LED7
			DC.B	LED8
			DC.B	LED9
			DC.B	LEDA
			DC.B	LEDB
			DC.B	LEDC
			DC.B	LEDD
			DC.B	LEDE
			DC.B	LEDF
			DC.B	LED10

DS_TABLE:	DC.B	DS1
			DC.B	DS2
			DC.B	DS3
			DC.B	DS4

TEMP_TBL:                			; Table with corresponding temperature values replacing the resistance values (0-255)
			DC.B  $90				; 0
			DC.B  $90				; 1
			DC.B  $90				; 2
			DC.B  $90				; 3
			DC.B  $90				; 4
			DC.B  $90				; 5
			DC.B  $90				; 6
			DC.B  $90				; 7
			DC.B  $90				; 8
			DC.B  $90				; 9
			DC.B  $90				; 10
			DC.B  $90				; 11
			DC.B  $90				; 12
			DC.B  $90				; 13
			DC.B  $90				; 14
			DC.B  $90				; 15
			DC.B  $90				; 16
			DC.B  $90				; 17
			DC.B  $90				; 18
			DC.B  $90				; 19
			DC.B  $90				; 20
			DC.B  $90				; 21
			DC.B  $90				; 22
			DC.B  $90				; 23
			DC.B  $90				; 24
			DC.B  $90				; 25
			DC.B  $90				; 26
			DC.B  $90				; 27
			DC.B  $90				; 28
			DC.B  $90				; 29
			DC.B  $90				; 30
			DC.B  $90				; 31
			DC.B  $90				; 32
			DC.B  $90				; 33
			DC.B  $90				; 34
			DC.B  $90				; 35
			DC.B  $90				; 36
			DC.B  $90				; 37
			DC.B  $90				; 38
			DC.B  $90				; 39
			DC.B  $90				; 40
			DC.B  $90				; 41
			DC.B  $90				; 42
			DC.B  $90				; 43
			DC.B  $90				; 44
			DC.B  $90				; 45
			DC.B  $90				; 46
			DC.B  $90				; 47
			DC.B  $90				; 48
			DC.B  $90				; 49
			DC.B  $90				; 50
			DC.B  $90				; 51
			DC.B  $90				; 52
			DC.B  $90				; 53
			DC.B  $90				; 54
			DC.B  $90				; 55
			DC.B  $90				; 56
			DC.B  $90				; 57
			DC.B  $90				; 58
			DC.B  $90				; 59
			DC.B  $90				; 60
			DC.B  $90				; 61
			DC.B  $90				; 62
			DC.B  $90				; 63
			DC.B  $90				; 64
			DC.B  $90				; 65
			DC.B  $90				; 66
			DC.B  $90				; 67
			DC.B  $90				; 68
			DC.B  $90				; 69
			DC.B  $90				; 70
			DC.B  $90				; 71
			DC.B  $90				; 72
			DC.B  $90				; 73
			DC.B  $90				; 74
			DC.B  $90				; 75
			DC.B  $90				; 76
			DC.B  $90				; 77
			DC.B  $90				; 78
			DC.B  $90				; 79
			DC.B  $90				; 80
			DC.B  $90				; 81
			DC.B  $90				; 82
			DC.B  $90				; 83
			DC.B  $90				; 84
			DC.B  $90				; 85
			DC.B  $90				; 86
			DC.B  $90				; 87
			DC.B  $90				; 88
			DC.B  $90				; 89
			DC.B  $90				; 90
			DC.B  $90				; 91
			DC.B  $90				; 92
			DC.B  $90				; 93
			DC.B  $90				; 94
			DC.B  $90				; 95
			DC.B  $90				; 96
			DC.B  $90				; 97
			DC.B  $90				; 98
			DC.B  $90				; 99
			DC.B  $90				; 100
			DC.B  $90				; 101
			DC.B  $90				; 102
			DC.B  $90				; 103
			DC.B  $90				; 104
			DC.B  $90				; 105
			DC.B  $90				; 106
			DC.B  $90				; 107
			DC.B  $90				; 108
			DC.B  $89				; 109
			DC.B  $89				; 110
			DC.B  $88				; 111
			DC.B  $87				; 112
			DC.B  $86				; 113
			DC.B  $86				; 114
			DC.B  $85				; 115
			DC.B  $85				; 116
			DC.B  $85				; 117
			DC.B  $83				; 118
			DC.B  $83				; 119
			DC.B  $82				; 120
			DC.B  $81				; 121
			DC.B  $81				; 122
			DC.B  $80				; 123
			DC.B  $79				; 124
			DC.B  $79				; 125
			DC.B  $78				; 126
			DC.B  $77				; 127
			DC.B  $77				; 128
			DC.B  $76				; 129
			DC.B  $75				; 130
			DC.B  $75				; 131
			DC.B  $74				; 132
			DC.B  $73				; 133
			DC.B  $73				; 134
			DC.B  $72				; 135
			DC.B  $72				; 136
			DC.B  $71				; 137
			DC.B  $70				; 138
			DC.B  $70				; 139
			DC.B  $69				; 140
			DC.B  $68				; 141
			DC.B  $68				; 142
			DC.B  $67				; 143
			DC.B  $67				; 144
			DC.B  $66				; 145
			DC.B  $65				; 146
			DC.B  $65				; 147
			DC.B  $64				; 148
			DC.B  $63				; 149
			DC.B  $63				; 150
			DC.B  $62				; 151
			DC.B  $61				; 152
			DC.B  $61				; 153
			DC.B  $60				; 154
			DC.B  $60				; 155
			DC.B  $59				; 156
			DC.B  $58				; 157
			DC.B  $58				; 158
			DC.B  $57				; 159
			DC.B  $56				; 160
			DC.B  $56				; 161
			DC.B  $55				; 162
			DC.B  $54				; 163
			DC.B  $54				; 164
			DC.B  $53				; 165
			DC.B  $52				; 166
			DC.B  $52				; 167
			DC.B  $51				; 168
			DC.B  $50				; 169
			DC.B  $49				; 170
			DC.B  $49				; 171
			DC.B  $48				; 172
			DC.B  $48				; 173
			DC.B  $47				; 174
			DC.B  $46				; 175
			DC.B  $46				; 176
			DC.B  $45				; 177
			DC.B  $44				; 178
			DC.B  $44				; 179
			DC.B  $43				; 180
			DC.B  $42				; 181
			DC.B  $42				; 182
			DC.B  $41				; 183
			DC.B  $40				; 184
			DC.B  $40				; 185
			DC.B  $40				; 186
			DC.B  $40				; 187
			DC.B  $40				; 188
			DC.B  $40				; 189
			DC.B  $40				; 190
			DC.B  $40				; 191
			DC.B  $40				; 192
			DC.B  $40				; 193
			DC.B  $40				; 194
			DC.B  $40				; 195
			DC.B  $40				; 196
			DC.B  $40				; 197
			DC.B  $40				; 198
			DC.B  $40				; 199
			DC.B  $40				; 200
			DC.B  $40				; 201
			DC.B  $40				; 202
			DC.B  $40				; 203
			DC.B  $40				; 204
			DC.B  $40				; 205
			DC.B  $40				; 206
			DC.B  $40				; 207
			DC.B  $40				; 208
			DC.B  $40				; 209
			DC.B  $40				; 210
			DC.B  $40				; 211
			DC.B  $40				; 212
			DC.B  $40				; 213
			DC.B  $40				; 214
			DC.B  $40				; 215
			DC.B  $40				; 216
			DC.B  $40				; 217
			DC.B  $40				; 218
			DC.B  $40				; 219
			DC.B  $40				; 220
			DC.B  $40				; 221
			DC.B  $40				; 222
			DC.B  $40				; 223
			DC.B  $40				; 224
			DC.B  $40				; 225
			DC.B  $40				; 226
			DC.B  $40				; 227
			DC.B  $40				; 228
			DC.B  $40				; 229
			DC.B  $40				; 230
			DC.B  $40				; 231
			DC.B  $40				; 232
			DC.B  $40				; 233
			DC.B  $40				; 234
			DC.B  $40				; 235
			DC.B  $40				; 236
			DC.B  $40				; 237
			DC.B  $40				; 238
			DC.B  $40				; 239
			DC.B  $40				; 240
			DC.B  $40				; 241
			DC.B  $40				; 242
			DC.B  $40				; 243
			DC.B  $40				; 244
			DC.B  $40				; 245
			DC.B  $40				; 246
			DC.B  $40				; 247
			DC.B  $40				; 248
			DC.B  $40				; 249
			DC.B  $40				; 250
			DC.B  $40				; 251
			DC.B  $40				; 252
			DC.B  $40				; 253
			DC.B  $40				; 254
			DC.B  $40				; 255

;***************************************************************************
; Code section

    ORG	ROMSTART

Entry:
_Startup:

;***************************************************************************
; Inilitilizing the program

			LDS		#RAM_END			; initialize the stack pointer.
			LDAA	#%10000000			; load the 1 in 7th bit to enable the ...
			STAA 	CRG_INT				; and set the period counter.
			LDAA	#$40				; loads a value (hex 40) to the clock ... 
			STAA	RTI_CTL				; for a 1 ms clock rate for the rti

			CLR		T_FLG				; reset the task flag
			CLR		CNTA				; reset the count variable A [rti-subroutine]
			CLR		CNTB				; reset the count variable B [rti-subroutine]
			CLR		NUM_2_DISPLAY
			CLR		(NUM_2_DISPLAY+1)
			CLR		LEDNUM

			CLR		KEY_COUNT
			CLR		CURRENT_KEY

			CLR		(NUMBERS)			;clear all the numbers
			CLR		(NUMBERS+1)
			CLR		(NUMBERS+2)
			LDAA	#$FF
			STAA	(NUMBERS+3)			;set min as a $FF so it can change

			LDAA	#%10000000			;initilize the A/D converter
			STAA	ATDCTL2				;powerup
			LDAA	#%00010000
			STAA	ATDCTL3				;set the sequence
			LDAA	#%10000000
			STAA	ATDCTL4				;set 8 bit resolution

			LDAA	#$FF
			STAA	DDRB
			STAA	DDRP
			CLI							; clear the i bit

;***************************************************************************
; Subroutines

;***************************************************************************
; Main Routine

Main:		LDAA	T_FLG				; Loads the Task flag to check for a specific task flag
			BITA	#TSK_1				; Check the task flag towards the first task flag
			BEQ		SKIP_1				; if the flag is not checked will skip to next check
			JSR		TASK_1				; jumps to task 1

SKIP_1:		BITA	#TSK_2				;
			BEQ		SKIP_2				; skip to task 2
			JSR		TASK_2				; jumps to task 2

SKIP_2:		BITA	#TSK_3				;
			BEQ		SKIP_3				; skip task 3
			JSR		TASK_3				; jumps to task 3

SKIP_3:		BITA	#MODE_FLG
			BEQ		SKIP_4
			JSR		MODE

SKIP_4:		BITA	#ENTER_FLG
			BEQ		SKIP_5
			JSR		ENTER
SKIP_5:		BITA	#TMP_CON_FLG
			BEQ		SKIP_6
			JSR		TMP_CON

SKIP_6:		BRA		Main				; main loop to the beginning and check the flags again

;***************************************************************************
;Task 1
;
;	Display the value of the LCD to the seven segment Display
;

TASK_1:		PSHA
			LDX		#NUM_TABLE
			LDY		#DS_TABLE

			LDAB	LEDNUM				; goes through which LED to display
			CMPB	#0					; every time it will increment
			BNE		T1.1				; till it reaches 4 and restarts
			JSR		DSET0
T1.1:		CMPB	#1
			BNE		T1.2
			JSR		DSET1
T1.2:		CMPB	#2
			BNE		T1.3
			JSR		DSET2
T1.3:		CMPB	#3
			BNE		T1.4
			JSR		DSET3			

T1.4:		LDAB	LEDNUM
			INCB
			CMPB	#$4
			BNE		T1.5
			LDAB	#$0

T1.5:		STAB	LEDNUM
			SEI
			PULA						; returns the task flag from the stack to A
			ANDA	#(TSK_1 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							; allow rti

			RTS							; RETURN from stack

;***************************************************************************
; Display
; This will display a given value
; Req: 	A: number
;		B: LED Select
; 		X: number Select table
;		Y: LED Select table
;
;disable display -> set LED val[a+x] -> enable display[b+y]
;

DISPLAY:	PSHB
			LDAB	#DS0
			STAB	PTP
			LDAA	A,X
			STAA	PTB
			PULB
			LDAB	B,Y
			STAB	PTP
			RTS

;***************************************************************************
; Set the Value based on which number to display
;
; SETN		[0][1][2][3]
;

DSET0:		LDAA	NUM_2_DISPLAY		;loads the 1st byt
			LSRA						;then move it right -> 4 bits
			LSRA						; to get they digit we want
			LSRA
			LSRA
			JSR		DISPLAY				;display function
			RTS

DSET1:		LDAA	NUM_2_DISPLAY
			ANDA	#$F					;mask 1st nibble with a and
			JSR		DISPLAY
			RTS

DSET2:		LDAA	#$10
			JSR		DISPLAY
			RTS

DSET3:		LDAA	(NUM_2_DISPLAY+1)
			ANDA	#$F					;need to mask 1st nibble
			JSR		DISPLAY
			RTS

;***************************************************************************
;Task 2
;	for this operation we grab a variable from the memory. This variable was
;	set to a 100 during initilization. Everytime task 2 starts, it checks to
;	see if the value in the memory is 0. 
;	true  = reset the value bask to 100 and flag task 3. 
;	false = decrease the memory and ends the routine
;

TASK_2									; pushes the task flag onto the stack to save it

			JSR	KEY_DETECT
		  
T2.END		SEI							;
			ANDA	#(TSK_2 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;

			CLI							;
			RTS							; RETURN from stack
        
;***************************************************************************
;Task 3
;	Will add one to the count
;

TASK_3		JSR	DECODE

			SEI							;
			LDAA	T_FLG						; returns the task flag from the stack to A
			ANDA	#(TSK_3 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							;
			RTS							; RETURN from stack


;***************************************************************************
;Lab 5 Functions
;

KEY_DETECT: PSHA
			LDAA	PTH

			CMPA	#$FF
			BEQ		KEY_D.ER

			CMPA	#$F7
			BEQ		KEY_D.1
			CMPA	#$FE
			BEQ		KEY_D.1

KEY_D.ER:	LDAB	#$FF
			STAB	NEW_KEY
			JSR		DEBOUNCE
			PULA
			BRA		KEY_D.END

KEY_D.1:	STAA	NEW_KEY
			PULA
			JSR		DEBOUNCE

KEY_D.END:	RTS



;************************************
DEBOUNCE:	SEI
			PSHD
			CLI
			LDAA	NEW_KEY
			CMPA	CURRENT_KEY
			BNE		DEB.1
			LDAA	#$0
			STAA	KEY_COUNT
			PULD
			BRA		DEB.END

DEB.1		LDAB	KEY_COUNT
			INCB
			CMPB	#$5
			BEQ		DEB.2
			STAB	KEY_COUNT
			SEI
			PULD
			CLI
			BRA		DEB.END

DEB.2		STAA	CURRENT_KEY
			LDAB	#$0
			STAB	KEY_COUNT
			SEI
			PULD
			EORA	#TSK_3				; set task 3
			STAA	T_FLG				; Store Task flag
			CLI
	

DEB.END		RTS

;************************************

DECODE:		SEI
			PSHB
			CLI
			LDAB	CURRENT_KEY

			CMPB	#$F7
			BNE		DECODE.1
			EORA	#MODE_FLG

DECODE.1:	CMPB	#$FE
			BNE		DECODE.E
			EORA	#ENTER_FLG

DECODE.E:	STAA	T_FLG
			SEI
			PULB
			CLI
			RTS

;************************************
MODE:		
			PSHA
			PSHX

			LDAA	NUM_2_DISPLAY			;variable

			LDAB	(NUM_2_DISPLAY+1)		;which variable
			INCB
			CMPB	#$4
			BLT		MODE.1
			CLRB
MODE.1:		STAB	(NUM_2_DISPLAY+1)
			LDX		#NUMBERS
			LDAA	B,X
			STAA	NUM_2_DISPLAY

			PULX
			PULA
			ANDA	#(MODE_FLG ^ $FF)
			STAA	T_FLG
			RTS

;************************************
ENTER:		SEI
			PSHX
			PSHD
			
			CLR		(NUMBERS+2)
			LDAA	#$FF
			STAA	(NUMBERS+3)

			PULD
			ANDA	#(ENTER_FLG ^ $FF)
			STAA	T_FLG
			PULX		
			CLI	
			RTS


;*************************************
;Temperature measurement and conversion routine
;save largest of chan 1 (inside to the max and min)
TMP_CON:	SEI
			PSHD

			LDAA	#%10010010			;start the A/D
			STAA	ATDCTL5

TMP_CON_1:	LDAA	ATDCTL6				;grabing AN2
			BITA	#%10000000
			BNE		TMP_CON_2
			NOP
			BRA		TMP_CON_1

TMP_CON_2:	LDAA	ATDDR0
			STAA	NUMBERS

			LDAA	ATDDR1
			STAA	(NUMBERS+1)

			CMPA	(NUMBERS+2)
			BLE		TMP_CON_3
			STAA	(NUMBERS+2)

TMP_CON_3:	CMPA	(NUMBERS+3)
			BGE		TMP_CON_4
			STAA	(NUMBERS+3)

TMP_CON_4:
			PULD
			ANDA	#(TMP_CON_FLG ^ $FF)
			STAA	T_FLG
			CLI
			RTS

;***************************************************************************
;RTI
;	maintain two counters that will increment by 1 each time RTI is entered
;	CNTA 0->4 : set task flag 1
;	CNTB 0->9 : set task flag 2
;	clear the interrupt when leaving the RTI
;

RTI_ISR:	LDAA	CNTA				; 
			LDAB	CNTB				; loads CNTA & CNTB and proceed with the loop checks

			INCA						; add to count A and check to see if it is a 4
			CMPA	#4					; true  = flag task 1, reset count A
			BNE		RTI_A1				; false = skips and goes to count B
			LDAA	#0					;
			STAA	CNTA				;
			LDAA	T_FLG
			EORA	#TSK_1				;
			STAA	T_FLG				;
			BRA		RTI_B				;
RTI_A1:		STAA	CNTA				;

RTI_B:		INCB						; adds to count B and check to see if it is a 9
			CMPB	#9					; true  = flag task 2, reset count B
			BNE		RTI_B1				; false = skip and return from the interupt
			LDAB	#0					;
			STAB	CNTB				;
        	LDAA	T_FLG
			EORA	#TSK_2				;
			STAA	T_FLG				;
			BRA		RTI_C				;

RTI_B1:		STAB	CNTB				;

RTI_C:		LDAA	CNTC
			INCA
			CMPA	#0
			BNE		RTI_C1
			STAA	CNTC
			LDAA	T_FLG
			EORA	#TMP_CON_FLG
			STAA	T_FLG
			BRA		RTI_END

RTI_C1:		STAA	CNTC

RTI_END:	LDAA	#%10000000			;
			STAA	CRG_FLG				; clear the interupt
			RTI       					; RETURN from interupt

;***************************************************************************
; catch-all isr
;	if any onther task flags are enabled then will return from their interupts
;

DFLT_ISR:	NOP							; let cpu hang for a second
			RTI							; RETURN from the interupt routine

;***************************************************************************
; Interrupt Vectors [rti interupts]
;	writes the memory locations for various interrupts to prevent the system
;	from hanging 
;
                           
			ORG     $FFF0				;
			DC.W	RTI_ISR				;rti    
			DC.W	DFLT_ISR			;irq pin
			DC.W	DFLT_ISR			;xirq pin
			DC.W	DFLT_ISR			;swi                   
			DC.W	DFLT_ISR			;non_inst             
			DC.W	DFLT_ISR			;cop fail             
			DC.W	DFLT_ISR			;clk fail     
			DC.W    Entry				;reset vector
