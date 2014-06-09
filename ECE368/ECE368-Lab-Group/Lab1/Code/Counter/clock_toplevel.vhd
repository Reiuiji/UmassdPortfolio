---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- 
-- Create Date:    SPRING 2014
-- Module Name:    UMD_ALU_FPU
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Clock toplevel
-- 	Top level diagram of the Clock
--
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity clock_toplevel is
    Port ( CLOCK : in  STD_LOGIC; 	-- 50 MHz Oscillator
           RESET : in  STD_LOGIC;
           DIRECTION : in  STD_LOGIC;
           COUNT_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
end clock_toplevel;

architecture Structural of clock_toplevel is
	-- CLOCK
	signal CLOCK_DIVIDER	: STD_LOGIC  := '0'; -- Clock2Hz Output
	--signal COUNT	: STD_LOGIC_VECTOR (3 downto 0) := (OTHERS => '0'); -- Counter Output
begin

	----- Structural Components: -----
	clk2Hz: entity work.clk2Hz
	port map(clk_in	=> CLOCK,			   			-- clk2Hz input
				reset		=> RESET,							-- clk2Hz input
				clk_out 	=> CLOCK_DIVIDER	      			-- clk2Hz output
				);
				
	counter: entity work.counter
	port map(CLOCK 		=> CLOCK_DIVIDER,				-- From the clk2, counter input
				DIRECTION 	=> DIRECTION,					-- counter input
				RESET 		=>	RESET,
				COUNT_OUT 	=> COUNT_OUT 		 			-- Route the output of clock 
				);
	
	----- End Structural Components -----
	
	
end Structural;






