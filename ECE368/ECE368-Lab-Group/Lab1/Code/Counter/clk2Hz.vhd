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
-- Description: Clock Divider
-- 	Lower the Clock frequency from
-- 	50 Mhz to 2 hz
-- 	50Mhz = 50,000,000/25,000,000 = 2 Hz 
--		2Hz/2 => 1 second 
---------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk2Hz is
    Port ( clk_in : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           clk_out : out  STD_LOGIC);
end clk2Hz;

architecture Behavioral of clk2Hz is
	signal temporal: STD_LOGIC:='0';
   signal counter : integer range 0 to 25000000 := 0;

begin
    frequency_divider: process (reset, clk_in) begin
        if (reset = '1') then
            temporal <= '0';
            counter <= 0;
        elsif rising_edge(clk_in) then
            if (counter = 25000000) then
					if(temporal='0') then
						temporal <= '1';
					 else
						temporal <= '0';
					end if;
                counter <= 0;
            else
                counter <= counter + 1;
            end if;
        end if;
    end process;
    
    clk_out <= temporal;
end Behavioral;

