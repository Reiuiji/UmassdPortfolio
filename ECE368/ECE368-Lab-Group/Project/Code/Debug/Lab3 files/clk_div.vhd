----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	CLK_divide - behavioral
-- Project Name: 		VGA
-- Target Devices: 	Spartan 3E
-- Tool versions: 	Xilinx ISE 14.7
-- Description: 
--
-- Dependencies: 
--
-- Revision: 0.02
-- Revision 0.01: 	File Created
-- Revision 0.02: 	First modification for Lab #3
-- Comments: 			Initial design and code by Professor Fortier
--							Created on 2/7/2013
----------------------------------------------------------------

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
