------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    Inst_Memory
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Memory which will hold the instruction memory
--      Originally based on http://www.eng.auburn.edu/~strouce/class/elec4200/RAMmod.pdf
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
USE work.UMDRISC_pkg.ALL;

entity INST_MEMORY is
	port(
		CLOCK: in std_logic;
		CLEAR : in std_logic;
	-- Read from the instruction Memory
		ADDR_OUT: in std_logic_vector(INST_ADDR_WIDTH-1 downto 0);
		D_OUT	: out std_logic_vector(DATA_WIDTH-1 downto 0);
	-- Write to the instruction memory
		WRITE_ENABLE: in std_logic;
		ADDR_IN: in std_logic_vector(INST_ADDR_WIDTH-1 downto 0);
		D_IN 	: in std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end INST_MEMORY;

architecture INST_MEMORY_ARCH_BEHAVIOR of INST_MEMORY is
	--Size of the Data
	subtype	WORD is STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	--Size of the memory block based on the Address width
	type MEMORY  is array (0 to 2**INST_ADDR_WIDTH-1) of WORD;
	--type	MEMORY is array (0 to 2**ADDR_WIDTH-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
	signal RAM : MEMORY :=(others=> x"000000");
	
begin

	process(CLOCK,CLEAR)
	--variable INIT: boolean := true; -- initalize the Memory
	begin
		if(CLEAR = '1') then
			--RAM(0) <= x"123456";
			--RAM <= (others => (others => '0'));
			--D_OUT <= (others => '0');
		else
			if (CLOCK'event and CLOCK = '0') then
				if(WRITE_ENABLE = '1') then
					RAM(to_integer(unsigned(ADDR_IN))) <= D_IN;
				end if;
					D_OUT <= RAM(to_integer(unsigned(ADDR_OUT)));
			end if;
		end if;
	end process;
end INST_MEMORY_ARCH_BEHAVIOR;
