------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    RegF
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Presenation Code: Dr.Fortier(c)
--      24 bit register
--
-- Notes:
--      Clock on FALLING EDGE
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Cleaned up Code given
--      0.03  - Perform the functionality of the Stack File
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY StackFile_TB IS
END StackFile_TB;
 
ARCHITECTURE behavior OF StackFile_TB IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT stackFile
    PORT(
         Clock : IN  std_logic;
         Resetn : IN  std_logic;
         ENABLE : IN  std_logic;
			ENABLEP : IN  std_logic;
         pushPop : IN  std_logic;
         INPUT : IN  std_logic_vector(23 downto 0);
         isSuccess : OUT  std_logic;
         OUTPUT : OUT  std_logic_vector(23 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Clock : std_logic := '0';
   signal Resetn : std_logic := '0';
   signal ENABLE : std_logic := '0';
	signal ENABLEP : std_logic := '0';
   signal pushPop : std_logic := '1';
   signal INPUT : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal isSuccess : std_logic;
   signal OUTPUT : std_logic_vector(23 downto 0);

   -- Clock period definitions
   constant period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: stackFile PORT MAP (
          Clock => Clock,
          Resetn => Resetn,
          ENABLE => ENABLE,
			 ENABLEP => ENABLEP,
          pushPop => pushPop,
          INPUT => INPUT,
          isSuccess => isSuccess,
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
		report "Starting StackFile Test Bench" severity NOTE;

		----- Unit Test -----
		--Reset disable
		RESETN <= '0'; wait for period;
		report "Testing Reset" severity note;
		assert (OUTPUT = x"000000")  report "Failed Reset" severity ERROR;
		report "Done Testing Reset" severity note;
		
		INPUT <= x"FFFFFF";
		RESETN <= '1';
		--Enabling the register
		ENABLE <= '1'; wait for 2*period;
		
		report "Testing Output of Register: Push/ Pop" severity note;
		wait for 2*period;
		pushPop <= '1';INPUT <= x"FFFFFF"; 
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='0')  report "Failed Detect that the stack is Empty" severity ERROR;
		wait for period;
		
		report "Testing Output of Register: Push FFFFFF" severity note;
		wait for 2*period;
		pushPop <= '0'; INPUT <= x"FFFFFF";
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='1')  report "Failed to successfull Push success" severity ERROR;
		assert (OUTPUT =x"FFFFFF")  report "Failed to successfull Push" severity ERROR;
		wait for period;
		
		report "Testing Output of Register: Push FFFFF0" severity note;
		wait for 2*period;

		pushPop <= '0'; INPUT <= x"FFFFF0";
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='1')  report "Failed to successfull Push success" severity ERROR;
		assert (OUTPUT =x"FFFFF0")  report "Failed to successfull Push" severity ERROR;
		wait for period;
		
		report "Testing Output of Register: Push FFFF00" severity note;
		wait for 2*period;
		
		pushPop <= '0';INPUT <= x"FFFF00";
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='1')  report "Failed to successfull Push success" severity ERROR;
		assert (OUTPUT =x"FFFF00")  report "Failed to successfull Push" severity ERROR;
		wait for period;
	
		report "Testing Output of Register: Push FFF000" severity note;
		wait for 2*period;

		pushPop <= '0'; INPUT <= x"FFF000";
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='1')  report "Failed to successfull Push success" severity ERROR;
		assert (OUTPUT =x"FFF000")  report "Failed to successfull Push" severity ERROR;
	   wait for period;

		report "Testing for Push" severity note;
		wait for 2*period;
		pushPop <= '0'; INPUT <= x"FFF000";
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='0')  report "Failed Detect that the stack is Full" severity ERROR;
		wait for period;
		
		-- Testting pop
		report "Testing for POP-1" severity note;
		wait for 2*period;
		pushPop <= '1';
		ENABLEP <= '1';wait for period;ENABLEP <= '0';
		assert (isSuccess ='1')  report "Failed to successfull POP " severity ERROR;
		assert (OUTPUT =x"FFF000")  report "Failed to  pop" severity ERROR;
		wait for period;

		report "Testing for POP-2" severity note;
		wait for 2*period;
		pushPop <= '1';
		ENABLEP <= '1';wait for period;ENABLEP <= '0';--wait for period;
		assert (isSuccess ='1')  report "Failed to successfull POP" severity ERROR;
		assert (OUTPUT =x"FFFF00")  report "Failed to  POP" severity ERROR;
		wait for period;
		
		report "Testing for POP-3" severity note;
		wait for 2*period;
		pushPop <= '1';
		ENABLEP <= '1';wait for period;ENABLEP <= '0';--wait for period;
		assert (isSuccess ='1')  report "Failed to successfull POP" severity ERROR;
		assert (OUTPUT =x"FFFFF0")  report "Failed to  POP" severity ERROR;
		wait for period;
		
		report "Testing for POP-4" severity note;
		wait for 2*period;
		pushPop <= '1';
		ENABLEP <= '1';wait for period;ENABLEP <= '0';--wait for period;
		assert (isSuccess ='1')  report "Failed to successfull POP" severity ERROR;
		assert (OUTPUT =x"FFFFFF")  report "Failed to  POP" severity ERROR;
	   wait for period;
		
		report "Done Testing For Push/Pop" severity note;
		report "Done" severity note;
		wait; -- END Test
	end process;

END;
