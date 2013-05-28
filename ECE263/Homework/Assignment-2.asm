; export symbols
            XDEF Entry, _Startup	;export 'Entry' symbol
            ABSENTRY Entry			;for absolute assembly: mark this as entry point

ROMStart  	EQU $C000				;absoolute address to place code/constant data
STRT_ADR	EQU	$1000
BYTE_SIZE	EQU	$1002
ERR_CNT		EQU	$1004
LAST_ADR  EQU $1006

;values
A_START		EQU	$01
B_START		EQU	$FF


; code section
            ORG		STRT_ADR
			DC.W	$2000			;START ADDRESS value
			DC.W	$0010			;BYTE_SIZE value
			DC.W	$0000			;Error initilize as 0
			DC.W  $0000     ;reset the last address value

			ORG		ROMStart

Entry:
_Startup:

;Sets up the data

			LDX		STRT_ADR
			LDD   STRT_ADR
			ADDD  BYTE_SIZE
			STD   LAST_ADR    ;sets the last address for the memory block
			
			LDAA	#A_START
			LDAB	#B_START
LOOP_1:		STAA	1,X+
			INCA
			STAB	1,X+
			DECB
			CPX		LAST_ADR
			BLT		LOOP_1

;checks the memory to the pattern

			LDX		STRT_ADR
			LDAA	#A_START
			LDAB	#B_START
			
LOOP_2:		CPD		2,X+
			BNE		ERROR
E1:		INCA
			DECB
			CPX		LAST_ADR
			BLT		LOOP_2
			BRA		STOP


;endless loop for stop
STOP:		BRA		STOP

;output a error
ERROR:		LDY		ERR_CNT
          INY
          STY   ERR_CNT
          BRA   E1

;Interrupt Vectors

            ORG     $FFFE
            DC.W    Entry     ;reset vector
