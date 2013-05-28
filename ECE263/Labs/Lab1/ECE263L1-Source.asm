;Lab#1 Group 11
;Daniel Noyes, Andrew Haas, Benjamin Doiron


; export symbols
            XDEF Entry, _Startup      ;export 'Entry' symbol
            ABSENTRY Entry            ;for absolute assembly: mark this as entry point

ROMStart  EQU $C000                   ;absoolute address to place code/constant data


; code section
            ORG   ROMStart
Entry:
_Startup:

; Program 1
            LDAA    #$55
OUTER:      LDX     #$1000
INNER:      STAA    1,X+
            CPX     #$1040
            BNE     INNER
            COMA
            BRA     OUTER
            NOP
            
; Program 2 
            CLRB
            LDX     #$1000
LOOP:       STX     2,X+
            INCB
            CPX     #$1100
            BNE     LOOP
HERE:       BRA     HERE


;Interrupt Vectors

            ORG     $FFFE
            DC.W    Entry     ;reset vector