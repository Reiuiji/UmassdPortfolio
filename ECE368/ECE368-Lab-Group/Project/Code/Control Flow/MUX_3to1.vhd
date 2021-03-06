------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    MUX_4to1
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      Selector MUX 3 input to 1 output
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
use work.UMDRISC_pkg.ALL;

entity MUX_3to1 is

	Port (
		SEL		: in   STD_LOGIC_VECTOR (1 downto 0); -- 3 bits
		IN_1	: in   STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		IN_2	: in   STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		IN_3	: in   STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		OUTPUT	: out  STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0)
	);

end MUX_3to1;

architecture Behavioral of MUX_3to1 is

signal ZERO : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (others => '0');

begin

with SEL select
	OUTPUT<=	IN_1 when "00",
				IN_2 when "01",
				IN_3 when "10",
				ZERO when others;
end Behavioral;
