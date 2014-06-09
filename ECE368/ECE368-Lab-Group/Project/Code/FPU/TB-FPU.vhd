library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

entity TB_FPU is
end TB_FPU;

architecture Behavioral of TB_FPU is

	component FPU is

		PORT (
			CLOCK 			: in STD_LOGIC;
			RESETN			: in STD_LOGIC;
			ENABLE			: in STD_LOGIC;
			IMMED 			: IN STD_LOGIC_VECTOR(DATA_WIDTH-13 DOWNTO 0);
			SIGNED_IMMED	: IN STD_LOGIC_VECTOR(DATA_WIDTH-9 DOWNTO 0);
			REG_DATA_IN		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			SRC1			: in STD_LOGIC_VECTOR(3 DOWNTO 0);
			SRC2			: in STD_LOGIC_VECTOR(3 DOWNTO 0);
			GP_DIN_SEL		: in STD_LOGIC_VECTOR(3 DOWNTO 0);
			GP_WE			: in STD_LOGIC;
			SR_SEL 			: in STD_LOGIC_VECTOR(1 DOWNTO 0);
			SR_DIN_SEL		: in STD_LOGIC_VECTOR(1 DOWNTO 0);
			SR_WE			: in STD_LOGIC;
			SRC0_SEL		: in STD_LOGIC;
			SRC1_MUX		: in STD_LOGIC;
			SRC2_MUX		: in STD_LOGIC;
			ALU_OPCODE		: in STD_LOGIC_VECTOR(3 DOWNTO 0); 
			--PC				: IN STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			STORE_DATA		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			DST_ADDR		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			ALU_OUT			: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			LDST_OUT			: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
			CCR				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
		);

	end component;

	SIGNAL CLOCK 			: STD_LOGIC := '0';
	SIGNAL RESETN			: STD_LOGIC := '0';
	SIGNAL ENABLE			: STD_LOGIC := '0';
	SIGNAL IMMED 			: STD_LOGIC_VECTOR(DATA_WIDTH-13 DOWNTO 0):= (others => '0');
	SIGNAL SIGNED_IMMED		: STD_LOGIC_VECTOR(DATA_WIDTH-9 DOWNTO 0):= (others => '0');
	SIGNAL REG_DATA_IN		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0):= (others => '0');
	SIGNAL SRC1				: STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
	SIGNAL SRC2				: STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
	SIGNAL GP_DIN_SEL		: STD_LOGIC_VECTOR(3 DOWNTO 0):= (others => '0');
	SIGNAL GP_WE			: STD_LOGIC := '0';
	SIGNAL SR_SEL 			: STD_LOGIC_VECTOR(1 DOWNTO 0):= (others => '0');
	SIGNAL SR_DIN_SEL		: STD_LOGIC_VECTOR(1 DOWNTO 0):= (others => '0');
	SIGNAL SR_WE			: STD_LOGIC := '0';
	SIGNAL SRC0_SEL			: STD_LOGIC := '0';
	SIGNAL SRC1_MUX			: STD_LOGIC := '0';
	SIGNAL SRC2_MUX			: STD_LOGIC := '0';
	SIGNAL ALU_OPCODE		: STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0'); 
	SIGNAL PC				: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0) := (others => '0');
	SIGNAL STORE_DATA		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := (others => '0');
	SIGNAL DST_ADDR			: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := (others => '0');
	SIGNAL ALU_OUT			: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := (others => '0');
	SIGNAL LDST_OUT		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) := (others => '0');
	SIGNAL NZVC				: STD_LOGIC_VECTOR(3 DOWNTO 0) := (others => '0');

	constant period : time := 10 ns;

