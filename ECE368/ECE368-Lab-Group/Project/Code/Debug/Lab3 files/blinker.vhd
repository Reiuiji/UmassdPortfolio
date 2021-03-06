----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	
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


entity blinker is
    Port ( addr_b : in  STD_LOGIC_VECTOR (11 downto 0);
           cursor_adr : in  STD_LOGIC_VECTOR (11 downto 0);
			  clk : in STD_LOGIC;
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           font_rom : in  STD_LOGIC_VECTOR (7 downto 0));
end blinker;

architecture Behavioral of blinker is
signal sel : std_logic;
signal out1 : std_logic_vector(7 downto 0):="11111111";
begin

process(clk)
variable count : integer;
begin
if clk' event and clk='1' then
	count:=count+1;
	if count=12500000 then 
		out1<="00000000";
	elsif count=25000000 then
		out1<="11111111";
		count:=0;
	end if;
end if;
end process;

sel<='1' when addr_b=cursor_adr else '0';

with sel select
	output<=out1 when '1',
	font_rom when others; 



end Behavioral;

