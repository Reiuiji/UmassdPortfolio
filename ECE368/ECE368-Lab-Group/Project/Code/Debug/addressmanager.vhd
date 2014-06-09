----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    23:45:19 04/22/2014 
-- Design Name: 
-- Module Name:    addressmanager - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity addressmanager is
Port (
			clock: in std_logic;
			inputflag: in std_logic;
			outputaddr: out std_logic_vector(4 downto 0)
		);
end addressmanager;


architecture Behavioral of addressmanager is
signal outputadd: integer range 0 to 30;
begin
process(clock)
begin
	if(clock'event and clock='0') then
		if(inputflag = '1') then
			outputadd <= outputadd + 1;
		end if;
		outputaddr <= std_logic_vector(to_unsigned(outputadd, 5));
	end if;
end process;
end Behavioral;

