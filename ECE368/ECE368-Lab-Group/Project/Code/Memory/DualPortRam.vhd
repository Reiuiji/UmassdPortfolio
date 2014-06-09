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
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity VGA_RAM is
	generic(
		ADDR_WIDTH:	integer:=12;
		DATA_WIDTH:	integer:=7
	);
	port(
		CLOCK: in std_logic;
		WRITE_ENABLE: in std_logic;
		CLEAR : in std_logic;
		ADDRESS_A: in std_logic_vector(ADDR_WIDTH-1 downto 0);
		ADDRESS_B: in std_logic_vector(ADDR_WIDTH-1 downto 0);
		DATA_IN_A: in std_logic_vector(DATA_WIDTH-1 downto 0);
		--DATA_OUT_A: out std_logic_vector(DATA_WIDTH-1 downto 0);
		--DATA_IN_B: in std_logic_vector(DATA_WIDTH-1 downto 0);
		DATA_OUT_B: out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end VGA_RAM;

architecture RAM_ARCH of VGA_RAM is
	type	ram_type is array (0 to 2**ADDR_WIDTH-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
	signal	ram: ram_type:=(others=> x"00");
	signal	ADDRESS_A_REG: std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal	ADDRESS_B_REG: std_logic_vector(ADDR_WIDTH-1 downto 0);
	
begin
   process(CLOCK)
   begin
		if(CLEAR = '1') then
			--ram <= (others => '0');
		else
			if (CLOCK'event and CLOCK = '1') then
				if (WRITE_ENABLE = '1') then
					ram(to_integer(unsigned(ADDRESS_A))) <= DATA_IN_A;
				end if;
				ADDRESS_A_REG <= ADDRESS_A;
				ADDRESS_B_REG <= ADDRESS_B;
			end if;
		end if;
	end process;
	--DATA_OUT_A <= ram(to_integer(unsigned(ADDRESS_A_REG)));
	DATA_OUT_B <= ram(to_integer(unsigned(ADDRESS_B_REG)));
end RAM_ARCH;
