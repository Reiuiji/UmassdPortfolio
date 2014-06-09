------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    counter
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
library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
USE work.UMDRISC_pkg.ALL;

entity PC_tb is
end PC_tb;

architecture Behavioral of PC_tb is
	
component PC is
	Port (
		CLOCK				: in	STD_LOGIC;
		RESETN			: in	STD_LOGIC;
		ENABLE			: in	STD_LOGIC;
		
		--input Data to Program counter
		PC_IN				: in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- Change PC to what is on this signal
		PC_FROM_STACK	: in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- change PC from what was on the stack
		PC_SEL			: in STD_LOGIC_VECTOR (1 downto 0); -- Selector to chose what the PC will be
		
		PC_OUT		: out	STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0) -- output of current Program counter
	);
	end component;

	signal CLOCK : STD_LOGIC := '0';
	signal ENABLE: STD_LOGIC := '0';
	signal RESETN : STD_LOGIC := '0';
	signal PC_IN : STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
	signal PC_FROM_STACK : STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
	signal PC_SEL : STD_LOGIC_VECTOR (1 downto 0);
	signal PC_OUT : STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);

	constant period : time := 10 ns;

begin

	-- Instantiate the Unit Under Testing (UUT)
	PC_uut: PC port map(
		CLOCK => CLOCK,
		RESETN => RESETN,
		ENABLE => ENABLE,
		PC_IN => PC_IN,
		PC_FROM_STACK => PC_FROM_STACK,
		PC_SEL => PC_SEL,
		PC_OUT => PC_OUT
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
		report "Starting counter Test Bench" severity NOTE;
		PC_SEL <= "00";
		PC_IN <= (others => '0');
		ENABLE <= '0';
		PC_FROM_STACK <= (others => '0');
		wait for 100 ns;
		----- Unit Test -----

		--Reset
		RESETN <= '0'; wait for 2*period;
		RESETN <= '1'; wait for 2*period;
		
		--Enable
		ENABLE <= '1';
		
		-- Test each input via loop
		for i in 0 to 16 loop 
				assert (PC_OUT = i)  report "Failed Counting. PROGRAM_COUNTER=" & integer'image(to_integer(unsigned(PC_OUT))) severity ERROR; wait for 2*period;
		end loop;
		PC_SEL <= "01";

		report "Finished counter Test Bench" severity NOTE;

	end process;

end Behavioral;
