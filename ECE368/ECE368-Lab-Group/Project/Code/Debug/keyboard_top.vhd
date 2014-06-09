--------------------------------------------------------------------------------
-- Company: 	  UMD ECE
-- Engineers:	  Benjamin Doiron
--
-- Create Date:   10:12:25 4/2/2014
-- Design Name:   Structure of Debugger
-- Module Name:   debugger_structural
-- Project Name:  Risc Machine Project 1
-- Target Device: Spartan 3E Board
-- Tool versions: Xilinx 14.7
-- Description:   This is the top level for the debugger
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments: N/A
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity keyboard_top is
	Port
	(
		ps_clk :  in STD_LOGIC;
		input  :  in STD_LOGIC;
		we_clk :  in STD_LOGIC;
		we		 : out STD_LOGIC;
		scancode : out STD_LOGIC_VECTOR (7 downto 0);
		output : out STD_LOGIC_VECTOR(6 downto 0)
	);
end keyboard_top;


architecture structural of keyboard_top is
-----------keyboard_controller--------------------------------------------

component keyboard2 is
    Port ( 	ps_clk : 	in  	STD_LOGIC;-- keyboard clock
           	input :	 	in  	STD_LOGIC;--serial input from keyboard
				we : 			out 	std_logic;
				output2 : 	out  	STD_LOGIC_VECTOR (7 downto 0));--output of keycode
end component;


--------------ascii-------------------------------------------------------
component scan_to_ascii is
    Port ( 	scancode 	: in   STD_LOGIC_VECTOR (7 downto 0);
				clk 			: in   STD_LOGIC;
				output 		: out  STD_LOGIC_VECTOR (6 downto 0));
end component;

signal wSCANCODE : STD_LOGIC_VECTOR (7 downto 0);

begin

SCANCODE <=wSCANCODE;
U1: keyboard2 		PORT MAP (PS_CLK=>PS_CLK, INPUT=>INPUT, OUTPUT2=>wSCANCODE, WE=>WE);
U2: SCAN_TO_ASCII PORT MAP (CLK=>we_CLK, SCANCODE=>wSCANCODE, OUTPUT=>OUTPUT);

end structural;
	