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
--      4 bit comparitor
--
-- Notes:
--      This will compare two four bit values and output true 
--        if they equal each other
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

entity COMPARE_4BIT is

	port (
		CLOCK 		: in STD_LOGIC;
		A,B 			: in STD_LOGIC_VECTOR (3 downto 0);
		OUT_COMPARE : out STD_LOGIC
	);

end COMPARE_4BIT;

architecture Behavioral of COMPARE_4BIT is

begin
	process (CLOCK)
	begin
		if (CLOCK'event and CLOCK='0') then
			if (A = B) then
				OUT_COMPARE <= '1';
			else
				OUT_COMPARE <= '0';
			end if;
		end if;
	end process;

end Behavioral;
