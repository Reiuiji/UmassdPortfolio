------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
--					Benjamin Doiron									 --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    debugMemory
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Incorporated a memory init [1]
--      0.03  - Ben: Minor modifications made to the generic reg to use for saving data.
--
-- Additional Comments: 
--      [1]: code adaptive from the following blog
--          http://myfpgablog.blogspot.com/2011/12/memory-initialization-methods.html
--          this site pointed to XST user guide
-- 
-----------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

entity RAM_5x24 is
	generic(
		RAM_WIDTH:	integer:=5; -- 00 - 1F choice
		DATA_WIDTH: integer:=24
	);
	port(
		CLOCK			: in std_logic;
		WE				: in std_logic;
		--RESETN			: in std_logic;
        --OUTPUT RAM
		OUT_ADDR		: in std_logic_vector(RAM_WIDTH-1 downto 0);
		OUT_DATA		: out std_logic_vector(DATA_WIDTH-1 downto 0);
		--INPUT RAM
		IN_ADDR		    : in std_logic_vector(RAM_WIDTH-1 downto 0);
		IN_DATA			: in std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end RAM_5x24;

architecture RAM_ARCH of RAM_5x24 is

	type    ram_type is array (0 to 2**RAM_WIDTH-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
    signal  RAM : ram_type := (
		x"000000", x"000000", x"000000", x"000000", -- 00 - 03
		x"000000", x"000000", x"000000", x"000000", -- 04 - 07
		x"000000", x"000000", x"000000", x"000000", -- 08 - 0B
		x"000000", x"000000", x"000000", x"000000", -- 0C - 0F
		x"000000", x"000000", x"000000", x"000000", -- 10 - 13
		x"000000", x"000000", x"000000", x"000000", -- 14 - 17
		x"000000", x"000000", x"000000", x"000000", -- 18 - 1B
		x"000000", x"000000", x"000000", x"000000"  -- 1C - 1F
	);

	signal	ADDR_IN: std_logic_vector(RAM_WIDTH-1 downto 0);
	
begin
   process(CLOCK,WE)
   begin
			if (CLOCK'event and CLOCK = '0') then
				if (WE = '1') then
					RAM(to_integer(unsigned(IN_ADDR))) <= IN_DATA;
				end if;
				ADDR_IN <= OUT_ADDR;
			end if;
	end process;
	OUT_DATA <= RAM(to_integer(unsigned(ADDR_IN)));
end RAM_ARCH;
