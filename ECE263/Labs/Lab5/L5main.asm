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

CRG_FLG:	EQU		$0037				; to clear the interupt by writing 1 to RTIF (%10000000)
CRG_INT:	EQU		$0038				; enable the interrupt
RTI_CTL:	EQU		$003B				; RTI clock rate ($40 ~ 1.024 ms)

TSK_1:		EQU 	$1					; Output LCD Display
TSK_2:		EQU 	$2					; Set the output for task 3
TSK_3:		EQU 	$4					; increment the time value (1s)
MODE_FLG:	EQU		$8
UP_FLG:		EQU		$10
DOWN_FLG:	EQU		$20
ENTER_FLG:	EQU		$40

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

SKIP_4:		BITA	#UP_FLG
			BEQ		SKIP_5
			JSR		UP

SKIP_5:		BITA	#DOWN_FLG
			BEQ		SKIP_6
			JSR		DOWN

SKIP_6:		BITA	#ENTER_FLG
			BEQ		SKIP_7
			JSR		ENTER

SKIP_7:		BRA		Main				; main loop to the beginning and check the flags again

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
			CMPA	#$FB
			BEQ		KEY_D.1
			CMPA	#$FD
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

DECODE.1:	CMPB	#$FB
			BNE		DECODE.2
			EORA	#UP_FLG

DECODE.2:	CMPB	#$FD
			BNE		DECODE.3
			EORA	#DOWN_FLG

DECODE.3:	CMPB	#$FE
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
UP:			SEI
			PSHA
			
			LDAA	NUM_2_DISPLAY
			INCA
			STAA	NUM_2_DISPLAY

			PULA
			ANDA	#(UP_FLG ^ $FF)
			STAA	T_FLG

			CLI
			RTS

;************************************
DOWN:		SEI
			PSHA
			
			LDAA	NUM_2_DISPLAY
			DECA
			STAA	NUM_2_DISPLAY

			PULA
			ANDA	#(DOWN_FLG ^ $FF)
			STAA	T_FLG

			CLI
			RTS

;************************************
ENTER:		SEI
			PSHX
			PSHD
			
			LDX		#NUMBERS
			LDD		NUM_2_DISPLAY

			STAA	B,X

			PULD
			ANDA	#(ENTER_FLG ^ $FF)
			STAA	T_FLG
			PULX		
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
			BRA		RTI_END				;

RTI_B1:		STAB	CNTB				;
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