begin

	UUT_FPU: FPU PORT MAP (
		Clock				=> CLOCK,
		RESETN				=> RESETN,
		ENABLE				=> ENABLE,
		IMMED				=> IMMED,
		SIGNED_IMMED		=> SIGNED_IMMED,
		REG_DATA_IN			=> REG_DATA_IN,
		SRC1				=> SRC1,
		SRC2				=> SRC2,
		GP_DIN_SEL			=> GP_DIN_SEL,
		GP_WE				=> GP_WE,
		SR_SEL				=> SR_SEL,
		SR_DIN_SEL			=> SR_DIN_SEL,
		SR_WE				=> SR_WE,
		SRC0_SEL			=> SRC0_SEL,
		SRC1_MUX			=> SRC1_MUX,
		SRC2_MUX			=> SRC2_MUX,
		ALU_OPCODE			=> ALU_OPCODE,
		--PC					=> PC,
		STORE_DATA			=> STORE_DATA,
		DST_ADDR			=> DST_ADDR,
		ALU_OUT				=> ALU_OUT,
		LDST_OUT				=> LDST_OUT,
		CCR					=> NZVC
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
		--Cycle one on Control
		IMMED <= X"111";
		SIGNED_IMMED <= X"1111";
		SRC1 <= X"0"; -- Reg A pos 0
		SRC2 <= X"1"; -- Reg B location 1
		SRC0_SEL <= '0'; -- select immediate
		RESETN <= '1'; -- Clear the reset for init
		ENABLE <= '1'; -- Enable the FPU for init
		
		wait for 2*period; -- next segment
		--Cycle two on Control
		-- C 1
		IMMED <= X"222";
		SIGNED_IMMED <= X"2222";
		SRC1 <= X"1"; -- Reg A pos 1
		SRC2 <= X"0"; -- Reg B location 0
		SRC0_SEL <= '0'; -- select immediate
		-- C 2
		SRC1_MUX <= '0'; -- select immed compare to B
		SRC2_MUX <= '0'; -- select Reg A
		ALU_OPCODE <= "0101"; -- ALU operation ADDi
		GP_DIN_SEL <=X"1";
		REG_DATA_IN <= ALU_OUT;
		GP_WE <= '1';
		
		wait for 2*period; -- next segment
		GP_WE <= '0';
		--Cycle three on Control
		IMMED <= X"333";
		SIGNED_IMMED <= X"3333";
		SRC1 <= X"2"; -- Reg A pos 2
		SRC2 <= X"0"; -- Reg B location 0
		SRC0_SEL <= '0'; -- select immediate
		-- C 2
		SRC1_MUX <= '0'; -- select immed compare to B
		SRC2_MUX <= '0'; -- select Reg A
		ALU_OPCODE <= "0101"; -- ALU operation ADDi
		GP_DIN_SEL <=X"1";
		REG_DATA_IN <= ALU_OUT;
		GP_WE <= '1';
		
		wait for 2*period; -- next segment
		GP_WE <= '0';
		--Cycle four on Control
		IMMED <= X"000";
		SIGNED_IMMED <= X"0000";
		SRC1 <= X"0"; -- Reg A pos 2
		SRC2 <= X"1"; -- Reg B location 0
		SRC0_SEL <= '0'; -- select immediate
		-- C 2
		SRC1_MUX <= '1'; -- select Reg B
		SRC2_MUX <= '0'; -- select Reg A
		ALU_OPCODE <= "0000"; -- ALU operation ADD
		GP_DIN_SEL <=X"1";
		REG_DATA_IN <= ALU_OUT;
		GP_WE <= '1';
		
		wait for 2*period; -- next segment
		GP_WE <= '0';
		--Cycle five on Control
		IMMED <= X"000";
		SIGNED_IMMED <= X"0000";
		SRC1 <= X"0"; -- Reg A pos 2
		SRC2 <= X"1"; -- Reg B location 0
		SRC0_SEL <= '0'; -- select immediate
		-- C 2
		SRC1_MUX <= '0'; -- select immed
		SRC2_MUX <= '0'; -- select Reg A
		ALU_OPCODE <= "0000"; -- ALU operation ADD
		
	end process;

end Behavioral;


