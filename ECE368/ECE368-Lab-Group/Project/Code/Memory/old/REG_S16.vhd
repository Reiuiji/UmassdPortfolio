------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    GenReg_16
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      16 General Purpose Registers
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

entity REG_S16 is
	generic(
		REG_WIDTH:	integer:=4 -- select between 16 different possible registers
	);
	port(
		CLOCK			: in std_logic;
		WE				: in std_logic;
		RESETN			: in std_logic;
		--Register A
		REG_A_ADDR		: in std_logic_vector(REG_WIDTH-1 downto 0);
		REG_A			: out std_logic_vector(DATA_WIDTH-1 downto 0);
		--Register B
		REG_B_ADDR		: in std_logic_vector(REG_WIDTH-1 downto 0);
		REG_B			: out std_logic_vector(DATA_WIDTH-1 downto 0);
		--CHANGE REGISTER
		REG_A_IN_ADDR	: in std_logic_vector(REG_WIDTH-1 downto 0);
		REG_A_IN		: in std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end REG_S16;

architecture REG_ARCH of REG_S16 is

	type	reg_type is array (0 to 2**REG_WIDTH-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
	signal	registers: reg_type;

	signal	ADDR_A_REG: std_logic_vector(REG_WIDTH-1 downto 0);
	signal	ADDR_B_REG: std_logic_vector(REG_WIDTH-1 downto 0);
	
begin
   process(CLOCK)
   begin
		if(RESETN = '0') then
			registers <= (others => (others =>'0'));
		else
			if (CLOCK'event and CLOCK = '0') then
				if (WE = '1') then
					registers(to_integer(unsigned(REG_A_IN_ADDR))) <= REG_A_IN;
				end if;
				ADDR_A_REG <= REG_A_ADDR;
				ADDR_B_REG <= REG_B_ADDR;
			end if;
		end if;
	end process;
	REG_A <= registers(to_integer(unsigned(ADDR_A_REG)));
	REG_B <= registers(to_integer(unsigned(ADDR_B_REG)));
end REG_ARCH;
