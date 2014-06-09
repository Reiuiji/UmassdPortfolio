------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    Mem32Byte
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      [Description]
--
-- Notes:
--      [Insert Notes]
--
-- Revision: 
--      0.01  - File Created
--      0.02  - [Insert]
--
-- Additional Comments: 
--      [Insert Comments]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity MUX_DRIVER is
    Port ( sel : in  STD_LOGIC_VECTOR (2 downto 0);
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC);
end MUX_DRIVER;

architecture Behavioral of MUX_DRIVER is
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

