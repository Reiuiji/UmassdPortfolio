;Parallel Ports & LED Display
;Daniel Noyes, Andrew Haas, Benjamin Doiron
;Group 11, Lab 6, March 13th, 2013

;***************************************************************************
;Revision Notes;
;
; [none]
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

PTP:		EQU		$0000				; Port A

DDRP:	  	EQU		$0002				; enable port A [bit specific: 1 = output, 0 = input]


CRG_FLG:	EQU		$0037				; to clear the interupt by writing 1 to RTIF (%10000000)
CRG_INT:	EQU		$0038				; enable the interrupt
RTI_CTL:	EQU		$003B				; RTI clock rate ($40 ~ 1.024 ms)

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

T_FLG		DS.B	1

WAVE_TABLE:	DC.W	LED0		;based on the ticks
			DC.W	LED1		;ticks*250ns
			DC.W	LED2
			DC.W	LED3
			DC.W	LED4
			DC.W	LED5
			DC.W	LED6
			DC.W	LED7

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

			LDAA	#$FF
			STAA	DDRB
			STAA	DDRP
			CLI							; clear the i bit

;***************************************************************************
; Inilitilizing the ECT

			LDAA	#$80				;enable timer
			ORAA	TSCR1
			STAA	TSCR1

			LDAA	TSCR2				;set time prescscale
			ANDA	#%11111011			;011 = Div by 8
			STAA	TSCR2

			LDAA	TIOS
			ORAA	#%00000010			;set channel 1 as output Compare
			ANDA	#%11111010			;set channel 0,2 as a input capture
			STAA	TIOS

			LDAA	#%00000100			;set PA for ch 1 for high input(01 rising edge)
			STAA	TCTL4

			LDAA	#%00000010			;set PA for ch 0 as a low output (10 clear)
			STAA	TCTL2

			LDAA	#%00110000			;set PA for ch 2 as a high output (11 set)
			STAA	TCTL2

			LDAA	#%00000010			;clear ch 1 status
			STAA	TFLG1


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

			SEI
			PULA						; returns the task flag from the stack to A
			ANDA	#(TSK_1 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							; allow rti

			RTS							; RETURN from stack



;***************************************************************************
;Task 2

;

TASK_2		PSHA

			SEI
			PULA						;
			ANDA	#(TSK_2 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;

			CLI							;
			RTS							; RETURN from stack
        


;***************************************************************************
;RTI
;

RTI_ISR:	NOP
			RTI       					; RETURN from interupt

;***************************************************************************
; ECT RTI
;

CH0_ISR:	NOP
			RTI

CH1_ISR:	NOP
			RTI

CH2_ISR:	NOP
			RTI

CH3_ISR:	NOP
			RTI

CH4_ISR:	NOP
			RTI

CH5_ISR:	NOP
			RTI

CH6_ISR:	NOP
			RTI

CH7_ISR:	NOP
			RTI



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
                           
			ORG     $FFE0				;
			DC.W	CH7_ISR				; Time channel 7
			DC.W	CH6_ISR				; Time channel 6
			DC.W	CH5_ISR				; Time channel 5
			DC.W	CH4_ISR				; Time channel 4
			DC.W	CH3_ISR				; Time channel 3
			DC.W	CH2_ISR				; Time channel 2
			DC.W	CH1_ISR				; Time channel 1
			DC.W	CH0_ISR				; Time channel 0
									;FFF0
			DC.W	RTI_ISR				; Real Time Interrupt    
			DC.W	DFLT_ISR			; IRQ pin
			DC.W	DFLT_ISR			; XIRQ pin
			DC.W	DFLT_ISR			; SWI                   
			DC.W	DFLT_ISR			; non_inst             
			DC.W	DFLT_ISR			; cop fail             
			DC.W	DFLT_ISR			; clk fail     
			DC.W    Entry				; reset vector
