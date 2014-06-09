----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	KeyBoard_Controller - Behavioral
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

entity keyboard2 is
    Port ( 
				ps_clk 	: in  STD_LOGIC;	-- Keyboard Clock
				input 	: in  STD_LOGIC;	-- Serial Input from Keyboard
				we 		: out STD_LOGIC;	-- Write Enable
				output2 	: out STD_LOGIC_VECTOR (7 downto 0)	-- Output of Keycode
			);
end keyboard2;

architecture Behavioral of keyboard2 is

signal counter : integer :=0;--counter for counting clock cycles
signal output, output1 : std_logic_vector(10 downto 0) := "00000000000";
--output is the internal 11 bit signal that reads in the data. Once data 
--is valid it latches to output1 which will go to output2 as long as not E0 or F0.

signal parity: std_logic;--for error correction(not used in code but 
								  --can be. It is the 10th bit of output

begin

process(ps_clk)
begin
if (ps_clk' event and ps_clk='0') then-- valid data on high to low transition of keyboard clock
	we<='0';
	if(counter=0 and input='0') then --begin taking in data starting with start bit
		output<="00000000000";
		output<= input & output(10 downto 1);--shift register
		counter<=counter+1;
	end if;
	
	if(counter < 10 and counter /= 0) then--get the last 10 bits
		output<= input & output(10 downto 1);--shift register
		counter<=counter+1;
	end if;
	
	
	
	if(counter = 10) then--parallel load shift reg (output) to register output1
		output1<=output;
	end if;
	
	if (output1(9 downto 2)="11110000" or output1(9 downto 2)="11100000") then--if no e0 or f0 output data
	else output2<= output1(9 downto 2);
		  if counter=10 then 
			we<='1';
		  end if;
	end if;
	
	if counter=10 then
		counter<=0;
	end if;
	
end if;	
end process;
end behavioral;