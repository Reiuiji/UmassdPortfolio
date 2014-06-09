----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
--
-- Create Date:    Spring 2014
-- Module Name:    Mem32Byte Test Bench
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Ps2 Top Level Design
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PS2_TopLevel_design is
	PORT (
	--CLOCK/RESET 
	CLOCK 	: in 	STD_LOGIC;
	RESET 	: in 	STD_LOGIC;
	
	--PS/2 INTERFACE
	PS2_DATA : in STD_LOGIC;
	PS2_CLOCK: in STD_LOGIC;
	
	--LED DISPLAY
	LED : out STD_LOGIC_VECTOR(7 downto 0);
	
	--LCD DISPLAY
	SF_D : out STD_LOGIC_VECTOR(3 downto 0); 
	LCD_E, LCD_RS, LCD_RW, SF_CE0 : out STD_LOGIC
	);
end PS2_TopLevel_design;

architecture Sturctural of PS2_TopLevel_design is
--ALU
	-- ALU Outputs
Signal CCR : STD_LOGIC_VECTOR (3 downto 0);	-- Condition Codes (N,Z,V,C)
Signal ALU_OUT	: STD_LOGIC_VECTOR (23 downto 0);	-- Output from ALU

	-- ALU Input
signal RA	: STD_LOGIC_VECTOR (23 downto 0) ;--:= (OTHERS => x"123456"); -- Arithmetic Unit Output
signal RB	: STD_LOGIC_VECTOR (23 downto 0) ; -- Logic Unit Output
signal OPCODE_SIG	: STD_LOGIC_VECTOR (3 downto 0); -- Operation Code
signal POSITION	: STD_LOGIC_VECTOR (3 downto 0); -- position location to change bit
	
	--PS2 output
signal KeyCode : STD_LOGIC_VECTOR (7 downto 0);
signal ASCII : STD_LOGIC_VECTOR (7 downto 0);
signal Valid : STD_LOGIC;
signal COMPLETE : STD_LOGIC;

--Memory Interface signals
signal ADDRESS_IN : STD_LOGIC_VECTOR(4 downto 0);
signal DATA_IN : STD_LOGIC_VECTOR(7 downto 0);
signal ADDRESS_OUT : STD_LOGIC_VECTOR(4 downto 0); 
signal DATA_OUT : STD_LOGIC_VECTOR(7 downto 0);
--signal READ_ENABLE : in STD_LOGIC;
signal WRITE_ENABLE : STD_LOGIC;

begin

	LED <= DATA_OUT;

	----- Structural Components: -----
	-- PS2 UNIT
	PS2_Unit : entity work.PS2controller
	port map (
		RESET     => RESET,
		PS2_DATA  => PS2_DATA,
		PS2_CLOCK => PS2_CLOCK,
		KeyCode   => KeyCode,
		Valid     => Valid
	);
	
	-- KeyCode to Ascii Converter UNIT
	KeytoAscii_Unit : entity work.KeytoAscii
	port map (
		kk => KEYCODE,
		asc   => DATA_OUT, --ASCII,
		Complete => complete,
		VALID   => VALID
	);
	
	inputALU_unit : entity work.input_check
	port map(  
				
				ascii =>DATA_OUT,
			    RA => RA,
			    RB => RB,
			    complete => complete,
				 OPCODE => OPCODE_SIG,
				 POSITION => POSITION
				 
			  );

		
	alu_unit : entity work.alu_toplevel
	port map(CLK 			=> CLOCK,
				RA 			=> RA,					-- ALU Input
				RB 			=> RB,					-- ALU Input
				OPCODE 		=> OPCODE_SIG,				-- Only need least significant 3 bits
				CCR			=> CCR,					-- CCR
				ALU_OUT		=> ALU_OUT				-- ALU_OUT
				);

	
	-- LCD UNIT
	LCD_Display : entity work.LCD_Display
	port map(CLK			=> CLOCK,
				RESET			=> RESET,
				A				=> RA,
				B				=> RB,
				C				=> ALU_OUT,
				OPCODE		=> OPCODE_SIG,
				CCR			=> CCR,
				SF_D			=> SF_D,
				LCD_E			=> LCD_E,
				LCD_RS		=> LCD_RS,
				LCD_RW		=> LCD_RW,
				SF_CE0		=> SF_CE0,
				POSITION    => POSITION
				);
	
end Sturctural;

