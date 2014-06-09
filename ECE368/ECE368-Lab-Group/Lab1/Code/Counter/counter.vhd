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
-- Description: Counter
-- 	Will increase the counter(output) ever time
--		the clock does a rising action
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port ( CLOCK : in  STD_LOGIC;
           DIRECTION : in  STD_LOGIC;
           RESET : in STD_LOGIC;
			  COUNT_OUT : out  STD_LOGIC_VECTOR (3 downto 0));
			   
end counter;

architecture Behavioral of counter is

	signal count_int : std_logic_vector(0 to 3) := "0000";
	begin
		process (CLOCK, RESET)
		begin
			if (RESET = '1') then 
					count_int <= "0000";
			elsif CLOCK = '1' and CLOCK'event then
				if DIRECTION = '1' then
					count_int <= count_int + 1;
				else
					count_int <= count_int - 1;
				end if;
			end if;
		end process;
	COUNT_OUT <= count_int;
end Behavioral;

