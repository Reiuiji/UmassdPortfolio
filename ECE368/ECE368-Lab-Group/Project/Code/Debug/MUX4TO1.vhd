----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron
-- 
-- Create Date:   	4/19/2014 
-- Design Name: 
-- Module Name:   	4 to 1 MUX - combinational
-- Project Name: 		VGA
-- Target Devices: 	Spartan 3E
-- Tool versions: 	Xilinx ISE 14.7
-- Description: 
--
-- Dependencies: 
--
-- Revision: 0.02
-- Revision 0.01: 	File Created
-- Revision 0.02: 	First modification from Lab #3
-- Comments: 			Initial design and code by Professor Fortier
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MUX4TO1 is
    Port ( IN0 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  IN1 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  IN2 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  IN3 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  SEL 	: in  STD_LOGIC_VECTOR  (1 downto 0);
           OUTPUT : out STD_LOGIC_VECTOR (23 downto 0));
end MUX4TO1;

architecture Behavioral of MUX4TO1 is

begin

with SEL select
	OUTPUT <=	IN0 when "00",
					IN1 when "01",
					IN2 when "10",
					IN3 when others;

end Behavioral;