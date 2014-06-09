library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

entity TB_control_entity is
end TB_control_entity;

architecture Behavioral of TB_control_entity is

	component control_entity is

		Port (
			ADD0		: OUT STD_LOGIC;
			SUB0		: OUT STD_LOGIC;
			AND0  	: OUT STD_LOGIC;
			OR0 		: OUT STD_LOGIC;
			MOV0		: OUT STD_LOGIC;
			ADDI0	: OUT STD_LOGIC;
			ANDI0	: OUT STD_LOGIC;
			SL0		: OUT STD_LOGIC;
			SR0		: OUT STD_LOGIC;
			Opcode	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
			Opcode_Out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			Write2Register : OUT STD_LOGIC;
			Clock, Reset : IN STD_LOGIC;
			Enable : IN STD_LOGIC
		);

	end component;

	SIGNAL Opcode, Opcode_out : STD_LOGIC_VECTOR(3 downto 0);
	SIGNAL Clock, Reset, Enable : STD_LOGIC;

	SIGNAL ADD0,SUB0,AND0,OR0,MOV0,ADDI0,ANDI0,SL0,SR0		: STD_LOGIC;
	SIGNAL Write2Register : STD_LOGIC;

	constant period : time := 10 ns;

begin

	UUT: control_entity port map(
		ADD0 => ADD0,
		SUB0 => SUB0,
		AND0 => AND0,
		OR0  => OR0,
		MOV0 => MOV0,
		ADDI0 => ADDI0,
		ANDI0 => ANDI0,
		SL0 => SL0,
		SR0 => SR0,
		Opcode  => Opcode,
		Opcode_Out => Opcode_Out,
		Write2Register => Write2Register,
		clock => clock,
		reset => reset,
		Enable => enable
	);

	m50MHZ_Clock: process
	begin
		CLOCK <= '0'; wait for period;
		CLOCK <= '1'; wait for period;
	end process m50MHZ_Clock;

	tb : process
	begin

		wait for 100 ns;
		report "Starting Test Bench" severity NOTE;

		opcode <= "0000"; wait for 2*period;

		reset <= '1'; wait for 2*period;
		reset <= '0'; wait for 2*period;
		
		Enable <= '1'; wait for 2*period;


		opcode <= "0000"; wait for 2*period;
		opcode <= "0001"; wait for 2*period;
		opcode <= "0010"; wait for 2*period;
		opcode <= "0011"; wait for 2*period;
		opcode <= "0100"; wait for 2*period;
		opcode <= "0101"; wait for 2*period;
		opcode <= "0110"; wait for 2*period;
		opcode <= "0111"; wait for 2*period;
		opcode <= "1000"; wait for 2*period;
		opcode <= "1001"; wait for 2*period;
		opcode <= "1010"; wait for 2*period;
		opcode <= "1011"; wait for 2*period;
		opcode <= "1100"; wait for 2*period;
		opcode <= "1101"; wait for 2*period;
		opcode <= "1110"; wait for 2*period;
		opcode <= "1111"; wait for 2*period;
	end process;

end Behavioral;


