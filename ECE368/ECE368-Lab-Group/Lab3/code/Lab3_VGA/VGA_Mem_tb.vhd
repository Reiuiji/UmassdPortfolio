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

entity VGAMem_tb is
end VGAMem_tb;

architecture Behavioral of VGAMem_tb is

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT xilinx_dual_port_ram_sync
	   generic(
      ADDR_WIDTH: integer:=8;
      DATA_WIDTH:integer:=8
   );
port(
      clk: in std_logic;
      we: in std_logic;
		CLR : in std_logic;
      addr_a: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      addr_b: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      din_a: in std_logic_vector(DATA_WIDTH-1 downto 0);
		dout_b: out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
	END COMPONENT;

	--Inputs
	SIGNAL CLOCK : std_logic := '0';
	SIGNAL RESET : std_logic := '0';
	SIGNAL WRITE_ENABLE : std_logic := '0';
	SIGNAL DATA_IN :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL ADDRESS_IN :  std_logic_vector(7 downto 0) := (others=>'0');
	SIGNAL ADDRESS_OUT :  std_logic_vector(7 downto 0) := (others=>'0');

	--Outputs
	SIGNAL DATA_OUT :  std_logic_vector(7 downto 0);

	-- Constants
	-- constant period : time := 20 ns; -- 25 MHz =(1/20E-9)/2
	constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2
	-- constant period : time := 5 ns; -- 100 MHz =(1/10E-9)/2

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: xilinx_dual_port_ram_sync PORT MAP(
		clk => CLOCK,
		clr => RESET,
		addr_a => ADDRESS_IN,
		din_a => DATA_IN,
		addr_b => ADDRESS_OUT,
		dout_b => DATA_OUT,
		we => WRITE_ENABLE
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
		
		DATA_IN <= "00000001"; -- 1
		
		ADDRESS_IN <= "00000000";  wait for 2*period;
		--Remove, did not need since after Write enable which will change the mem from UUUUUU to 0000001
		--assert (DATA_OUT = 0)  report "Failed READ. DATA_OUT=" & integer'image(to_integer(unsigned(DATA_OUT))) severity ERROR;
		
		--enable write
		WRITE_ENABLE <= '1';  wait for 4*period; 
		assert (DATA_OUT = 1)  report "Failed READ. DATA_OUT=" & integer'image(to_integer(unsigned(DATA_OUT))) severity ERROR;
		
		-- Test each memory block
		for i in 0 to 32 loop --zero 
				DATA_IN <= std_logic_vector(to_signed(i,DATA_IN'length));
				ADDRESS_IN <= std_logic_vector(to_signed(i,ADDRESS_IN'length)); wait for 2*period;
				ADDRESS_OUT <= std_logic_vector(to_signed(i,ADDRESS_OUT'length)); wait for 2*period;
				assert (DATA_OUT = i)  report "Failed READ. DATA_OUT=" & integer'image(to_integer(unsigned(DATA_OUT))) severity ERROR;
				--wait for period;
		end loop;
		
		--disable write
		WRITE_ENABLE <= '0';  wait for period; 
		
		---- END Memory Test ----
		
		report "Finish ALU Test Bench" severity NOTE;

		wait; -- will wait forever
	END PROCESS;

END;

