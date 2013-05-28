; export symbols
		XDEF Entry, _Startup	;export 'Entry' symbol
		ABSENTRY Entry			;for absolute assembly: mark this as entry point

;definitions
RAMStart	EQU $1000			;absoolute address of the start of RAM
ROMSTART	EQU	$C000			;absolute addres to place code/constant data
PTA		    EQU	$0000
PTB		    EQU	$0001
PTP       EQU $258 
DDRA	  	EQU	$0002
DDRB	  	EQU	$0003
DDRP      EQU $25A
OUTMASK   EQU $FF
;led layout
LED0      EQU %00111111
LED1      EQU $06
LED2      EQU $5B
LED3      EQU $4F
LED4      EQU $66
LED5      EQU %01101101
LED6      EQU %01111101
LED7      EQU %00000111
LED8      EQU %01111111
LED9      EQU %01101111
;port P layout
P0        EQU %1110
P1        EQU %1101
P2        EQU %1011
P3        EQU %0111
PN        EQU %1111




;variable section

		ORG RAMStart




;code section

		ORG   ROMSTART


;FOREVER TRAPPED IN A BRANCH
HERE:	BRA   HERE

Entry:
_Startup:




;led test
  		LDAA  #OUTMASK
  		STAA  DDRB
  		STAA  DDRP
  		
LD: 	
  		LDAB  #PN
  		STAB  PTP
  		
          LDAA  #LED0
  		    LDAB  #P0
  		    STAA  PTB
  		    STAB  PTP
  		
  		LDAB  #P1
  		STAB  PTP  		
  		LDAA  #LED1
  		STAA  PTB
  		
  		LDAB  #P2
  		STAB  PTP  		
  		LDAA  #LED2
  		STAA  PTB
  		
  		LDAB  #P3
  		STAB  PTP  		
  		LDAA  #LED3
  		STAA  PTB
  		
  		LDAB  #P0
  		STAB  PTP
    	LDAA  #LED4
  		STAA  PTB
  		 
  		LDAB  #P1
  		STAB  PTP
  		LDAA  #LED5
  		STAA  PTB

  		LDAB  #P2
  		STAB  PTP  		
  		LDAA  #LED6
  		STAA  PTB
  		
  		LDAB  #P3
  		STAB  PTP
  		LDAA  #LED7
  		STAA  PTB

  		LDAB  #P1
  		STAB  PTP  		
    	LDAA  #LED8
  		STAA  PTB

  		LDAB  #P2
  		STAB  PTP  		
   		LDAA  #LED9
  		STAA  PTB
		  BRA   LD

;Interrupt Vectors

      ORG     $FFFE
      DC.W    Entry     ;reset vector

