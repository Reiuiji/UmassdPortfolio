----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	WE_delay - Behavioral
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

entity we_delay is
    Port ( we_in, clk : in  STD_LOGIC;
           we_out : out  STD_LOGIC);
end we_delay;

architecture Behavioral of we_delay is

begin
process(clk)
variable count: integer :=0;
BEGIN
if clk' event and clk='1' then
	count:=count+1;
	if count=5000 then
		we_out<=we_in;
		count:=0;
	end if;
end if;
end process;


end Behavioral;

