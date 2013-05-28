;Daniel Noyes: Assignment 3

; export symbols
            XDEF Entry, _Startup	;export 'Entry' symbol
            ABSENTRY Entry			;for absolute assembly: mark this as entry point

;Memory Locations
ROMStart  	EQU $C000				;absoolute address to place code/constant data
STRT_ADR	EQU	$8000
BYTE_SIZE	EQU	$8002
LAST_ADR    EQU $8004
TEMP       	EQU $8010
TEMP_2     	EQU $8012



;Set up the code variables section
            ORG		STRT_ADR
			DC.W	$4000			;START ADDRESS value
			DC.W	$0010			;BYTE_SIZE value
			DC.W    $0000           ;reset the last address value

;Set up the program code
			ORG		ROMStart

Entry:
_Startup:

;Phase 1
PHASE_1		LDD     STRT_ADR
			ADDD    BYTE_SIZE
			STD     LAST_ADR    ;sets the last address for the memory block
    		LDY     BYTE_SIZE   ;loads the size to y
            LDAA    Y
            LDX     STRT_ADR
    		LDAA    X
    		CLRB
			INX
            BRA     PHASE_2

;Phase 2: Bubble sort
PHASE_2     CMPA    X
            BLE     PHASE_2.1
            STAA    TEMP        ;swaps the bytes so to compare to the larges and 
            LDAA    X           ;put the smallest in its location
            LDAB    TEMP
            STAB    X
            CLRB
            
PHASE_2.1   INX                 ;increment x then checks to see if it is the
            CPX    LAST_ADR    ;last byte, if so then it will go to phase 4
            BEQ     PHASE_4     ;else it will return to the sort (phase 2)
            BRA     PHASE_2

PHASE_3     STAA    TEMP        ;will reset the current last address with the
            LDD     STRT_ADR    ;new size
            STY     TEMP_2
            ADDD    TEMP_2
            STD     LAST_ADR
            LDAA    TEMP
            CLRB
            LDX     STRT_ADR
            BRA     PHASE_2
            
PHASE_4     DEY                 ;decrement the size
            CPY    #$0
            BEQ     STOP
            BRA     PHASE_3			


;endless loop for stop
STOP:		BRA		STOP

;Interrupt Vectors

            ORG     $FFFE
            DC.W    Entry     ;reset vector
