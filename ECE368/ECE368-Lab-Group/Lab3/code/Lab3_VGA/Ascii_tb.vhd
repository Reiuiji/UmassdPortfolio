----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
--
-- Create Date:    Spring 2014
-- Module Name:    VGA Mem Test Bench
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Test Bench for the Memory
--
----------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

entity ASCII_tb is
end ASCII_tb;

architecture Behavioral of ASCII_tb is

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT KEYCODE_TO_ASCII is

	generic(
		DATA_WIDTH:integer:=8
	);

	port(--Input
		--CLOCK   : in STD_LOGIC;
		RESET   : in STD_LOGIC;
		KEYCODE : in STD_LOGIC_VECTOR(7 downto 0); --(DATA_WIDTH-1 downto 0);
		VALID_SIGNAL : in STD_LOGIC;
		-- Output
		COMPLETE: out STD_LOGIC; -- Hit Key sucessfully
		WRITE_ENABLE : out STD_LOGIC; -- Can that character write to screen?
		ASCII   : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		KEYCODE_OUTPUT : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
	);
	
	END COMPONENT;

	--Inputs
	SIGNAL CLOCK : std_logic := '0';
	SIGNAL RESET : std_logic := '0';
	SIGNAL VALID_SIGNAL : std_logic := '0';
	SIGNAL KEYCODE :  std_logic_vector(7 downto 0) := (others=>'0');

	--Outputs
	SIGNAL COMPLETE: STD_LOGIC := '0'; -- Hit Key sucessfully
	SIGNAL WRITE_ENABLE : STD_LOGIC := '0'; -- Can that character write to screen?
	SIGNAL ASCII   : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');
	SIGNAL KEYCODE_OUTPUT : STD_LOGIC_VECTOR(7 downto 0) := (others=>'0');

	-- Constants
	-- constant period : time := 20 ns; -- 25 MHz =(1/20E-9)/2
	constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2
	-- constant period : time := 5 ns; -- 100 MHz =(1/10E-9)/2

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: KEYCODE_TO_ASCII PORT MAP(
		--clk => CLOCK,
		RESET => RESET,
		KEYCODE => KEYCODE,
		VALID_SIGNAL => VALID_SIGNAL,
		COMPLETE => COMPLETE,
		WRITE_ENABLE => WRITE_ENABLE,
		ASCII => ASCII,
		KEYCODE_OUTPUT => KEYCODE_OUTPUT
	);
	
	-- Generate clock
	m50MHZ_Clock: process
	begin
		CLOCK <= '0'; wait for period;
		CLOCK <= '1'; wait for period;
	end process m50MHZ_Clock;

	tb : PROCESS
	BEGIN	

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		report "Starting MEMORY Test Bench" severity NOTE;
		
		----- Memory Tests -----
		
		--Reset
		RESET <= '1'; wait for period;
		RESET <= '0'; wait for period;
		
		VALID_SIGNAL <= '1';
		KEYCODE <= "00000001";  wait for 2*period;
		--assert (ASCII = 01)  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		
		--enable write
		RESET <= '1';  wait for 2*period; 
		--assert (ASCII = 0)  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		RESET <= '0';  wait for 2*period;
		
		--Type : Hello
		--H
		KEYCODE <= x"F0";
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		KEYCODE <= x"33";    wait for 2*period;
		--assert (ASCII = x"48")  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		
		--E
		KEYCODE <= x"F0";
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		KEYCODE <= x"24";    wait for 2*period;
		--assert (ASCII = x"45")  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		
		--L
		KEYCODE <= x"F0";
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		KEYCODE <= x"4B";    wait for 2*period;
		--assert (ASCII = x"4C")  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		
		--L
		KEYCODE <= x"F0";
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		KEYCODE <= x"4B";    wait for 2*period;
		--assert (ASCII = x"4C")  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		
		--O
		KEYCODE <= x"F0";
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		KEYCODE <= x"44";    wait for 2*period;
		--assert (ASCII = x"4F")  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
		VALID_SIGNAL <= '0'; wait for period;
		VALID_SIGNAL <= '1'; wait for period;
		
		-- Test each input
		for i in 65 to 256 loop --zero 
				KEYCODE <= x"F0";
				VALID_SIGNAL <= '0'; wait for period;
				VALID_SIGNAL <= '1'; wait for period;
				KEYCODE <= std_logic_vector(to_signed(i,KEYCODE'length)); wait for 2*period;
				VALID_SIGNAL <= '0'; wait for period;
				VALID_SIGNAL <= '1'; wait for period;
				--assert (ASCII = i)  report "Failed READ. ASCII=" & integer'image(to_integer(unsigned(ASCII))) severity ERROR;
				--wait for period;
		end loop;
		
		--disable write
		RESET <= '0';  wait for period; 
		
		---- END Memory Test ----
		
		report "Finish ALU Test Bench" severity NOTE;

		wait; -- will wait forever
	END PROCESS;

END;

