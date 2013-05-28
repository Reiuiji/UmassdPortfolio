; export symbols
            XDEF Entry, _Startup      ;export 'Entry' symbol
            ABSENTRY Entry            ;for absolute assembly: mark this as entry point

ROMStart  EQU $C000                   ;absoolute address to place code/constant data


; code section
            ORG   ROMStart
Entry:
_Startup:

;Problem #4

START:	LDX			#$1004
		LDAA		#$00
		STAA		X
		LDAA		#$55
		STAA		X
		LDAA		#$AA
		STAA		X
		LDAA		#$FF
		STAA		X
		BRA			START

;Problem#5

      LDX		#$2000
		  LDY			#$3000
LOOP:	LDAA		X
	  	EORA		1,Y+
	  	STAA		1,X+
	  	CPX			#$2080
	  	BNE			LOOP
	  	NOP

;Interrupt Vectors

            ORG     $FFFE
            DC.W    Entry     ;reset vector
