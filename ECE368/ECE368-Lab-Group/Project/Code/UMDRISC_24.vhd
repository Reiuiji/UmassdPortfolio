------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    UMDRISC_24
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was built upon Dr.Fortier RISC Diagram
--      UMDRISC_24 component structure
--
-- Notes:
--      [Insert Notes]
--
-- Revision: 
--      0.01  - File Created
--      0.02  - [Insert]
--
-- Additional Comments: 
--      [Insert Comments]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
USE work.UMDRISC_pkg.ALL;

entity UMDRISC_24 is
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
		PC_OUT	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0)
		
	);
end UMDRISC_24;

architecture Structural of UMDRISC_24 is

---------- FPU ---------- ---------- ----------
component FPU is
	PORT (
		CLOCK 			: in STD_LOGIC;
		RESETN			: in STD_LOGIC;
		ENABLE			: in STD_LOGIC;
		IMMED 			: IN STD_LOGIC_VECTOR(DATA_WIDTH-13 DOWNTO 0); --[11:0] 12 bits
		SIGNED_IMMED	: IN STD_LOGIC_VECTOR(DATA_WIDTH-9 DOWNTO 0); --[15:0] 16 bits
		REG_DATA_IN		: in STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); -- Register Data input for general and shadow reg
		SRC1			: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- General purpose Reg A Address
		SRC2			: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- General purpose Reg B Address
		GP_DIN_SEL		: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- Reg Address to write to
		GP_WE			: in STD_LOGIC; -- write enable for general purpose register
		SR_SEL 			: in STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register Select
		SR_DIN_SEL		: in STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register to write to
		SR_WE			: in STD_LOGIC; -- write enable for shadow register
		SRC0_SEL		: in STD_LOGIC; -- Select between immed and signed extension
		SRC1_MUX		: in STD_LOGIC_VECTOR(1 DOWNTO 0); -- Select between PC, RA, SR, DST_ADDR (4 select)
		SRC2_MUX		: in STD_LOGIC; -- Select between immed or Reg B (2 select)
		ALU_OPCODE		: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- OPCODE for the ALU
		NVZC_MASK		: in STD_LOGIC_VECTOR(3 DOWNTO 0); -- Mash comparison
		
		--PC				: IN STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); --Program Counter
		STORE_DATA		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); --Destination Data
		DST_ADDR		: OUT STD_LOGIC_VECTOR(MEM_WIDTH-1 DOWNTO 0); --Destination Address
		ALU_OUT			: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		LDST_OUT			: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); -- output the load / store on the ALU 
		CCR				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --Condition Code Register (ALU)
		NVZC_COMPARE	: OUT STD_LOGIC -- bit compare of the ALU output

	);
end component;

