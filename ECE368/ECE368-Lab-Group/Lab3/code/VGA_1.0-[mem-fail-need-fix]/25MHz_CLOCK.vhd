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
--      This Will Cut the Clock in Half
--      INPUT  : 50 MHz
--      OUTPUT : 25 MHz
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

entity CLOCK_25MHz is

	port (
		CLOCK : in STD_LOGIC;
		CLOCK_25MHz : out STD_LOGIC
	);

end CLOCK_25MHz;

architecture Behavioral of CLOCK_25MHz is

signal CLOCK25MHz : STD_LOGIC;

begin

	CLOCK_25MHz <= CLOCK25MHz;

	process (CLOCK)
	begin
		if (CLOCK'event and CLOCK='0') then
			CLOCK25MHz <= CLOCK25MHz;
		end if;
	end process;

end Behavioral;
