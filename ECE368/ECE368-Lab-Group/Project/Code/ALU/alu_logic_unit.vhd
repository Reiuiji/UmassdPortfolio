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
--      Arithmetic Logic Unit - Logic Unit.
--
-- Notes:
--      Performs all logic operations.
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

entity logic_unit is

	Port (
		A	: in	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Input 1
		B	: in	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);	-- Input 2
		SEL : in	STD_LOGIC_VECTOR (2 downto 0);	-- Select Logic Operation
		CCR : out	STD_LOGIC_VECTOR (3 downto 0);	-- Condition Codes (N,Z,V,C)
		F 	: out	STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)	-- Output
	);

end logic_unit;

architecture Combinational of logic_unit is

	signal ccr_cmp: STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0'); -- CCR Compare

begin

	----- Logic Unit: -----
	with sel select
		F <=	A and B		when "010",		-- AND 	REG A, REG B
				A or B		when "011",		-- OR 	REG A, REG B
				x"000000"	when "100",		-- CMP 	REG A, REG B
				A and B		when OTHERS;	-- ANDI 	REG A, IMMED
	----- End Logic Unit -----

	-- Set CCR for CMP operation
	ccr_cmp(3) <= '1' when a<b else '0';	-- N when s<r
	ccr_cmp(2) <= '1' when a=b else '0';	-- Z when s=r

	-- Choose CCR output
	with sel select
		ccr <= ccr_cmp when "100",	-- CCR for CMP
			"0000" when OTHERS;	-- All flags cleared for other logic operations

end Combinational;
