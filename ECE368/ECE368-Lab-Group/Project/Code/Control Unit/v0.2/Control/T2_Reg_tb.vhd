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

entity T2_Reg_tb is
end T2_Reg_tb;

architecture Behavioral of T2_Reg_tb is

	component T2_Reg is

	--GENERIC(
	--	DATA_WIDTH:INTEGER := 24
	--);

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT	: IN	STD_LOGIC_VECTOR(23 DOWNTO 0);
		OUTPUT	: OUT 	STD_LOGIC_VECTOR(23 DOWNTO 0)
		
		--INPUT	: IN	STD_LOGIC_VECTOR(15 DOWNTO 0);
		--CTL2	: OUT 	STD_LOGIC_VECTOR(11 DOWNTO 0);
		--SRC1	: OUT 	STD_LOGIC_VECTOR(3 DOWNTO 0)
	);

	end component;

	signal CLOCK : STD_LOGIC := '0';
	signal RESETN : STD_LOGIC := '0';
	signal ENABLE : STD_LOGIC := '0';
	signal INPUT: STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');
   signal OUTPUT : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0');

	--signal INPUT: STD_LOGIC_VECTOR(15 DOWNTO 0) := (OTHERS => '0');
	--signal CTL2 : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0');
	--signal SRC1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');


	constant period : time := 10 ns;

begin

	-- Register 1
	Reg1: T2_Reg port map(
		CLOCK => Clock,
		RESETN => Resetn,
		ENABLE => ENABLE,
		INPUT => INPUT,
		OUTPUT => OUTPUT
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
		assert (OUTPUT = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(OUTPUT))) severity ERROR;
		--assert (CTL2 = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(CTL2))) severity ERROR;
		--assert (SRC1 = 00)  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1))) severity ERROR;
		report "Done Testing Reset" severity note;
		
		INPUT <= x"FFF000";
		--Enabling the register
		ENABLE <= '1'; wait for 2*period;
		-- Test each input via loop
		report "Testing Output of Register" severity note;
		assert (OUTPUT = x"FFF000")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(OUTPUT))) severity ERROR;
		
		--assert (CTL2 = x"FF0")  report "Failed Outo. [OUT_Port0]=" & integer'image(to_integer(unsigned(CTL2))) severity ERROR;
		--assert (SRC1 = x"F")  report "Failed READ. [OUT_Port0]=" & integer'image(to_integer(unsigned(SRC1))) severity ERROR;
		report "Done Testing Register output" severity note;
		wait; -- END Test
	end process;

end Behavioral;
