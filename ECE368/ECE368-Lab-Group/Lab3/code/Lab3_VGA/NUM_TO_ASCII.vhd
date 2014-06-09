----------------------------------------------------------------
-- Company: 	UMD ECE
-- Engineer: 	Fortier
-- 
-- Create Date:    2/7/2013 
-- Design Name: 
-- Module Name:    NUM to ASCII - Behavioral 
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
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity NUM_TO_ASCII is
    Port ( clk : IN STD_LOGIC;
			  SEL_WE: IN STD_LOGIC_VECTOR (1 downto 0);
			  NUMBER : in  STD_LOGIC_VECTOR (7 downto 0);
           ASCII : out  STD_LOGIC_VECTOR (6 downto 0));
end NUM_TO_ASCII;

architecture Behavioral of NUM_TO_ASCII is
SIGNAL OUTPUT1, OUTPUT0  : STD_LOGIC_VECTOR (6 downto 0):="0000000"; 
SIGNAL STATE: STD_LOGIC :='1';
begin
process(clk)
BEGIN 

IF CLK' EVENT AND CLK='0' THEN
IF SEL_WE="01" THEN--DUMP STATE
Case NUMBER(3 DOWNTO 0) is
   when x"A" => output0 <= "1000001"; --a
   when x"B" => output0 <= "1000010"; --b
	when x"C" => output0 <= "1000011"; --c
	when x"D" => output0 <= "1000100"; --d
	when x"E" => output0 <= "1000101"; --e
	when x"F" => output0 <= "1000110"; --f
	when x"0" => output0 <=	"0110000"; --0
	when x"1" => output0 <=	"0110001"; --1
	when x"2" => output0 <=	"0110010"; --2
	when x"3" => output0 <=	"0110011"; --3
	when x"4" => output0 <=	"0110100"; --4
	when x"5" => output0 <=	"0110101"; --5
	when x"6" => output0 <=	"0110110"; --6
	when x"7" => output0 <=	"0110111"; --7
	when x"8" => output0 <=	"0111000"; --8
	when x"9" => output0 <=	"0111001"; --9
	when others  => output0 <= "0111000" ;
END CASE;


CASE NUMBER(7 DOWNTO 4) IS
   when x"A" => output1 <= "1000001"; --a
	when x"B" => output1 <= "1000010"; --b
	when x"C" => output1 <= "1000011"; --c
	when x"D" => output1 <= "1000100"; --d
	when x"E" => output1 <= "1000101"; --e
	when x"F" => output1 <= "1000110"; --f
	when x"0" => output1 <= "0110000"; --0
	when x"1" => output1 <=	"0110001"; --1
	when x"2" => output1 <=	"0110010"; --2
	when x"3" => output1 <=	"0110011"; --3
	when x"4" => output1 <=	"0110100"; --4
	when x"5" => output1 <=	"0110101"; --5
	when x"6" => output1 <=	"0110110"; --6
	when x"7" => output1 <=	"0110111"; --7
	when x"8" => output1 <=	"0111000"; --8
	when x"9" => output1 <=	"0111001"; --9
	when others => output1 <= "0111001" ;
END CASE;
STATE<=NOT(STATE);
END IF;
END IF;
END PROCESS;

ASCII<=OUTPUT1 WHEN STATE='0'  ELSE
		 OUTPUT0 WHEN STATE='1' ;


end Behavioral;