---------- CONTROL ------ ---------- ----------
component control_toplevel IS
	PORT (
			CLOCK:  in	STD_LOGIC;
			RESETN:  in	STD_LOGIC;
			ENABLE: in	STD_LOGIC;
			--INST_WE : in STD_LOGIC; --write enable to instruction memory
			--ADDR_IN : in std_logic_vector(INST_ADDR_WIDTH-1 downto 0); --input to instruction memory
			--D_IN    : in std_logic_vector(DATA_WIDTH-1 downto 0); --input to instruction memory
			INSTRUCTION : in STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); -- 24 bit instruction input
			PC				: in STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); -- program counter input
			NVZC_COMPARE	: in STD_LOGIC;   -- from the 4 bit comparotor to compare the branch
		   SR_SEL_CTRL1   :OUT STD_LOGIC_VECTOR(1 DOWNTO 0);     --OUTPUT CTRL1
			SRC0_SEL_CTRL1 : OUT STD_LOGIC;  			      --OUTPUT CTRL1
		   SRC1_SEL_CTRL1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 	--OUTPUT CTRL1
			SRC2_SEL_CTRL1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 	--OUTPUT CTRL1
			SIGN				: OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);	--OUTPUT T1
			IMMED				: BUFFER	STD_LOGIC_VECTOR(11 DOWNTO 0);	--OUTPUT T1
			NVZC_MASK   	: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- compare to ALU
		   	
			--CTRL2

			SRC1_SEL_CTRL2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); 					-- SRC1_SEL:  0-REGA 1- SR 
			SRC2_SEL_CTRL2 : OUT STD_LOGIC;  				-- SRC2_SEL:  0- I format 1 R format
			
			ALU_SEL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			
			--STACK_FILE 
			PC_STACK : OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			
			--CTRL3 
			PC_OUT_CTRL3	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			DATA_DIN_SEL		: OUT STD_LOGIC;		--	DATA_DIN_SEL  : 0- DST_DATA   : 1001, 1011 & ID = 01 
																--						 1- STORE_DATA : 1010
			DATA_ADDR_SEL		: OUT STD_LOGIC;		--DATA_ADDR_SEL  : 0- DST_ADDR 1011 & (ID = 10 OR 01) 
																-- 					 1- ALU_SEL  1100 & (ID = 10 OR 01)
			DATA_RW 				: OUT STD_LOGIC; 		--DATA_RW		  : 0- Read : else
																--						 1- Write : 1010 OR (1011 and ID= 01) 
			DST_MUX_SEL			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);		-- DST_MUX_SEL: 00- ALU: ELSE
																						--					 01- Data Mem  1100 & ID= 01
																						--					 10- Ecternal Mem		1011 & ID=00, 1011 & ID= 10,01
			--CTRL4
			GP_DIN_SEL		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Reg Address to write to
			GP_WE				: OUT STD_LOGIC; -- write enable for general purpose register
			SR_DIN_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register to write to
			SR_WE				: OUT STD_LOGIC; -- write enable for shadow register
			

				
				--Program Counter
		   PC_SEL			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			PC_CTRL : OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	
			
			--NEED to IMPLEMENT INTO	
			InstrAdr_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			INST_MEM_WE		: OUT STD_LOGIC;
			
			
			EXTM_DIN_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			EXTM_ADDR_SEL		: OUT STD_LOGIC;
			EXTM_RW 				: OUT STD_LOGIC; 
			

			--CTL4

			--CTL5
			INST_WD				: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
		);
end component;

---------- Program Counter --------- ----------
component PC is
	Port (
		CLOCK				: in	STD_LOGIC;
		RESETN			: in	STD_LOGIC;
		ENABLE			: in	STD_LOGIC;
		
		--input Data to Program counter
		PC_IN				: in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- Change PC to what is on this signal
		PC_FROM_STACK	: in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- change PC from what was on the stack
		PC_SEL			: in STD_LOGIC_VECTOR (1 downto 0); -- Selector to chose what the PC will be
		PC_FROM_CRTL2  : in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- change PC from the control2 due to branch 
	
		PC_OUT		: out	STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0) -- output of current Program counter
	);
	end component;

---------- DATA / EXTERNAL MEMORY CONTROLER ---
component  DATA_EXT_MEM is
	Port (
		CLOCK			: in	STD_LOGIC;
		RESETN			: in	STD_LOGIC;
		ENABLE			: in	STD_LOGIC;
		
		--input Data to Data / External Memory
		STORE_DATA		: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- Store Data input
		ALU_IN	     	: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- Alu Input
		DST_ADDR		: in STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0); -- Destination address input
		LDST_IN			: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- load/store 
		INST_WD 		: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- load/store 

        --External Access
        EX_IN           : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        EX_OUT          : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

        --CONTROL SIGNALS
		-- DATA MEMORY
        DATA_DIN_SEL	: in	STD_LOGIC; -- select data for data mem . 0: DST_DATA, 1: Store data
        DATA_ADDR_SEL	: in	STD_LOGIC; -- select address for data mem . 0: DST_ADDR, 1: ALU_IN
		DATA_RW			: in	STD_LOGIC; -- write to the data memory block
		--EXTERNAL MEMORY
		EXTM_DIN_SEL	: in	STD_LOGIC_VECTOR (1 downto 0); -- 3 mux. 0: LDST, 1: INSTWD, 2: EX_IN
		EXTM_ADDR_SEL	: in	STD_LOGIC;
		EXTM_RW			: in	STD_LOGIC; -- Write to the external memory block
		--Destination data
		DST_MUX_SEL		: in	STD_LOGIC_VECTOR (1 downto 0); -- 3 mux. 0: ALU_IN, 1: DATA_MEM, 2: EXT_MEM

		--OUTPUT
		DST_DATA_OUT		: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- of destination data
		DST_ADDR_OUT		: out STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0) -- of destination Address
	);
