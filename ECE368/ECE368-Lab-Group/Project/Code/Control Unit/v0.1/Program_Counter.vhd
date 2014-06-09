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
USE work.UMDRISC_pkg.ALL;

entity PC is

	Port (
		CLOCK				: in	STD_LOGIC;
		RESET				: in	STD_LOGIC;
		ENABLE				: in	STD_LOGIC;
		PROGRAM_COUNTER		: out	STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0)
	);
			   
end PC;

architecture Behavioral of PC is

signal PC : std_logic_vector(PC_WIDTH-1 downto 0):= (others => '0'); --<= (others <= "0"); -- Program Counter

begin
	process (CLOCK, RESET)
	begin
		if (RESET = '1') then 
			PC <= (OTHERS => '0');
		elsif CLOCK = '0' and CLOCK'event then
			if ENABLE = '1' then
				if PC = x"FF" then --MEM_LIMIT) then
					PC <= (OTHERS => '0');
				else
					PC <= PC + 1;
				end if;
			end if;
		end if;
	end process;
	PROGRAM_COUNTER <= PC;
end Behavioral;
