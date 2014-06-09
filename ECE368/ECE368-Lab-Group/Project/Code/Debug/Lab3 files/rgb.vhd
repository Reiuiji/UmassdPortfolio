----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	RGB - simple
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


entity rgb is
    Port ( rgb : in  STD_LOGIC_VECTOR (2 downto 0);
           mux_in : in  STD_LOGIC;
			  vidon : in std_logic;
           R1 : out  STD_LOGIC;
           G1 : out  STD_LOGIC;
           B1 : out  STD_LOGIC);
end rgb;

architecture Behavioral of rgb is
signal enb : std_logic;
begin

R1<='1' when vidon='0' else mux_in;
G1<='1' when vidon='0' else mux_in;
B1<='0' when vidon='0' else mux_in;
end Behavioral;