end component;


---------- Instruction Memory ------ ----------
component INST_MEMORY is
	port(
		CLOCK			: in std_logic;
		WE				: in std_logic;
		--RESETN			: in std_logic;
        --OUTPUT RAM
		OUT_ADDR		: in std_logic_vector(INST_WIDTH-1 downto 0);
		OUT_DATA		: out std_logic_vector(DATA_WIDTH-1 downto 0);
		--INPUT RAM
		IN_ADDR		    : in std_logic_vector(INST_WIDTH-1 downto 0);
		IN_DATA			: in std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end component;


---------- PC MUX to INST MEMORY --- ----------
component PC_MUX_3to1 is

	Port (
		SEL		: in   STD_LOGIC_VECTOR (1 downto 0); -- 3 bits
		IN_1	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		IN_2	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		IN_3	: in   STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
		OUTPUT	: out  STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0)
	);

end component;




---------- SIGNALS ------ ---------- ----------
	SIGNAL	INSTRUCTION		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); --Instruction value form memory
	SIGNAL	IMMED 			: STD_LOGIC_VECTOR(DATA_WIDTH-13 DOWNTO 0); --[11:0] 12 bits
	SIGNAL	SIGNED_IMMED	: STD_LOGIC_VECTOR(DATA_WIDTH-9 DOWNTO 0); --[15:0] 16 bits
	SIGNAL	SRC1			: STD_LOGIC_VECTOR(3 DOWNTO 0); -- General purpose Reg A Address
	SIGNAL	SRC2			: STD_LOGIC_VECTOR(3 DOWNTO 0); -- General purpose Reg B Address
	SIGNAL	GP_DIN_SEL		: STD_LOGIC_VECTOR(3 DOWNTO 0); -- Reg Address to write to
	SIGNAL	GP_WE			: STD_LOGIC; -- write enable for general purpose register
	SIGNAL	SR_SEL 			: STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register Select
	SIGNAL	SR_DIN_SEL		: STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register to write to
	SIGNAL	SR_WE			: STD_LOGIC; -- write enable for shadow register
	SIGNAL	SRC0_SEL		: STD_LOGIC; -- Select between immed and signed extension
	SIGNAL	SRC1_MUX		: STD_LOGIC_VECTOR(1 DOWNTO 0); -- Select between PC, RA, SR, DST_ADDR (4 select)
	SIGNAL	SRC2_MUX		: STD_LOGIC; -- Select between immed or Reg B (2 select)
	SIGNAL	NVZC_MASK	: STD_LOGIC_VECTOR(3 DOWNTO 0);	-- NVZC MASK COMPARE
	SIGNAL	ALU_OPCODE		: STD_LOGIC_VECTOR(3 DOWNTO 0); -- OPCODE for the ALU
	SIGNAL	PC0				: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); --Program Counter
	SIGNAL	PC_FROM_STACK	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); --Stack to PC
	SIGNAL	PC_FROM_CRTL2	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); --Stack to PC
	SIGNAL	PC_SEL			: STD_LOGIC_VECTOR(1 DOWNTO 0); --PC select 0: PC, 1: FPU, 2: STACK
	SIGNAL	PC_ctrl3			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); --Stack to PC
	SIGNAL	PC_INST_ADDR	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); -- Instruction memory PC
	SIGNAL	DEBUG_PC			: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); -- Instruction address from debug utility
	SIGNAL	InstrAdr_SEL		: STD_LOGIC_VECTOR(1 DOWNTO 0); --Instruction address select
	SIGNAL	INST_MEM_WE		: STD_LOGIC; -- Write enable to the instruction memory
	SIGNAL	INST_IN_ADDR	: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); -- Instruction memory Address to write to

	SIGNAL	STORE_DATA	: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); 
	SIGNAL	LDST_OUT		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL	ALU_OUT		:STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
	SIGNAL	CCR			: STD_LOGIC_VECTOR(3 DOWNTO 0); --Condition Code Register (ALU)
	SIGNAL	NVZC_COMPARE: STD_LOGIC;

	SIGNAL	DST_ADDR		: STD_LOGIC_VECTOR(MEM_WIDTH-1 DOWNTO 0); -- Instruction address from dst memory
	SIGNAL	DST_ADDR_OUT: STD_LOGIC_VECTOR(MEM_WIDTH-1 DOWNTO 0); -- Instruction memory data to write to
	SIGNAL	DST_DATA_OUT: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); -- Instruction address from dst memory
	SIGNAL	DST_DATA		: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); -- Instruction memory data to write to
	
	
	SIGNAL	DATA_DIN_SEL		: STD_LOGIC;
	SIGNAL	DATA_ADDR_SEL		: STD_LOGIC;
	SIGNAL	DATA_RW 				: STD_LOGIC; 
	SIGNAL	EXTM_DIN_SEL		: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL	EXTM_ADDR_SEL		: STD_LOGIC;
	SIGNAL	EXTM_RW 				: STD_LOGIC; 
	SIGNAL	DST_MUX_SEL			: STD_LOGIC_VECTOR(1 DOWNTO 0);
	SIGNAL	INST_WD				: STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);

	--SIGNAL	PC_OUT_CTRL3: STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); --Program Counter
	--SIGNAL	INSTRUCTION : STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);

