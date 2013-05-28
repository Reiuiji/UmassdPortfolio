;Real Time Interrupt RTI
;Daniel Noyes, Andrew Haas, Benjamin Doiron
;Group 11, Lab 3, Febuary 13th, 2013

;***************************************************************************
;Revision Notes;
;
;Created by Dan [2-20-13]
;revised and commented by Dan [2-22-13], [3-1-13]
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
PTB:		EQU		$0001				; Port B
DDRA:	  	EQU		$0002				; enable port A [bit specific: 1 = output, 0 = input]
DDRB:	  	EQU		$0003				; enable port B [bit specific: 1 = output, 0 = input]

CRG_FLG:	EQU		$0037				; to clear the interupt by writing 1 to RTIF (%10000000)
CRG_INT:	EQU		$0038				; enable the interrupt
RTI_CTL:	EQU		$003B				; RTI clock rate ($40 ~ 1.024 ms)

rti_diag:	EQU		%00000001			;
t1_diag:	EQU		%00000010			; Port A & B diagnostic bits
t2_diag:	EQU		%00000100			;
t3_diag:	EQU		%00001000			;
M_DIAG:		EQU		%00010000			;

;Task flags
TSK_1:		EQU 	%00000001			;
TSK_2:		EQU 	%00000010			; Task flags
TSK_3:		EQU 	%00000100			;


;***************************************************************************
;variable/data section

    ORG RAMStart

T_FLG:		DS.B  1   					; task flag storage
CNTA:		DS.B  1						; storage for RTI
CNTB:		DS.B  1						; storage for RTI
CNT2:		DS.B  1						; storage for task 2


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

			LDAA	#$FF				; loads a FF (11111111) to enable all ports
			STAA	DDRA				; enables port A
			STAA	DDRB				; enables port B
			CLR		T_FLG				; reset the task flag
			CLR		CNTA				; reset the count variable A [rti-subroutine]
			CLR		CNTB				; reset the count variable B [rti-subroutine]
			LDAA	#100				; set a 100 in decimal...
			STAA	CNT2				; to set count 2 [task-2-subroutine]
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
       
SKIP_3:		LDAA	PTA					;
			EORA	#M_DIAG 			; toggle the main diagonstic bit back and forth
			STAA	PTA					;		0 -> 1 -> 0 -> 1 -> 0 -> 1
			BRA		Main				; main loop to the beginning and check the flags again

;***************************************************************************
;Task 1
;
;	for the operation of task one we want it to simulate process time
;	so it goes through a loop then returns
;

TASK_1:		PSHA						; pushes the task flag onto the stack to save it
			SEI							; prevent rti from happening while seting the bits
			LDAB	PTA             	; 
			EORB	#t1_diag			; toggle task one bit on port A
			STAB	PTA					;
			LDAB	PTB					;
			ORAB	#t1_diag			; set task one bit on port B             
			STAB	PTB					;
			CLI							; allow rti

			LDAA	#$10				; simulate process time operation
T1.0:		CMPA	#$0					; loop $10 times
			BEQ		T1.1				; 
			DECA						; cycles:(1+1+1+3)*$10[16]+2=98
			BRA		T1.0				;

T1.1:		SEI							; prevent rti
			LDAB	PTB					;
			ANDB	#(t1_diag ^ $FF)	; clear task one bit on port B
			STAB	PTB					;

			PULA						; returns the task flag from the stack to A
			ANDA	#(TSK_1 ^ $FF)		; Clears the task flag, prevent main from running this task again right after
			STAA	T_FLG				;
			CLI							; allow rti

			RTS							; RETURN from stack

;***************************************************************************
;Task 2
;	for this operation we grab a variable from the memory. This variable was
;	set to a 100 during initilization. Everytime task 2 starts, it checks to
;	see if the value in the memory is 0. 
;	true  = reset the value bask to 100 and flag task 3. 
;	false = decrease the memory and ends the routine
;

TASK_2		PSHA						; pushes the task flag onto the stack to save it
			SEI
			LDAB	PTA					;
			EORB	#t2_diag			; toggle task two bit on port A
			STAB	PTA					;
			LDAB	PTB					;
			ORAB	#t2_diag			; set task two bit on port B 
			STAB	PTB					;
			CLI

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

T2.3		LDAB	PTB					;
			ANDB	#(t2_diag ^ $FF)	; clear task two bit on port B
			STAB	PTB					;
			CLI							;
			RTS							; RETURN from stack
        
;***************************************************************************
;Task 3
;	routine task just like task 1
;

TASK_3		PSHA						; pushes the task flag onto the stack to save it
			SEI							;
			LDAB	PTA					;
			EORB	#t3_diag			; toggle task three bit on port A
			STAB	PTA					;
			LDAB	PTB					;
			ORAB	#t3_diag			; set task three bit on port B 
			STAB	PTB					;
			CLI							;

			LDAA	#$10				; simulate process time operation
T3.0		CMPA	#$0					; loop $10 times
			BEQ		T3.1				;
			DECA						; cycles:(1+1+1+3)*$10[16]+2=98
			BRA		T3.0				;

T3.1		SEI							;
			LDAB	PTB					;
			ANDB	#(t3_diag ^ $FF)	; clear task three bit on port B
			STAB	PTB					;

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

RTI_ISR:	LDAB	PTB					;
			ORAB	#rti_diag			; set task one bit on port B             
			STAB	PTB					;
			LDAB	PTA             	; 
			EORB	#rti_diag			; toggle task one bit on port A
			STAB	PTA					;

			LDAA	CNTA				; 
			LDAB	CNTB				; loads CNTA & CNTB and proceed with the loop checks

			INCA						; add to count A and check to see if it is a 4
			CMPA	#4					; true  = flag task 1, reset count A
			BNE		RTI_A1				; false = skips and goes to count B
			LDAA	#0					;
			STAA	CNTA				;
			LDAA	#TSK_1				;
			STAA	T_FLG				;
			BRA		RTI_B				;
RTI_A1:		STAA	CNTA				;

RTI_B		INCB						; adds to count B and check to see if it is a 9
			CMPB	#9					; true  = flag task 2, reset count B
			BNE		RTI_B1				; false = skip and return from the interupt
			LDAB	#0					;
			STAB	CNTB				;
        	LDAA	#TSK_2				;
			STAA	T_FLG				;
			BRA		RTI_END				;

RTI_B1:		STAB	CNTB				;
RTI_END:	LDAB	PTB					;
			ANDB	#(rti_diag ^ $FF)	; clear task one bit on port B
			STAB	PTB					;

			LDAA	#%10000000			;
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
