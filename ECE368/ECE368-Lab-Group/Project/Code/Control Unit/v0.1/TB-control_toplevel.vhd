library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

entity TB_control_toplevel is
end TB_control_toplevel;

architecture Behavioral of TB_control_toplevel is

	component control_toplevel is

		PORT (
			CLOCK			: in	STD_LOGIC;
			RESETN			: in	STD_LOGIC;
			ENABLE			: in	STD_LOGIC;
			INSTRUCTION		: in	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			PC				: in	STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			SR_SEL_CTRL1	: OUT	STD_LOGIC_VECTOR(1 DOWNTO 0);
			SRC0_SEL_CTRL1	: OUT	STD_LOGIC;
			SRC1_SEL_CTRL1	: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			SRC2_SEL_CTRL1	: OUT	STD_LOGIC_VECTOR(3 DOWNTO 0);
			SIGN			: OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);
			IMMED			: BUFFER	STD_LOGIC_VECTOR(11 DOWNTO 0);
			SRC1_SEL_CTRL2	: OUT	STD_LOGIC;
			SRC2_SEL_CTRL2	: OUT	STD_LOGIC;
			PC_OUT_CTRL3	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0)
		);

	end component;

	SIGNAL CLOCK 			: STD_LOGIC := '0';
	SIGNAL RESETN			: STD_LOGIC := '0';
	SIGNAL ENABLE			: STD_LOGIC := '0';
	SIGNAL SRC0_SEL_CTRL1 	: STD_LOGIC := '0';
	SIGNAL SRC1_SEL_CTRL2	: STD_LOGIC := '0';
	SIGNAL SRC2_SEL_CTRL2	: STD_LOGIC := '0';
	SIGNAL SR_SEL_CTRL1		: STD_LOGIC_VECTOR(1 DOWNTO 0):= (others => '0');
	SIGNAL SRC1_SEL_CTRL1	: STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
	SIGNAL SRC2_SEL_CTRL1	: STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
	SIGNAL SIGN				: STD_LOGIC_VECTOR(15 DOWNTO 0):= (others => '0');
	SIGNAL IMMED			: STD_LOGIC_VECTOR(11 DOWNTO 0):= (others => '0');
	SIGNAL INSTRUCTION		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0):= (others => '0');
	SIGNAL PC				: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0):= (others => '0');
	SIGNAL PC_OUT_CTRL3		: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0):= (others => '0');

	constant period : time := 10 ns;

begin

	UUT_control_toplevel: control_toplevel PORT MAP (
		Clock				=> CLOCK,
		RESETN				=> RESETN,
		ENABLE				=> ENABLE,
		SRC0_SEL_CTRL1		=> SRC0_SEL_CTRL1,
		SRC1_SEL_CTRL2		=> SRC1_SEL_CTRL2,
		SRC2_SEL_CTRL2		=> SRC2_SEL_CTRL2,
		SR_SEL_CTRL1		=> SR_SEL_CTRL1,
		SRC1_SEL_CTRL1		=> SRC1_SEL_CTRL1,
		SRC2_SEL_CTRL1		=> SRC2_SEL_CTRL1,
		SIGN				=> SIGN,
		IMMED				=> IMMED,
		INSTRUCTION			=> INSTRUCTION,
		PC					=> PC,
		PC_OUT_CTRL3		=> PC_OUT_CTRL3
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
--PC 0
		INSTRUCTION <= X"000000";
		PC			<= "0000000000";

		RESETN <= '1'; -- Clear the reset for init
		ENABLE <= '1'; -- Enable the control_toplevel for init
		
		wait for 2*period;
--PC 1

		INSTRUCTION <= X"010000";
		PC			<= "0000000001";
		
		wait for 2*period;
--PC 2

		INSTRUCTION <= X"110000";
		PC			<= "0000000010";
		
		wait for 2*period;
--PC 3

		INSTRUCTION <= X"210000";
		PC			<= "0000000011";
		
		wait for 2*period;
--PC 4

		INSTRUCTION <= X"310000";
		PC			<= "0000000100";
		
		wait for 2*period;
--PC 5

		INSTRUCTION <= X"410000";
		PC			<= "0000000101";
		
		wait for 2*period;
--PC 6

		INSTRUCTION <= X"512345";
		PC			<= "0000000110";
		
		wait for 2*period;
--PC 7

		INSTRUCTION <= X"612345";
		PC			<= "0000000111";
		
		wait for 2*period;
--PC 8

		INSTRUCTION <= X"712345";
		PC			<= "0000001000";
		
		wait for 2*period;
--PC 9

		INSTRUCTION <= X"854321";
		PC			<= "0000001001";
		
		wait for 2*period;
--PC 10

		INSTRUCTION <= X"912345";
		PC			<= "0000001010";

		
	end process;

end Behavioral;


