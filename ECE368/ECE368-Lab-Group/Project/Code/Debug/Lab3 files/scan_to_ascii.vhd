----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	SCAN to ASCII - combinational
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

entity scan_to_ascii is
    Port ( 
				scancode : in  STD_LOGIC_VECTOR (7 downto 0);	-- The input code
				clk 		: in 	STD_LOGIC;								-- The clock
				output 	: out STD_LOGIC_VECTOR (6 downto 0)		-- The output code
			);
end scan_to_ascii;

architecture Behavioral of scan_to_ascii is
signal ascii, current : STD_LOGIC_VECTOR(7 downto 0);
signal we : STD_LOGIC :='0';

begin
with scancode select
	output<=	"1000001" when x"1c",--a
				"1000010" when x"32",--b
				"1000011" when x"21",--c
				"1000100" when x"23",--d
				"1000101" when x"24",--e
				"1000110" when x"2b",--f
				"1000111" when x"34",--g
				"1001000" when x"33",--h
				"1001001" when x"43",--i
				"1001010" when x"3b",--j
				"1001011" when x"42",--k
				"1001100" when x"4b",--l
				"1001101" when x"3a",--m
				"1001110" when x"31",--n
				"1001111" when x"44",--o
				"1010000" when x"4d",--p
				"1010001" when x"15",--q
				"1010010" when x"2d",--r
				"1010011" when x"1b",--s
				"1010100" when x"2c",--t
				"1010101" when x"3c",--u
				"1010110" when x"2a",--v
				"1010111" when x"1d",--w
				"1011000" when x"22",--x
				"1011001" when x"35",--y
				"1011010" when x"1a",--z   
				"0110000" when x"45",--0
				"0110001" when x"16",--1
				"0110010" when x"1e",--2
				"0110011" when x"26",--3
				"0110100" when x"25",--4
				"0110101" when x"2e",--5
				"0110110" when x"36",--6
				"0110111" when x"3d",--7
				"0111000" when x"3e",--8
				"0111001" when x"46",--9
				"1111111" when x"66",--	backspace : Initially 1111111, changed to 0001000 due to lab
											-- changed back, brandyn didn't have errors.
				"1111111" when x"29",--space bar
				"0000000" when others;	 
end Behavioral;

