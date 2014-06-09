----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	MUX2TO1_DEBUGGER - behavioral
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MUX2TO1_DEBUGGER is
    Port ( WE,rWE : in  STD_LOGIC;
           SEL_WE : in  STD_LOGIC_VECTOR (1 downto 0);
           NUM_TO_ASCII, rDIN_A : in  STD_LOGIC_VECTOR (6 downto 0);
           CURS_ADDR, rCURS_ADDR : in  STD_LOGIC_VECTOR (11 downto 0);
           WE_OUT : out  STD_LOGIC;
           DIN_A : out  STD_LOGIC_VECTOR (6 downto 0);
           ADDR_A : out  STD_LOGIC_VECTOR (11 downto 0));
end MUX2TO1_DEBUGGER;

architecture Behavioral of MUX2TO1_DEBUGGER is
begin
WE_OUT<=WE WHEN SEL_WE="01" ELSE rWE;
DIN_A<=NUM_TO_ASCII WHEN SEL_WE="01" ELSE rDIN_A;
ADDR_A<=CURS_ADDR WHEN SEL_WE="01" ELSE rCURS_ADDR;

end Behavioral;