begin

STORE_DATA0		<= STORE_DATA;
DST_ADDR0		<= DST_ADDR;
ALU_OUT0			<= ALU_OUT;
LDST_OUT0		<= LDST_OUT;
CCR0				<= CCR;
PC_OUT <= PC0;

U_FPU: FPU PORT MAP (
	Clock					=> CLOCK,
	RESETN				=> RESETN,
	ENABLE				=> ENABLE,
	IMMED					=> IMMED,
	SIGNED_IMMED		=> SIGNED_IMMED,
	REG_DATA_IN			=> DST_DATA_OUT,
	SRC1					=> SRC1,
	SRC2					=> SRC2,
	GP_DIN_SEL			=> GP_DIN_SEL,
	GP_WE					=> GP_WE,
	SR_SEL				=> SR_SEL,
	SR_DIN_SEL			=> SR_DIN_SEL,
	SR_WE					=> SR_WE,
	SRC0_SEL				=> SRC0_SEL,
	SRC1_MUX				=> SRC1_MUX,
	SRC2_MUX				=> SRC2_MUX,
	ALU_OPCODE			=> ALU_OPCODE,
	NVZC_MASK			=> NVZC_MASK,
	STORE_DATA			=> STORE_DATA,
	DST_ADDR				=> DST_ADDR,
	ALU_OUT				=> ALU_OUT,
	LDST_OUT				=> LDST_OUT,
	CCR					=> CCR,
	NVZC_COMPARE		=> NVZC_COMPARE
);

