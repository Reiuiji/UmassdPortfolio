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

entity CTRL1_Reg_tb is
end CTRL1_Reg_tb;

architecture Behavioral of CTRL1_Reg_tb is

	component CTRL1_Reg_Falling is

	--GENERIC(
	--	DATA_WIDTH:INTEGER := 24
	--);

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT		: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		SR_SEL 	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		SRC0_SEL : OUT STD_LOGIC;
		SRC1_SEL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SRC2_SEL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		OPCODE   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 		
		SRC1		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SRC2		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		DST		: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);

	end component;

	signal CLOCK : STD_LOGIC := '0';
	signal RESETN : STD_LOGIC := '0';
	signal ENABLE : STD_LOGIC := '0';
	signal INPUT: STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
	signal SR_SEL 	 : STD_LOGIC_VECTOR(1 DOWNTO 0):= (OTHERS => '0');
	signal SRC0_SEL : STD_LOGIC := '0';
	signal SRC1_SEL : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
	signal SRC2_SEL : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
	signal OPCODE   : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0'); 		
	signal SRC1		 : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
	signal SRC2		 : STD_LOGIC_VECTOR(3 DOWNTO 0):= (OTHERS => '0');
	signal DST		 : STD_LOGIC_VECTOR(11 DOWNTO 0):= (OTHERS => '0');


	constant period : time := 10 ns;

begin

	-- Register 1
	uut: CTRL1_Reg_Falling port map(
		CLOCK => Clock,
		RESETN => Resetn,
		ENABLE => ENABLE,
		INPUT => INPUT,
		SR_SEL => SR_SEL,
		SRC0_SEL => SRC0_SEL,
		SRC1_SEL => SRC1_SEL ,
		SRC2_SEL => SRC2_SEL,
		OPCODE => OPCODE,
		SRC1 => SRC1,
		SRC2 => SRC2,
		DST => DST 
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
		assert (SR_SEL = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SR_SEL))) severity ERROR;
		--assert (SRC0_SEL = '0')  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC0_SEL))) severity ERROR;
		assert (SRC1_SEL = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1_SEL))) severity ERROR;
		assert (SRC2_SEL = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2_SEL))) severity ERROR;
		assert (OPCODE = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(OPCODE))) severity ERROR;
		assert (SRC1 = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1))) severity ERROR;
		assert (SRC2 = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2))) severity ERROR;
		assert (DST = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(DST))) severity ERROR;
		report "Done Testing Reset" severity note;
		
		INPUT <= x"0FC000";
		--Enabling the register
		ENABLE <= '1'; wait for 2*period;
		-- Test each input via loop
		report "Testing Output of Register" severity note;
		assert (SR_SEL = "11")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SR_SEL))) severity ERROR;
		--assert (SRC0_SEL = x"0")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC0_SEL))) severity ERROR;
		assert (SRC1_SEL = x"F")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1_SEL))) severity ERROR;
		assert (SRC2_SEL = x"C")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2_SEL))) severity ERROR;
		assert (OPCODE = x"0")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(OPCODE))) severity ERROR;
		assert (SRC1 = x"F")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1))) severity ERROR;
		assert (SRC2 = x"C")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC2))) severity ERROR;
		assert (DST = x"000")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(DST))) severity ERROR;
		report "Done Testing Register output" severity note;
		report "Testing For Sign Extended" severity note;
		INPUT <= x"FFC000";
		wait for 2*period;
		--assert (SRC0_SEL = x"1")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC0_SEL))) severity ERROR;
		report "Done Testing For Sign Extended" severity note;
		report "Done" severity note;
		wait; -- END Test
	end process;

end Behavioral;
