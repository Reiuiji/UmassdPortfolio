library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

entity TB_UMDRISC_24 is
end TB_UMDRISC_24;

architecture Behavioral of TB_UMDRISC_24 is

	component UMDRISC_24 is
	PORT (
		--INPUT 
		CLOCK 			: in STD_LOGIC;
		RESETN			: in STD_LOGIC;
		ENABLE			: in STD_LOGIC;

		--OUTPUT
		STORE_DATA0		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); --Destination Data
		DST_ADDR0		: OUT STD_LOGIC_VECTOR(MEM_WIDTH-1 DOWNTO 0); --Destination Address
		ALU_OUT0		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		LDST_OUT0		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		CCR0				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --Condition Code Register (ALU)

		--External Memory
		EX_IN			: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		EX_OUT			: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

		--INSTRUCTION memory access
		--INST_WE : in STD_LOGIC; --write enable to instruction memory
		--ADDR_IN			: in	std_logic_vector(INST_ADDR_WIDTH-1 downto 0); --input to instruction memory
		--D_IN			: in	std_logic_vector(DATA_WIDTH-1 downto 0); --input to instruction memory

		--DEBUG lines
		--PC0	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0)
		PC_OUT	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0)
		
	);

	end component;

	SIGNAL CLOCK 		: STD_LOGIC := '0';
	SIGNAL RESETN		: STD_LOGIC := '0';
	SIGNAL ENABLE		: STD_LOGIC := '0';
	SIGNAL STORE_DATA	: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL DST_ADDR		: STD_LOGIC_VECTOR(MEM_WIDTH-1 DOWNTO 0);
	SIGNAL ALU_OUT		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL LDST_OUT		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL CCR			: STD_LOGIC_VECTOR(3 DOWNTO 0);
	SIGNAL INST_WE		: STD_LOGIC;
	SIGNAL ADDR_IN		: std_logic_vector(INST_ADDR_WIDTH-1 downto 0);
	SIGNAL D_IN			: std_logic_vector(DATA_WIDTH-1 downto 0);
	SIGNAL PC_OUT		: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);

	SIGNAL EX_IN		: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
	SIGNAL EX_OUT		: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

	constant period : time := 10 ns;

begin

	UUT_UMDRISC_24: UMDRISC_24 PORT MAP (
		Clock		=> CLOCK,
		RESETN		=> RESETN,
		ENABLE		=> ENABLE,
		STORE_DATA0	=> STORE_DATA,
		DST_ADDR0	=> DST_ADDR,
		ALU_OUT0		=> ALU_OUT,
		CCR0			=> CCR,
		LDST_OUT0	=> LDST_OUT,
		EX_IN			=> EX_IN,
		EX_OUT		=> EX_OUT,
		--INST_WE		=> INST_WE,
		--ADDR_IN		=> ADDR_IN,
		--D_IN		=> D_IN,
		PC_OUT		=> PC_OUT
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

		--Reset disable
		RESETN <= '1';

		--Write to the instruction memory
		--D_IN <= x"500008";
		--ADDR_IN <= "00000000";	wait for 2*period;
		--INST_WE <= '1'; wait for 2*period;

		--enable the CPU
		ENABLE <= '1';




	end process;

end Behavioral;


