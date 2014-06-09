---------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- 
-- Create Date:    SPRING 2014
-- Module Name:    UMD_ALU_FPU
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Clock Divider
-- 	Lower the Clock frequency from
-- 	50 Mhz to 2 hz
-- 	50Mhz = 50,000,000/25,000,000 = 2 Hz 
--		2Hz/2 => 1 second 
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
---------------------------------------------------

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;
 
ENTITY counter_tb IS
END counter_tb;
 
ARCHITECTURE behavior OF counter_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clock_toplevel
    PORT(
         CLOCK : IN  std_logic;
         DIRECTION : IN  std_logic;
         RESET: IN STD_LOGIC;
			COUNT_OUT : OUT  std_logic_vector(3 downto 0)
		  );
    END COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal DIRECTION : std_logic := '0';
	signal RESET : std_logic := '0';
 	--Outputs
   signal COUNT_OUT : std_logic_vector(3 downto 0);
 
 	--Constants
	constant period : time := 20 ns;
	
BEGIN
	--Instantiate the unit under test (UUT)
	uut: clock_toplevel PORT MAP(
	CLOCK => CLOCK,
	DIRECTION => DIRECTION,
	RESET =>RESET,
	COUNT_OUT => COUNT_OUT
	);
	--GENERATE The clock 
	m50MHZ_Clock: process 
	begin 
		clock <= '0'; wait for period;
		clock <= '1'; wait for period;
	end process m50MHZ_Clock;
	
	--STIMULUS Process 
	tb : process 
	begin 
		wait for 20 ns; 
		report "Start counter Test Bench" severity NOTE;  
		DIRECTION <='0';
		wait for 40 ns; assert COUNT_OUT ="1111" report "ERROR: expected 1111 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1110" report "ERROR: expected 1110 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1101" report "ERROR: expected 1101 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1100" report "ERROR: expected 1100 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1011" report "ERROR: expected 1011 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1010" report "ERROR: expected 1010 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1001" report "ERROR: expected 1001 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1000" report "ERROR: expected 1000 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0111" report "ERROR: expected 0111 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0110" report "ERROR: expected 0110 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0101" report "ERROR: expected 0101 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0100" report "ERROR: expected 0100 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0011" report "ERROR: expected 0011 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0010" report "ERROR: expected 0010 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0001" report "ERROR: expected 0001 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0000" report "ERROR: expected 0000 for COUNT_OUT" severity ERROR; 
		DIRECTION <= '1';
		wait for 40 ns; assert COUNT_OUT ="0001" report "ERROR: expected 0001 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0010" report "ERROR: expected 0010 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0011" report "ERROR: expected 0011 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0100" report "ERROR: expected 0100 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0101" report "ERROR: expected 0101 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0110" report "ERROR: expected 0110 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="0111" report "ERROR: expected 0111 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1000" report "ERROR: expected 1000 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1001" report "ERROR: expected 1001 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1010" report "ERROR: expected 1010 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1011" report "ERROR: expected 1011 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1100" report "ERROR: expected 1100 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1101" report "ERROR: expected 1101 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1110" report "ERROR: expected 1110 for COUNT_OUT" severity ERROR; 
		wait for 40 ns; assert COUNT_OUT ="1111" report "ERROR: expected 1111 for COUNT_OUT" severity ERROR; 
		
		report "Counter Test done." severity note;
		wait; -- END Test
	end process;

END;
