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
--      Delay Function, Only Outputs at falling clock
--
-- Notes:
--      [none]
--
-- Revision: 
--      0.01  - File Created
--      0.02  - removed reset
--
-- Additional Comments: 
--      Since it toggle back and forth and only realy on
--         the clock, dont need reset... for now.
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity SYNC_FALLING is
	generic(
		DATA_WIDTH:integer:=8
	);

	port (
		CLOCK : in STD_LOGIC;
		INPUT : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		OUTPUT : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
	);

end SYNC_FALLING;

architecture Behavioral of SYNC_FALLING is

begin

	process (CLOCK)
	begin
		if (CLOCK'event and CLOCK='0') then
			output <= input;
		end if;
	end process;

end Behavioral;

