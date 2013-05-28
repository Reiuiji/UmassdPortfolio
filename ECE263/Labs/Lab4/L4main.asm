;Parallel Ports & LED Display
;Daniel Noyes, Andrew Haas, Benjamin Doiron
;Group 11, Lab 4, March 6th, 2013

;***************************************************************************
;Revision Notes;
;
; Revised Lab 3 and created Lab 4 routines [Dan:March-1-2013]
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

DDRA:	  	EQU		$0002				; enable port A [bit specific: 1 = output, 0 = input]
DDRB:	  	EQU		$0003				; enable port B [bit specific: 1 = output, 0 = input]
DDRM:		EQU		$0252				; enable port M
DDRP:		EQU		$025A				; enable port P

CRG_FLG:	EQU		$0037				; to clear the interupt by writing 1 to RTIF (%10000000)
CRG_INT:	EQU		$0038				; enable the interrupt
RTI_CTL:	EQU		$003B				; RTI clock rate ($40 ~ 1.024 ms)

TSK_1:		EQU 	%00000001			; Output LCD Display
TSK_2:		EQU 	%00000010			; Set the output for task 3
TSK_3:		EQU 	%00000100			; increment the time value (1s)
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
			LDAA	#$5A
			STAA	NUM_2_DISPLAY
			LDAA	#$6F
			STAA	(NUM_2_DISPLAY+1)
			CLR		LEDNUM

			LDAA	#T3COUNT			; set a 100 in decimal...
			STAA	CNT2				; to set count 2 [task-2-subroutine]

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
       
SKIP_3:		BRA		Main				; main loop to the beginning and check the flags again

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

DSET2:		LDAA	(NUM_2_DISPLAY+1)	;load the 2nd byte of the display
			LSRA						;then move it right -> 4 bits
			LSRA						; to get they digit we want
			LSRA
			LSRA
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

TASK_2		PSHA						; pushes the task flag onto the stack to save it

		    LDAA	CNT2				; grabs the memory value count 2
		    CMPA	#$0					; compare the memory with 0
		    BEQ		T2.1				;
		    DECA						; will decrement until it reaches 0
		    STAA	CNT2				;
		    BRA		T2.2				;

T2.1		LDAA	#100				; resets the value back to 100 and flag task 3
			STAA	CNT2				;
			SEI							;
			PULA						; grab task from the stack
			ANDA	#(TSK_2 ^ $FF)		; clear task 2 
			EORA	#TSK_3				; set task 3
			STAA	T_FLG				; Store Task flag
			BRA		T2.3				;
			
			
			

T2.2		PULA						; returns the task flag from the stack to A
			SEI							;
			ANDA	#(TSK_2 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;

T2.3		CLI							;
			RTS							; RETURN from stack
        
;***************************************************************************
;Task 3
;	Will add one to the count
;

TASK_3		PSHA						; pushes the task flag onto the stack to save it

			LDD		NUM_2_DISPLAY		; Load Num2 variable and inc the first and dec the last byte
			INCB						;
										;CMPB	#100
										;BLT	T3.1
										;CLRB
			DECA						;
										;CMPA	#100
										;BLT	T3.1
										;CLRA
T3.1		STD		NUM_2_DISPLAY		; store the number back

			SEI							;
			PULA						; returns the task flag from the stack to A
			ANDA	#(TSK_3 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							;
			RTS							; RETURN from stack

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

RTI_B		INCB						; adds to count B and check to see if it is a 9
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
