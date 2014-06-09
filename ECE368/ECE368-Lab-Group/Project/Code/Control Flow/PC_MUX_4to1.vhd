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
--      0.02  - Adaptive for PC
--
-- Additional Comments: 
--      [Insert Comments]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.UMDRISC_pkg.ALL;

entity PC_MUX_4to1 is

	Port (
		SEL		: in   STD_LOGIC_VECTOR (1 downto 0); -- 3 bits
		IN_1	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		IN_2	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		IN_3	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		IN_4	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		OUTPUT	: out  STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0)
	);

end PC_MUX_4to1;

architecture Behavioral of PC_MUX_4to1 is

signal ZERO : STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0) := (others => '0');

begin

with SEL select
	OUTPUT<=	IN_1 when "00",
				IN_2 when "01",
				IN_3 when "10",
				IN_4 when "11",
				ZERO when others;
end Behavioral;
