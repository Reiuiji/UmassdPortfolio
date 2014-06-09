------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    Mem32Byte
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      [Description]
--
-- Notes:
--      [Insert Notes]
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Seperated the program counter and inst memeory
--              out of the control unit. easier to Debug.
--
-- Additional Comments: 
--      [Insert Comments]
-- 
-----------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;
USE work.UMDRISC_pkg.ALL;

entity control_toplevel is
    Port ( 
			CLOCK:  in	STD_LOGIC;
			RESETN:  in	STD_LOGIC;
			ENABLE: in	STD_LOGIC;
			--INST_WE : in STD_LOGIC; --write enable to instruction memory
			--ADDR_IN : in std_logic_vector(INST_ADDR_WIDTH-1 downto 0); --input to instruction memory
			--D_IN    : in std_logic_vector(DATA_WIDTH-1 downto 0); --input to instruction memory
			INSTRUCTION : in STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); -- 24 bit instruction input
			PC				: in STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0); -- program counter input

			SR_SEL_CTRL1   :OUT STD_LOGIC_VECTOR(1 DOWNTO 0);     --OUTPUT CTRL1
			SRC0_SEL_CTRL1 : OUT STD_LOGIC;  			      --OUTPUT CTRL1
		   SRC1_SEL_CTRL1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 	--OUTPUT CTRL1
			SRC2_SEL_CTRL1 : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 	--OUTPUT CTRL1
			SIGN				: OUT	STD_LOGIC_VECTOR(15 DOWNTO 0);	--OUTPUT T1
			IMMED				: BUFFER	STD_LOGIC_VECTOR(11 DOWNTO 0);	--OUTPUT T1
			SRC1_SEL_CTRL2 : OUT STD_LOGIC; 								--OUTPUT CTRL2
			SRC2_SEL_CTRL2 : OUT STD_LOGIC;  							--OUTPUT CTRL2
			--CTL 3
			PC_OUT_CTRL3	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
			
			
			--NEED to IMPLEMENT INTO
			PC_SEL			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			InstrAdr_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			INST_MEM_WE		: OUT STD_LOGIC;
			ALU_OPCODE		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
			GP_DIN_SEL		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Reg Address to write to
			GP_WE				: OUT STD_LOGIC; -- write enable for general purpose register
			SR_DIN_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register to write to
			SR_WE				: OUT STD_LOGIC; -- write enable for shadow register
			DATA_DIN_SEL		: OUT STD_LOGIC;
			DATA_ADDR_SEL		: OUT STD_LOGIC;
			DATA_RW 				: OUT STD_LOGIC; 
			EXTM_DIN_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			EXTM_ADDR_SEL		: OUT STD_LOGIC;
			EXTM_RW 				: OUT STD_LOGIC; 
			DST_MUX_SEL			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);


			--CTL4

			--CTL5
			INST_WD				: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
		);
	
end control_toplevel;

architecture Structural of control_toplevel is
	--signal PROGRAM_COUNTER	: STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0) := (OTHERS => '0'); 
	--signal instruction_memory	: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0'); 
	signal CTL1_input	: STD_LOGIC_VECTOR (11 downto 0) := (OTHERS => '0'); 
--	signal IMMED	: STD_LOGIC_VECTOR (11 downto 0) := (OTHERS => '0'); 
	
	signal OPCODE   : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  		
	signal SRC1		 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
	signal SRC2		 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
	signal DST		 : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0'); 
	
	signal T2_output   : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 
	signal temp1,temp2 :STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 
	--program counter
	signal PC_1, PC_2, PC_3 : STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	
	
begin
	PC_OUT_CTRL3 <= PC_3;
	temp1 <= CTL1_input(11 downto 0 )&IMMED(11 downto 0);
	temp2 <= OPCODE(3 downto 0) & SRC1(3 downto 0)&SRC2(3 downto 0)& DST(11 downto 0);
	----- Structural Components: -----
--	program_counterModule: entity work.counter
--	port map(CLOCK 	=> CLOCK,			   			
--				RESET	=> RESETN,							
--				ENABLE 	=> ENABLE,	
--				PROGRAM_COUNTER => PROGRAM_COUNTER
--				);
--	inst_memoryModule: entity work.INST_MEMORY
--	port map(CLOCK 	=> CLOCK,			   			
--				CLEAR		=> RESETN,							
--				WRITE_ENABLE 	=> ENABLE,	
--				ADDR_OUT => PROGRAM_COUNTER,
--				ADDR_IN 	=> ADDR_IN,
--				D_IN		=> D_IN,
--				D_OUT    => instruction_memory
--			   );
	PC_CTRL1: entity work.PC_RegHold_F
	PORT MAP(
			Clock 	=> CLOCK,
			Resetn 	=> RESETN,
			ENABLE 	=> ENABLE,
			INPUT 	=> PC,
			OUTPUT 	=> PC_1
				);
	PC_CTRL2: entity work.PC_RegHold_F
	PORT MAP(
			Clock 	=> CLOCK,
			Resetn 	=> RESETN,
			ENABLE 	=> ENABLE,
			INPUT 	=> PC_1,
			OUTPUT 	=> PC_2
				);
	PC_CTRL3: entity work.PC_RegHold_F
	PORT MAP(
			Clock 	=> CLOCK,
			Resetn 	=> RESETN,
			ENABLE 	=> ENABLE,
			INPUT 	=> PC_2,
			OUTPUT 	=> PC_3
				);
				
	T1_regModule: entity work.T1_Reg
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => INSTRUCTION, --instruction_memory,	
				CTL1		 => CTL1_input,
				IMMED		 => IMMED,
				SIGN		 => SIGN
				);
	CTRL1Module: entity work.CTRL1_Reg_Falling
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => temp1,	
				SR_SEL    => SR_SEL_CTRL1,
				SRC0_SEL  => SRC0_SEL_CTRL1, 
				SRC1_SEL  => SRC1_SEL_CTRL1,
				SRC2_SEL  => SRC2_SEL_CTRL1,
				OPCODE    => OPCODE,  		
				SRC1		 => SRC1,
				SRC2		 => SRC2,
				DST		 => DST
				);
	T2_regModule: entity work.T2_Reg
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => temp2,    		
				OUTPUT	 => T2_output
				);
	CTRL2Module: entity work.CTRL2_Reg_Falling
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => T2_output,    		
				SRC1_SEL	 => SRC1_SEL_CTRL2,
				SRC2_SEL	 => SRC2_SEL_CTRL2
				);
	----- End Structural Components -----
	
	
end Structural;


