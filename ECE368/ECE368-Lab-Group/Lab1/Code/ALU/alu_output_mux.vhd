----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- Create Date:    SPRING 2014
-- Module Name:    UMD_MUX_FPU
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: ALU Output Multiplexer.
-- 	Selects ALU output based on current instruction.
--
--		Sets condition code register output for each instruction.
--		Operations that do not set any condition codes clear all
--		flags for simplicity. You may want to change this to suit 
--		your specific design.
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity alu_output_mux is

	Port (	SEL 			: in STD_LOGIC_VECTOR	(3 downto 0); 	-- Mux Input
				ARITH 		: in STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Arith Input
				LOGIC 		: in STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Logic Input
				SHIFT 		: in STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Shift Input
				MEMORY		: in STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Memory Input
				CCR_ARITH 	: in STD_LOGIC_VECTOR	(3 downto 0);	-- CCR Arith Input
				CCR_LOGIC 	: in STD_LOGIC_VECTOR	(3 downto 0);	-- CCR Logic Input
				
				ALU_OUT				: out STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Mux Output
				CCR_OUT				: out STD_LOGIC_VECTOR	(3 downto 0)	-- CCR Mux Output
			);
end alu_output_mux;

architecture Combinational of alu_output_mux is
	
begin
	
	----- Select Outputs: -----
	with sel select
		ALU_OUT <= 	arith 	when "0000", 	-- ADD
						arith 	when "0001", 	-- SUB
						logic 	when "0010", 	-- AND
						logic 	when "0011", 	-- OR
						logic 	when "0100", 	-- CMP
						arith 	when "0101", 	-- ADDI
						logic 	when "0110", 	-- ANDI
						shift 	when "0111", 	-- SL
						shift 	when "1000", 	-- SR
						memory	when "1001", 	-- LW
						memory	when OTHERS; 	-- SW
	with sel select
		CCR_OUT <= 	ccr_arith when "0000", 	-- ADD
						ccr_arith when "0001", 	-- SUB
						ccr_logic when "0010", 	-- AND
						ccr_logic when "0011", 	-- OR
						ccr_logic when "0100", 	-- CMP
						ccr_arith when "0101", 	-- ADDI
						ccr_logic when "0110", 	-- ANDI
						"0000"	 when OTHERS; 	-- All flags cleared for other logic operations
														-- Modify for your machine as necessary
	----- End Select Outputs -----

end Combinational;

