;Parallel Ports & LED Display
;Daniel Noyes, Andrew Haas, Benjamin Doiron
;Group 11, Lab 5, March 13th, 2013

;***************************************************************************
;Revision Notes;
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

PTT:		EQU		$0240

TIOS:		EQU		$0040
TSCR1:		EQU		$0046
TSCR2:		EQU		$004D
TCTL1:		EQU		$0048
TCTL2:		EQU		$0049
TCTL3:		EQU		$004A
TCTL4:		EQU		$004B

TIE:		EQU		$004C
TFLG1:		EQU		$004E

TC0:		EQU		$0050
TC1:		EQU		$0052
TC2:		EQU		$0054

TSK_1:		EQU 	$1
TSK_2:		EQU 	$2
TSK_3:		EQU		$3

;***************************************************************************
;variable/data section

    ORG RAMStart

T_FLG:		DS.B 	1

CH2_Set:	DS.B	1

Delta1:		DC.W	2000	; .5mS
Delta2:		DC.W	16000 	; 4ms
			
Delta_Def	DC.W	20000	; 5ms

WAVE_SELECT DS.B	1

WAVE_TABLE:	DC.W	8000 	; 2ms
			DC.W	2000	; .5ms
			DC.W	4000	; 1ms
			DC.W	40000	; 10ms
			DC.W	16000	; 4ms
			DC.W	2000	; .5 ms
			DC.W	12000	; 3ms
			DC.W	800		; .2ms F0 ~= .256ms



;***************************************************************************
; Code section

    ORG	ROMSTART

Entry:
_Startup:

;***************************************************************************
; Inilitilizing the program

			LDS		#RAM_END			; initialize the stack pointer.
			CLR		WAVE_SELECT

			CLR	T_FLG					; reset the task flag
			CLR CH2_Set					; reset channel 2 set flag
			CLI							; clear the i bit


;***************************************************************************
; Inilitilizing the ECT

			LDAA	#$80		;enable timer
			ORAA	TSCR1
			STAA	TSCR1

			LDAA	TSCR2		;set time prescscale
			ANDA	#%11111000	;000 = Div by 1
			STAA	TSCR2

			LDAA	TIOS
			ORAA	#%00000101	;set channel 0,2 as output Compare
			ANDA	#%11111101	;set channel 1 as a input capture
			STAA	TIOS

			LDAA	#%00000100	;set PA for ch 1 for high input(01 rising edge)
			STAA	TCTL4

			LDAA	#%00110011	;set PA for ch 2 as a high output (11 set) 
			STAA	TCTL2		;and set ch 0 as a high (11 set)

			LDD		TC0
			ADDD	Delta_Def;
			STD		TC0
			
			LDD		TC2
			ADDD	Delta_Def
			STD		TC2
			
			LDAA	#%00000111
			STAA	TIE

			LDAA	#%00000111	;clear ch 0,1 status
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
			JSR		TASK_2				; jumps to task 2 set up the delay for ch2

SKIP_2:		BITA	#TSK_3				;
			BEQ		SKIP_3				; skip to task 3
			JSR		TASK_3				; jumps to task 3

SKIP_3:		BRA		Main				; main loop to the beginning and check the flags again

;***************************************************************************
;Task 1
;

TASK_1:		PSHA
			LDAA	PTT
			ANDA	#%00000001
			CMPA	#0
			BEQ		T1.H

			LDAA	TCTL2
			ORAA	#%00000010	;set PA to low when hit(10)
			ANDA	#%11111110
			STAA	TCTL2
			BRA		T1.1

T1.H		LDAA	TCTL2
			ORAA 	#%00000011	;set PA to high when hit(11)
			STAA	TCTL2
			

