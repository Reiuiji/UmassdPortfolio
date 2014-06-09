----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- 
-- Create Date:    SPRING 2014
-- Module Name:    UMD_SHIFT_FPU
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Arithmetic Logic Unit - Shift Unit.
-- 	Performs all shift operations.
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_shift_unit is

	Port (  A		: in 	STD_LOGIC_VECTOR (23 downto 0);	-- Register A Input
			  COUNT	: in 	STD_LOGIC_VECTOR (4 downto 0);	-- Number of Shifts
           SEL 	: in  STD_LOGIC;								-- Select Shift Operation
           F 		: out STD_LOGIC_VECTOR  (23 downto 0)	-- Shift Output
			  );
			  
end alu_shift_unit;

architecture Combinational of alu_shift_unit is
	signal shift_left, shift_right : std_logic_vector (23 downto 0) := (OTHERS => '0'); -- Shift operations
begin

	----- Shift Unit: -----
	shift_left <= to_stdlogicvector(to_bitvector(a) sll conv_integer(count));
	shift_right <= to_stdlogicvector(to_bitvector(a) srl conv_integer(count));
	----- End Shift Unit -----
	
	F <= shift_left when sel='0' else shift_right;
	
end Combinational;

