----------------------------------------------------------------
-- Company: 	UMD ECE
-- Engineer: 	Fortier
-- 
-- Create Date:    2/7/2013 
-- Design Name: 
-- Module Name:    CLK_divide- Behavioral 
-- Project Name: VGA
-- Target Devices: Spartan 3E
-- Tool versions: Xilinx ISE 10.1
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
-----------------------------------------------------------------------------ClK_divide---------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity clk_div is
    Port ( clk_in : in  STD_LOGIC;
           clk : out  STD_LOGIC);
end clk_div;

architecture Behavioral of clk_div is
signal clkdiv	: std_logic:='0';--Clock divider
begin
	--This cuts the 50Mhz clock in half
	process(clk_in)
	begin
		if(clk_in = '0' and clk_in'EVENT) then
			clkdiv <= not clkdiv;
		end if;
	end process;
clk<=clkdiv;
end Behavioral;