T1.1		LDAA	WAVE_SELECT
			LDY		#WAVE_TABLE
			LDD		A,Y
			ADDD	TC0
			STD		TC0

			LDAA	WAVE_SELECT
			INCA
			INCA
			ANDA	#$F
			STAA	WAVE_SELECT

			LDAA	#%00000001			;clear ch 0 status
			STAA	TFLG1

			PULA
			SEI						; returns the task flag from the stack to A
			ANDA	#(TSK_1 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							; allow rti

			RTS							; RETURN from stack


;***************************************************************************
;Task 2
;

TASK_2		STAA	T_FLG
			LDAA	CH2_Set
			CMPA	#$1		;make sure not to set the function again
			BEQ		T2.END
			
			LDAA	#$1
			STAA	CH2_Set
			
			LDD		Delta1
			ADDD	TC1		;set the delay for the event
			STD		TC2
			
			LDAA	TCTL2
			ORAA	#%00100000	;set PA to low when hit(10)
			ANDA	#%11101111
			STAA	TCTL2
			
			
T2.END
			LDAA	#%00000010			;clear ch 1 status
			STAA	TFLG1
			SEI	
			LDAA	T_FLG						;
			ANDA	#(TSK_2 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							;
			RTS							; RETURN from stack

;***************************************************************************
;Task 3
;

TASK_3		STAA	T_FLG
			
			LDAA	PTT
			BITA	#%00000100
			CMPA	#0
			BNE		T3.1	;ch2 high so prepare for low

			LDD		Delta2
			ADDD	TC2		;set the delay for the event
			STD		TC2

			LDAA	TCTL2
			ORAA	#%00110000	;set PA to high when hit(11)
			STAA	TCTL2
			
T3.1		LDAA	CH2_Set
			INCA	
			CMPA	$2
			BEQ		T3.E
			CLR		CH2_Set
			
T3.E		STAA	CH2_Set
			LDAA	#%00000100			;clear ch 2 status
			STAA	TFLG1

			SEI	
			LDAA	T_FLG						;
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

RTI_ISR:	NOP
			RTI       					; RETURN from interupt

CHANNEL0_ISR:	LDAA	T_FLG
				EORA	#TSK_1				;
				STAA	T_FLG				;

				LDAA	#%00000001	;clear ch 0
				STAA	TFLG1

				RTI       					; RETURN from interupt

CHANNEL1_ISR:	LDAA	T_FLG
				EORA	#TSK_2				;
				STAA	T_FLG				;
				LDAA	#%00000010	;clear ch 1
				STAA	TFLG1

				RTI       					; RETURN from interupt

CHANNEL2_ISR:	LDAA	T_FLG
				EORA	#TSK_3				;
				STAA	T_FLG				;

				LDAA	#%00000100	;clear ch 2
				STAA	TFLG1

				RTI       					; RETURN from interupt

CHANNEL3_ISR:	NOP
				RTI

CHANNEL4_ISR:	NOP
				RTI

CHANNEL5_ISR:	NOP
				RTI

CHANNEL6_ISR:	NOP
				RTI

CHANNEL7_ISR:	NOP
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
			DC.W	CHANNEL7_ISR		; channel 7 isr
			DC.W	CHANNEL6_ISR		; channel 6 isr
			DC.W	CHANNEL5_ISR		; channel 5 isr
			DC.W	CHANNEL4_ISR		; channel 4 isr
			DC.W	CHANNEL3_ISR		; channel 3 isr
			DC.W	CHANNEL2_ISR		; channel 2 isr
			DC.W	CHANNEL1_ISR		; channel 1 isr
			DC.W	CHANNEL0_ISR		; channel 0 isr
			;FFF0
			DC.W	RTI_ISR				; rti    
			DC.W	DFLT_ISR			; irq pin
			DC.W	DFLT_ISR			; xirq pin
			DC.W	DFLT_ISR			; swi                   
			DC.W	DFLT_ISR			; non_inst             
			DC.W	DFLT_ISR			; cop fail             
			DC.W	DFLT_ISR			; clk fail     
			DC.W    Entry				; reset vector