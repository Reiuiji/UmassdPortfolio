----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
--
-- Create Date:    Spring 2014
-- Module Name:    UMD_ALU_FPU_tb
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: VHDL Test Bench for ALU
--
-- Notes:
-- Verifies simple ALU operations.
---------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.ALL;

ENTITY alu_tb_vhd IS
END alu_tb_vhd;

ARCHITECTURE behavior OF alu_tb_vhd IS 

	-- Component Declaration for the Unit Under Test (UUT)
	COMPONENT alu_toplevel
	PORT(
		CLK : IN std_logic;	
		RA : IN std_logic_vector(23 downto 0);
		RB : IN std_logic_vector(23 downto 0);
		OPCODE : IN std_logic_vector(3 downto 0);          
		CCR : OUT std_logic_vector(3 downto 0);
		ALU_OUT : OUT std_logic_vector(23 downto 0)
		);
	END COMPONENT;

	--Inputs
	SIGNAL CLK : std_logic := '0';
	SIGNAL RA :  std_logic_vector(23 downto 0) := (others=>'0');
	SIGNAL RB :  std_logic_vector(23 downto 0) := (others=>'0');
	SIGNAL OPCODE :  std_logic_vector(3 downto 0) := (others=>'0');

	--Outputs
	SIGNAL CCR :  std_logic_vector(3 downto 0);
	SIGNAL ALU_OUT :  std_logic_vector(23 downto 0);
	
	-- Constants
	-- constant period : time := 20 ns; -- 25 MHz =(1/20E-9)/2
	constant period : time := 10 ns; -- 50 MHz =(1/10E-9)/2
	-- constant period : time := 5 ns; -- 100 MHz =(1/10E-9)/2
	
	--Condition Codes
	SIGNAL N : std_logic := '0';
	SIGNAL Z : std_logic := '0';
	SIGNAL V : std_logic := '0';
	SIGNAL C : std_logic := '0';

BEGIN

	-- Instantiate the Unit Under Test (UUT)
	uut: alu_toplevel PORT MAP(
		CLK => CLK,
		RA => RA,
		RB => RB,
		OPCODE => OPCODE,
		CCR => CCR,
		ALU_OUT => ALU_OUT
	);
	
	-- Assign condition code bits
	N <= CCR(3); -- N - Negative
	Z <= CCR(2); -- Z - Zero
	V <= CCR(1); -- V - Overflow
	C <= CCR(0); -- C - Carry/Borrow
	
	-- Generate clock
	m50MHZ_Clock: process
	begin
		clk <= '0'; wait for period;
		clk <= '1'; wait for period;
	end process m50MHZ_Clock;

	tb : PROCESS
	BEGIN	

		-- Wait 100 ns for global reset to finish
		wait for 100 ns;

		report "Start ALU Test Bench" severity NOTE;
		
		----- Register-Register Arithmetic Tests -----
		RA <= "000000000000000000000101"; -- 5
		RB <= "000000000000000000000011"; -- 3
		
		OPCODE <= "0000";  wait for period;
		assert (ALU_OUT = 8)  report "Failed ADD 1. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed ADD 1 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		OPCODE <= "0001";  wait for period;
		assert (ALU_OUT = 2)  report "Failed SUB 1. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed SUB 1 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		OPCODE <= "0010";  wait for period;
		assert (ALU_OUT = 1) report "Failed AND 1. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed AND 1 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		OPCODE <= "0011";  wait for period;
		assert (ALU_OUT = 7)  report "Failed OR 1. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed OR 1 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		RA <= "000000000000000001100100"; -- 100
		RB <= "000000000000000000110010"; -- 50		
		
		OPCODE <= "0000";  wait for period;
		assert (ALU_OUT = 150)  report "Failed ADD 2. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed ADD 2 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		OPCODE <= "0001";  wait for period;
		assert (ALU_OUT = 50)  report "Failed SUB 2. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed SUB 2 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		OPCODE <= "0010";  wait for period;
		assert (ALU_OUT = "0000000000100000") report "Failed AND 2. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed AND 2 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		OPCODE <= "0011";  wait for period;
		assert (ALU_OUT = "0000000001110110")  report "Failed OR 2. ALU_OUT=" & integer'image(to_integer(unsigned(ALU_OUT))) severity ERROR;
		assert (CCR = "0000")  report "Failed OR 2 - CCR. CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		----- END Arithmetic Tests -----
		
		----- CCR Tests -----
		RA <= "000000000000000000000000"; 
		RB <= "000000000000000000000000"; 
		
		OPCODE <= "0000";  wait for period;
		assert (CCR(2) = '1')  report "Failed CCR 1 (Z). CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		RA <= "000000000000000000000001"; 
		RB <= "111111111111111111111111"; 
		
		OPCODE <= "0000";  wait for period;
		assert (Z = '1')  report "Failed CCR 2 (Z). CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		assert (C = '1')  report "Failed CCR 3 (C). CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		RA <= "000000000000000000000000"; 
		RB <= "000000000000000000000001"; 		
		
		OPCODE <= "0001";  wait for period;
		assert (N = '1')  report "Failed CCR 4 (N). CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		RA <= "011111111111111111111111"; 
		RB <= "000000000000000000000001"; 		
		
		OPCODE <= "0000";  wait for period;
		assert (V = '1')  report "Failed CCR 5 (V). CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		RA <= "111111111111111111111111"; 
		RB <= "000000000000000000000001"; 		
		
		OPCODE <= "0000";  wait for period;
		assert (C = '1')  report "Failed CCR 6 (C). CCR=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		----- END CCR Tests -----
		
		-- Mem Test --
		
		OPCODE <= "1001";  wait for period;
		assert (ALU_OUT = 0) report "Failed MEMORY READ(1) ALU_OUT=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		RA <= X"000016";
		OPCODE <= "1010";  wait for period;
		assert (ALU_OUT = 0) report "Failed MEMORY WRITE ALU_OUT=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		OPCODE <= "1001";  wait for period;
		assert (ALU_OUT = X"16") report "Failed MEMORY READ(2) ALU_OUT=" & integer'image(to_integer(unsigned(CCR))) severity ERROR;
		
		-- END Mem Test --
		
		report "Finish ALU Test Bench" severity NOTE;

		wait; -- will wait forever
	END PROCESS;

END;
