;Testing Bit Banging w/Logic Analyzer
;Daniel Noyes, Andrew Haas, Benjamin Doiron, Group 11, Lab 2, Febuary 6th, 2013


; export symbols
		XDEF Entry, _Startup	;export 'Entry' symbol
		ABSENTRY Entry			;for absolute assembly: mark this as entry point

;definitions
RAMStart	EQU $1000			;absoolute address of the start of RAM
ROMSTART	EQU	$C000			;absolute addres to place code/constant data
PTA		    EQU	$0000
PTB		    EQU	$0001
DDRA	  	EQU	$0002
DDRB	  	EQU	$0003
WS_H	  	EQU	%111
W_L		  	EQU	%001
WS_L	  	EQU	%000

;variable section

		ORG RAMStart




;code section

		ORG   ROMSTART

Entry:
_Startup:

;Program 1

    	LDAA	#$FF
    	STAA	DDRA

		LDX		#$0
LOOP:	LDAA	#$00
		STAA	PTA
		LDAA	#$55
		STAA	PTA
		LDAA	#$AA
		STAA	PTA
		LDAA	#$FF
		STAA	PTA
		INX		
		CPX		#$100
		BNE		LOOP
;FOREVER TRAPPED IN A BRANCH
HERE:	BRA   HERE

;Program 2

		LDAA	#$01
		LDAB	#$FF
	  	LDX		#$1000
LOOP1:	STAA	1,X+        ;Begin loop to intialize memory.
	  	INCA
  		STAB	1,X+
  		DECB
  		CPX	  #$1100
  		BNE		LOOP1
  		
  		;start outputing data
  		LDAA  #$FF
  		STAA	DDRA
  		STAA	DDRB
  		LDAB	#WS_H
  		STAB	PTB  		
  		LDX		#$1000				;set X as 1000
		
		
		LDAA	WS_H				;--|Set both W and S pins high
		STAA	PTB					;-/
LOOP2:	LDAA	,X
		STAA	PTA
		LDAA	W_L
		STAA	PTB
		LDAA	WS_L
		STAA	PTB
		LDAA	W_L
		STAA	PTB
		LDAA	WS_H
		STAA	PTB
		CPX		#$1100
		BNE		LOOP2

		BRA 	HERE

;Interrupt Vectors

            ORG     $FFFE
            DC.W    Entry     ;reset vector
