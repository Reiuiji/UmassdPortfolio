----------------------------------------------------------------
-- Company: 	UMD ECE
-- Engineer: 	Fortier
-- 
-- Create Date:    2/7/2013 
-- Design Name: 
-- Module Name:    MUX 8 to 1 - combinational 
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
-------------------------------------------------------------------------------------------MUX8to1-----------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MUX8to1 is
    Port ( sel : in  STD_LOGIC_VECTOR (2 downto 0);
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC);
end MUX8to1;

architecture Behavioral of MUX8to1 is
signal sel1 : STD_LOGIC_VECTOR (2 downto 0);
begin


sel1<=sel-2;

with sel1 select
	output<=	data(7) when "000" ,
				data(6) when "001" ,
				data(5) when "010" ,
				data(4) when "011" ,
				data(3) when "100" ,
				data(2) when "101" ,
				data(1) when "110" ,
				data(0) when "111" ,
				'0' when others;
end Behavioral;
