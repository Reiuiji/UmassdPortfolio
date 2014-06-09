LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY data_to_ascii_tb IS
END data_to_ascii_tb;
 
ARCHITECTURE behavior OF data_to_ascii_tb IS 
 
    COMPONENT data_to_ascii
    PORT(
			clk: IN std_logic;
         IN_DATA : IN  std_logic_vector(23 downto 0);
         OUT_ASCII : OUT  std_logic_vector(7 downto 0);
			debugoutput : out STD_LOGIC_VECTOR (7 downto 0);
			debugcounter : out integer
        );
    END COMPONENT;
    

   --Inputs
	signal clk: std_logic :='0';
   signal IN_DATA : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal OUT_ASCII : std_logic_vector(7 downto 0);
	signal debugoutput: std_logic_vector(7 downto 0);
	signal debugcounter: integer;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: data_to_ascii PORT MAP (
			 clk => clk,
          IN_DATA => IN_DATA,
          OUT_ASCII => OUT_ASCII,
			 debugoutput => debugoutput,
			 debugcounter => debugcounter
        ); 

   -- Stimulus process
   stim_proc: process
   begin			
		WAIT FOR 200 NS;
		CLK <= '1';
		IN_DATA (23 downto 20) <= x"0";
		IN_DATA (19 downto 16) <= x"2";
		IN_DATA (15 downto 12) <= x"A";
		IN_DATA (11 downto  8) <= x"B";
		IN_DATA ( 7 downto  4) <= x"C";
		IN_DATA ( 3 downto  0) <= "ZZZZ";
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
		wait for 20 ns;
		clk <= '0';
		wait for 20 ns;
		clk <= '1';
      wait;
   end process;

END;
