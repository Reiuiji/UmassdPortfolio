----------------------------------------------------------------
-- Company: 	UMD ECE
-- Engineer: 	Fortier
-- 
-- Create Date:    2/7/2013 
-- Design Name: 
-- Module Name:    CURSOR_INCREMENTER - Behavioral 
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

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CURSOR_INCREMENTER is
    Port ( CURS_ADDR : in  STD_LOGIC_VECTOR (11 downto 0);
           SEL_WE : in  STD_LOGIC_VECTOR (1 downto 0);
           CLK : in  STD_LOGIC;
           ADDR : out  STD_LOGIC_VECTOR (11 downto 0));
end CURSOR_INCREMENTER;

architecture Behavioral of CURSOR_INCREMENTER is
SIGNAL START: STD_LOGIC:='0';
SIGNAL CA : STD_LOGIC_VECTOR (11 downto 0):="000000000000";
begin

PROCESS(CLK)
VARIABLE COUNT: INTEGER:=0;
BEGIN
IF CLK' EVENT AND CLK='0' THEN
--	IF START='0' THEN
--		CA<=CURS_ADDR;
--	END IF;
	IF SEL_WE/="01" THEN
		CA<=CURS_ADDR;
	
	ELSIF SEL_WE="01" THEN
		
		IF START='0' THEN
			START<='1';
		END IF;
			
			
		
		IF(START='1') THEN
			IF (COUNT=0) THEN
				CA<=CA+1;
				COUNT:=COUNT+1;
			ELSE 
				CA<=CA+2;
				COUNT:=0;
			END IF;
		END IF;
	ELSE
		 START<='0'; 
	END IF;

END IF;

END PROCESS;
ADDR<=CA;		
end Behavioral;

