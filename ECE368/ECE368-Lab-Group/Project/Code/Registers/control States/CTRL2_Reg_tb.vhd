------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    24bit_Register_Test_Bench
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Test the 24 bit register
--
-- Notes:
--      [None]
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
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE work.UMDRISC_pkg.ALL;

entity CTRL2_Reg_tb is
end CTRL2_Reg_tb;

architecture Behavioral of CTRL2_Reg_tb is

	component CTRL2_Reg_Falling is

	--GENERIC(
	--	DATA_WIDTH:INTEGER := 24
	--);

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT		: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		SRC1_SEL : OUT STD_LOGIC;
		SRC2_SEL : OUT STD_LOGIC
	);

	end component;

	signal CLOCK : STD_LOGIC := '0';
	signal RESETN : STD_LOGIC := '0';
	signal ENABLE : STD_LOGIC := '0';
	signal INPUT: STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
	signal SRC1_SEL : STD_LOGIC := '0';
	signal SRC2_SEL : STD_LOGIC := '0';

	constant period : time := 10 ns;

begin

	-- Register 1
	uut: CTRL2_Reg_Falling port map(
		CLOCK => Clock,
		RESETN => Resetn,
		ENABLE => ENABLE,
		INPUT => INPUT,
		SRC1_SEL => SRC1_SEL ,
		SRC2_SEL => SRC2_SEL
	);
	


	m50MHZ_Clock: process
	begin
		CLOCK <= '0'; wait for period;
		CLOCK <= '1'; wait for period;
	end process m50MHZ_Clock;

	tb : process
	begin
		-- Wait 100 ns for global reset to finish
		wait for 100 ns;
		report "Starting [name] Test Bench" severity NOTE;

		----- Unit Test -----
		--Reset disable
		RESETN <= '1'; wait for period;
		report "Testing Reset" severity note;
		--assert (SRC1_SEL = 0)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1_SEL))) severity ERROR;
		--assert (SRC2_SEL = 0)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2_SEL))) severity ERROR;
		report "Done Testing Reset" severity note;
		
		INPUT <= x"0FC000";
		--Enabling the register
		ENABLE <= '1'; wait for 2*period;

		report "Testing Output For Src_sel2 enabled, INPUT: 0FC000" severity note;
		--assert SRC1_SEL = '0'  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1_SEL))) severity ERROR;
		--assert SRC2_SEL = '1'  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2_SEL))) severity ERROR;
		report "Done Testing Output For Src_sel2 enabled"" severity note";
		
		report "Testing Output For Src_sel1 enabled, INPUT: BF0000" severity note;
		INPUT <= x"BF0000";
		wait for 2*period;
		--assert SRC1_SEL = '1'  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1_SEL))) severity ERROR;
		--assert SRC2_SEL = '0'  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2_SEL))) severity ERROR;
		report "Done Output For Src_sel1 enabled"" severity note";
		report "Done" severity note;
		wait; -- END Test
	end process;

end Behavioral;