U_CONTROL: control_toplevel PORT MAP (
	Clock				=> CLOCK,
	RESETN				=> RESETN,
	ENABLE				=> ENABLE,
	INSTRUCTION			=> INSTRUCTION,
	PC					=> PC0,
	NVZC_COMPARE	=> NVZC_COMPARE,
	--CTL1
	SR_SEL_CTRL1		=> SR_SEL,
	SRC0_SEL_CTRL1		=> SRC0_SEL,
	SRC1_SEL_CTRL1		=> SRC1,
	SRC2_SEL_CTRL1		=> SRC2,
	SIGN				=> SIGNED_IMMED,
	IMMED				=> IMMED,
	NVZC_MASK   => NVZC_MASK, 
	--CTL2
	SRC1_SEL_CTRL2		=> SRC1_MUX,
	SRC2_SEL_CTRL2		=> SRC2_MUX,
	PC_CTRL   			=>PC_FROM_CRTL2,
	PC_SEL 				=> PC_SEL,
	--CTL3
	PC_OUT_CTRL3		=> PC_ctrl3,
		
	InstrAdr_SEL			=>	InstrAdr_SEL,
	INST_MEM_WE			=>	INST_MEM_WE,
	
	DATA_DIN_SEL		=> DATA_DIN_SEL,
	DATA_ADDR_SEL		=> DATA_ADDR_SEL,
	DATA_RW				=> DATA_RW,
	EXTM_DIN_SEL		=> EXTM_DIN_SEL,
	EXTM_ADDR_SEL		=> EXTM_ADDR_SEL,
	EXTM_RW				=> EXTM_RW,
	DST_MUX_SEL			=> DST_MUX_SEL,
	ALU_SEL				=> ALU_OPCODE,
	GP_DIN_SEL			=> GP_DIN_SEL,
	SR_DIN_SEL			=> SR_DIN_SEL,
	GP_WE					=> GP_WE,
	SR_WE					=> SR_WE,

	--CTL4

	--CTL5
	INST_WD			=> INST_WD,
	
	PC_STACK			=> PC_FROM_STACK

);

U_DATA_EXT_MEM: DATA_EXT_MEM PORT MAP (
	CLOCK			=> CLOCK,
	RESETN			=> RESETN,
	ENABLE			=> ENABLE,
	STORE_DATA		=> STORE_DATA,	--FPU
	ALU_IN			=> ALU_OUT,		--FPU
	DST_ADDR		=> DST_ADDR,	--FPU
	LDST_IN			=> LDST_OUT,	--FPU
	INST_WD			=> INST_WD,		--CTRL
	EX_IN			=> EX_IN,		--RISC
	EX_OUT			=> EX_OUT,		--RISC
	DATA_DIN_SEL	=> DATA_DIN_SEL,--CTRL
	DATA_ADDR_SEL	=> DATA_ADDR_SEL,--CTRL
	DATA_RW			=> DATA_RW,		--CTRL
	EXTM_DIN_SEL	=> EXTM_DIN_SEL,--CTRL
	EXTM_ADDR_SEL	=> EXTM_ADDR_SEL,--CTRL
	EXTM_RW			=> EXTM_RW,		--CTRL
	DST_MUX_SEL		=> DST_MUX_SEL,	--CTRL
	DST_DATA_OUT	=> DST_DATA_OUT,	--OUT
	DST_ADDR_OUT	=> DST_ADDR_OUT 	--OUT
);

U_PC: PC PORT MAP (
	CLOCK				=> CLOCK,
	RESETN				=> RESETN,
	ENABLE				=> ENABLE,
	PC_IN				=> ALU_OUT(PC_WIDTH-1 downto 0),
	PC_FROM_STACK		=> PC_FROM_STACK,
	PC_FROM_CRTL2		=> PC_FROM_CRTL2,
	PC_SEL				=> PC_SEL,
	PC_OUT				=> PC0
);


U_INST_MEM: INST_MEMORY PORT MAP (
	CLOCK					=> CLOCK,
	WE						=> INST_MEM_WE,
	OUT_ADDR				=> PC_INST_ADDR,
	OUT_DATA				=> INSTRUCTION,
	IN_ADDR				=> DST_ADDR,
	IN_DATA				=> DST_DATA_OUT
);

U_InstrAdr: PC_MUX_3to1 PORT MAP (
	SEL					=> InstrAdr_SEL,
	IN_1					=> PC0,
	IN_2					=> DST_ADDR_OUT,
	IN_3					=> DEBUG_PC,
	OUTPUT				=> PC_INST_ADDR
);

end Structural;

