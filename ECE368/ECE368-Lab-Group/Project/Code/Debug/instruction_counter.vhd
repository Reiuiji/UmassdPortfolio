----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron
-- 
-- Create Date:   	4/22/2014 
-- Design Name: 		Instruction counter
-- Module Name:   	instruction_counter - behavioral
-- Project Name: 		VGA
-- Target Devices: 	Spartan 3E
-- Tool versions: 	Xilinx ISE 14.7
-- Description: 		Counts instructions to make sure there are no issues.
--
-- Revision: 0.01
-- Revision 0.01: 	File Created
----------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity instruction_counter is
	Port (
		clock: 		in  STD_LOGIC;
		RISC_SD	:	in  STD_LOGIC;
		TRANS_SEND: in  STD_LOGIC;
		SEND_OUT:	out STD_LOGIC
	);
end instruction_counter;



architecture Behavioral of instruction_counter is
signal NOINST: integer range 0 to 40;

begin
process(clock)
	begin
		if(clock'event and clock = '0') then
			if(RISC_SD = '1') then
				NOINST <= NOINST + 1;
			end if;

			if(TRANS_SEND = '1') then
				NOINST <= NOINST - 1;
			end if;
			
			if(NOINST = 0) then
				SEND_OUT <= '0';
			else
				SEND_OUT <= '1';
			end if;
		end if;
	end process;
end Behavioral;

