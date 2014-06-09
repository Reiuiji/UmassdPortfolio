------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    UMD_ALU_FPU
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      ALU : Arithmetic Logic Unit Top Level.
--      Structural defines all ALU modules.
--
-- Notes:
--		Provides a sample solution for designing the UMD-RISC 24 machine's functional
--		processing unit (FPU). 
--		Does not include any hardware testing. Integrate into your own machine as
--		desired.
--		Separates the shift and arithmetic units into separate entities for simplicity
--		and testing purposes.
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Clean up Code Layout
--
-- Additional Comments: 
--      [None]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;
USE work.UMDRISC_pkg.ALL;

entity ALU is

	Port (
		CLOCK		: in	STD_LOGIC;						-- 50 MHz Oscillator
		RA		: in	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Input 1
		RB		: in	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Input 2
		OPCODE	: in	STD_LOGIC_VECTOR (3 downto 0);	-- Current opcode
		CCR		: out	STD_LOGIC_VECTOR (3 downto 0);	-- Condition Codes (N,Z,V,C)
		ALU_OUT	: out	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Output from ALU
		LDST_OUT: out	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)	-- Output from the Load/Store Routine
	);

end ALU;

architecture Structural of ALU is

	-- 24-bit Outputs
	signal arith	: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0'); -- Arithmetic Unit Output
	signal logic	: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0'); -- Logic Unit Output
	signal shift	: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0'); -- Shift Unit Output
	signal memory 	: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0'); -- Load Store Unit Output

	-- 4-bit Condition Codes
	signal ccr_arith	: STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0'); -- Arithmetic Unit CCR
	signal ccr_logic 	: STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0'); -- Logic Unit CCR	

begin

LDST_OUT <= memory;

	----- Structural Components: -----
	-- ALU Units
	arithmetic_unit: entity work.arithmetic_unit
	port map(
		a				=> ra,						-- ALU Input
		b				=> rb,						-- ALU Input
		sel			=> opcode(2 downto 0),		-- Only need least significant 3 bits
		ccr			=> ccr_arith,				-- Route to ALU Output Multiplexer
		f				=> arith					-- Route to ALU Output Multiplexer
	 );
	logic_unit: entity work.logic_unit
	port map(
		a 				=> ra,						-- ALU Input
		b 				=> rb,						-- ALU Input
		sel 			=> opcode(2 downto 0),		-- Only need least significant 3 bits
		ccr 			=> ccr_logic,				-- Route to ALU Output Multiplexer
		f 				=> logic					-- Route to ALU Output Multiplexer
	 );
	shift_unit: entity work.alu_shift_unit
	port map(
		a 				=> ra,					-- ALU Input
		count 		=> rb(4 downto 0),		-- ALU Input
		sel 			=> opcode(3), 			-- Only 2 shift ops (opcode="0111", "1000")
		f 				=> shift				-- Route to ALU Output Multiplexer
	 );
	load_store_unit: entity work.load_store_unit
	port map(
		CLOCK			=> CLOCK,					-- ALU Input
		ra				=> ra,					-- ALU Input
		immed			=> rb,					-- ALU Input
		opcode 		=> opcode,				-- Need entire opcode to isolate SW instruction
		MEMOUT 		=> memory				-- Route to ALU Output Multiplexer
	 );
	-- Multiplexers
	alu_output_mux: entity work.alu_output_mux
	port map(
		sel 			=> opcode,			-- ALU Input
		arith 		=> arith,			-- From arithmetic_unit
		logic 		=> logic,			-- From logic_unit
		shift 		=> shift,			-- From shift_unit
		memory		=> memory,			-- From load_store_unit
		ccr_arith 	=> ccr_arith,		-- From arithmetic_unit
		ccr_logic 	=> ccr_logic,		-- From logic_unit
		alu_out 		=> alu_out,			-- ALU Output 
		ccr_out 		=> ccr				-- ALU Output 
	);
----- End Structural Components -----

end Structural;

