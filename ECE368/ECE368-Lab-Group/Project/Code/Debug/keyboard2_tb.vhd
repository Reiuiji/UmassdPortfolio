----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	keyboard2_tb - testbench
-- Project Name: 		VGA
-- Target Devices: 	Spartan 3E
-- Tool versions: 	Xilinx ISE 14.7
-- Description: 
--
-- Dependencies: 
--
-- Revision: 0.01
-- Revision 0.01: 	First modification for Lab #3
-- Comments: 			
--
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
ENTITY keyboard2_tb IS
END keyboard2_tb;
 
ARCHITECTURE behavior OF keyboard2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT keyboard2
    PORT(
				ps_clk 	: 	IN  std_logic;
				input 	: 	IN  std_logic;
				we 		: 	OUT  std_logic;
				output2  :	OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal ps_clk : std_logic := '0';
   signal input : std_logic := '0';

 	--Outputs
   signal we : std_logic;
   signal output2 : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant period : time := 20 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: keyboard2 PORT MAP (
          ps_clk 	=> ps_clk,
          input 	=> input,
          we 		=> we,
          output2 => output2
        );

	process
   begin		
		wait for 100 ns;
		ps_CLK <= '1';
		wait for 20 ns;
		
		ps_CLK <= '0';	-- Start Bit
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- Bit 7
		input <= '1';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;
		
		ps_CLK <= '0';	-- Bit 6
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;
		
		ps_CLK <= '0';	-- Bit 5
		input <= '1';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- Bit 4
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- Bit 3
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- Bit 2
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- Bit 1
		input <= '1';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- Bit 0
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- parity
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;

		ps_CLK <= '0';	-- stop
		input <= '1';
		wait for 20ns;
		ps_clk <= '1';
		wait for 20ns;
		ps_clk <= '0';
		input <= '0';
		wait for 20ns;
		ps_clk <= '1';
		

		assert (Output2 = "00101101")
			report "Failed Test. Expected 0x129."
			severity error;
			
		report "Test sequence completed."
		severity note;
		
		
      wait;
   end process;

END;
