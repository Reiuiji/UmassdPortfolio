--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY transfer_tb IS
END transfer_tb;
 
ARCHITECTURE behavior OF transfer_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT TRANSFER
    PORT(
         CLOCK : IN  std_logic;
         Sent : IN  std_logic;
         INPUT : IN  std_logic_vector(23 downto 0);
         OUTPUT : OUT  std_logic_vector(7 downto 0);
		   MUX_OUT: out STD_LOGIC_VECTOR(1 DOWNTO 0)
        );
    END COMPONENT;
    

   --Inputs
   signal CLOCK : std_logic := '0';
   signal Sent : std_logic := '0';
   signal INPUT : std_logic_vector(23 downto 0) := (others => '0');

 	--Outputs
   signal OUTPUT : std_logic_vector(7 downto 0);
	signal MUX_OUT: std_logic_vector(1 DOWNTO 0) := (others => '0');
	
	constant period : time := 10 ns;

BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: TRANSFER PORT MAP (
          CLOCK => CLOCK,
          Sent => Sent,
          INPUT => INPUT,
          OUTPUT => OUTPUT,
			 MUX_OUT => MUX_OUT
        );
		  
	m50MHZ_Clock: process
	begin
		CLOCK <= '0'; wait for period;
		CLOCK <= '1'; wait for period;
	end process m50MHZ_Clock;
 
   -- Stimulus process
   stim_proc: process
   begin		
		wait for 10*period;
		INPUT <= x"123456";
		Sent <='1';
   end process;

END;
