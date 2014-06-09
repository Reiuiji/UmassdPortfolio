--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   21:12:09 04/19/2014
-- Design Name:   
-- Module Name:   C:/Users/Benny/Desktop/Project1UpdatedApril14Version2/debugger_data_to_ascii_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: data_to_ascii
-- 
-- Dependencies:
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
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY debugger_data_to_ascii_tb IS
END debugger_data_to_ascii_tb;
 
ARCHITECTURE behavior OF debugger_data_to_ascii_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT data_to_ascii
    PORT(
         clk : IN  std_logic;
         userreadonly : IN  std_logic;
         new_data_signal : IN  std_logic;
         IN_DATA : IN  std_logic_vector(23 downto 0);
         OUT_ASCII : OUT  std_logic_vector(7 downto 0);
         read_line : OUT  std_logic_vector(4 downto 0);
         MUX_SEL_DATA : OUT  std_logic_vector(1 downto 0);
			debugoutput 		: out STD_LOGIC_VECTOR (7 downto 0);
			debugcounter 		: out integer
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal userreadonly : std_logic := '0';
   signal new_data_signal : std_logic := '0';
   signal IN_DATA : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal OUT_ASCII : std_logic_vector(7 downto 0);
   signal read_line : std_logic_vector(4 downto 0) := "00000";
   signal MUX_SEL_DATA : std_logic_vector(1 downto 0) :="00";
	signal debugoutput : STD_LOGIC_VECTOR (7 downto 0);
	signal debugcounter 		: integer := 0;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data_to_ascii PORT MAP (
          clk => clk,
          userreadonly => userreadonly,
          new_data_signal => new_data_signal,
          IN_DATA => IN_DATA,
          OUT_ASCII => OUT_ASCII,
          read_line => read_line,
          MUX_SEL_DATA => MUX_SEL_DATA,
				debugoutput => debugoutput,
				debugcounter => debugcounter
        );

   -- Stimulus process
   stim_proc: process
   begin		
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
									userreadonly <= '1';
									new_data_signal <= '1';
									IN_DATA <= x"123456";
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
									new_data_signal <= '0';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait for 20 ns;		clk <= '1';
		wait for 20 ns;		clk <= '0';
		wait;
   end process;

END;
