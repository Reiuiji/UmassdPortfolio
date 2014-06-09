--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   09:08:55 02/26/2014
-- Design Name:   
-- Module Name:   C:/Labs/Lab3/scan_to_ascii_tb.vhd
-- Project Name:  Lab3
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: scan_to_ascii
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
 
ENTITY scan_to_ascii_tb IS
END scan_to_ascii_tb;
 
ARCHITECTURE behavior OF scan_to_ascii_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT scan_to_ascii
    PORT(
         scancode : IN  std_logic_vector(7 downto 0);
         clk : IN  std_logic;
         output : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal scancode : std_logic_vector(7 downto 0) := (others => '0');
   signal clk : std_logic := '0';

 	--Outputs
   signal output : std_logic_vector(6 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: scan_to_ascii PORT MAP (
          scancode => scancode,
          clk => clk,
          output => output
        );

   -- Stimulus process
	process
   begin		
	
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		scancode <= "01000101";
		wait for 20 ns;
		clk <= '0';
      wait;
   end process;

END;
