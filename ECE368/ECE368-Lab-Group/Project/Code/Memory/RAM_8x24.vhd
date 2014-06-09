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
--      0.02  - Incorporated a memory init [1]
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

entity RAM_8x24 is
	generic(
		RAM_WIDTH:	integer:=8; -- 00 - FF choice
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
end RAM_8x24;

architecture RAM_ARCH of RAM_8x24 is

	type    ram_type is array (0 to 2**RAM_WIDTH-1) of std_logic_vector (DATA_WIDTH-1 downto 0);
    signal  RAM : ram_type := (
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 00 - 07
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 08 - 0F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 10 - 17
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 18 - 1F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 20 - 27
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 28 - 2F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 30 - 37
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 38 - 3F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 40 - 47
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 48 - 4F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 50 - 57
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 58 - 5F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 60 - 67
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 68 - 6F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 70 - 77
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 78 - 7F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 80 - 87
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 88 - 8F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 90 - 97
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- 98 - 9F
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- A0 - A7
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- A8 - AF
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- B0 - B7
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- B8 - BF
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- C0 - C7
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- C8 - CF
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- D0 - D7
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- D8 - DF
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- E0 - E7
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- E8 - EF
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", -- F0 - F7
		x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000", x"000000"  -- F8 - FF
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
