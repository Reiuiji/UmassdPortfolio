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
--      Arithmetic Logic Unit - Arithmetic Unit.
--
-- Notes:
--      Performs all arithmetic operations
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
USE work.UMDRISC_pkg.ALL;

entity arithmetic_unit is

	Port (
		A	: in 	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Input 1
		B	: in 	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Input 2
		SEL : in  STD_LOGIC_VECTOR (2 downto 0);	-- Select ALU Operation
		CCR : out STD_LOGIC_VECTOR (3 downto 0);	-- Condition Codes (N,Z,V,C)
		F 	: out  STD_LOGIC_VECTOR  (DATA_WIDTH-1 downto 0)	-- Output
	);

end arithmetic_unit;

architecture Combinational of arithmetic_unit is

	signal A2, B2 : STD_LOGIC_VECTOR (24 downto 0) := (OTHERS => '0'); -- Expanded 25 bit inputs
	signal arith  : STD_LOGIC_VECTOR (24 downto 0) := (OTHERS => '0'); 	-- Expanded 25 bit arithmetic register to hold result

begin

	-- Expand to 25 bit inputs to monitor carry and overflow
	A2 <= '0' & A;
	B2 <= '0' & B;

	----- Arithmetic Unit: -----

	-- Perform 3 arithmetic operations with expanded 25-bit inputs.
	--	Calculates in two's complement.
	with sel select
		arith <=	A2 + B2		when "000",		-- ADD 	REG A, REG B
			 		A2 - B2		when "001",		-- SUB 	REG A, REG B
			 		A2 + B2		when OTHERS;	-- ADDI 	REG A, IMMED
	----- End Arithmetic Unit -----

	----- Set Condition Code Register (N,Z,V,C): -----
	ccr(3) <= arith(DATA_WIDTH-1); 												-- N - Negative
	ccr(2) <= '1' when arith(DATA_WIDTH-1 downto 0)=x"0000" else '0';	-- Z - Zero
	ccr(1) <= arith(24) xor arith(DATA_WIDTH-1);								-- V - Overflow
	ccr(0) <= arith(24); 												-- C - Carry/Borrow
	----- End Set Condition Code Register -----

	-- Trim to 24-bits to output arithmetic result
	F <= arith(DATA_WIDTH-1 downto 0);

end Combinational;

