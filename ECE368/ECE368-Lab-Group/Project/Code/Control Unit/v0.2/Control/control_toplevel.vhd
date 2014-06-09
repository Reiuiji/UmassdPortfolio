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
			
			--CTRL2
			SRC1_SEL_CTRL2 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- SRC1_SEL:  0-REGA 1- SR 
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
			

				
				
			
			--NEED to IMPLEMENT INTO
			PC_SEL			: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			InstrAdr_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			INST_MEM_WE		: OUT STD_LOGIC;
			
			
			EXTM_DIN_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
			EXTM_ADDR_SEL		: OUT STD_LOGIC;
			EXTM_RW 				: OUT STD_LOGIC; 
			

			--CTL4

			--CTL5
			INST_WD				: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0)
		);
	
end control_toplevel;

architecture Structural of control_toplevel is 
	signal CTL1_input	: STD_LOGIC_VECTOR (11 downto 0) := (OTHERS => '0'); 
	
	signal OPCODE   : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');  		
	signal SRC1		 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
	signal SRC2		 : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0'); 
	signal DST		 : STD_LOGIC_VECTOR(11 DOWNTO 0) := (OTHERS => '0'); 
	
	--INTSTRUCTION FLOW 
	signal T2_output   : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 
	signal T3_output   : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 
	signal T4_output   : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 
	signal CTRL2_output   : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 
	signal CTRL3_output   : STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 

	signal temp1,temp2 :STD_LOGIC_VECTOR(23 DOWNTO 0) := (OTHERS => '0'); 

	
	--STACK FILE
	signal Stack_Enable : STD_LOGIC:= '0' ;		-- 1-JUMP,RTL  0 - else
	signal 		pushPop : STD_LOGIC:= '1'; 		--pushPop: 1- pop , 0- push 
	
	--program counter
	signal PC_1, PC_2, PC_3 : STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
	signal PC_SEL0 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	signal INST_SEL0 : STD_LOGIC_VECTOR(1 DOWNTO 0) := "00";
	
begin
	PC_OUT_CTRL3 <= PC_3;
	PC_SEL <= PC_SEL0;
	InstrAdr_SEL <= INST_SEL0;
	temp1 <= CTL1_input(11 downto 0 )&IMMED(11 downto 0);
	temp2 <= OPCODE(3 downto 0) & SRC1(3 downto 0)&SRC2(3 downto 0)& DST(11 downto 0);

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
				SRC2_SEL	 => SRC2_SEL_CTRL2,
				Stack_Enable =>  Stack_Enable,				
				pushPop =>  pushPop, 	
				ALU_SEL => ALU_SEL,
				OUTPUT  => CTRL2_output
				
				);
				
	StackFile: entity work.stackFile
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				ENABLEP 	 => Stack_Enable,    		
				pushPop	 => pushPop,
			
				INPUT		=> PC_3,
				OUTPUT => PC_STACK
 				);
	
	T3_regModule: entity work.T2_Reg
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => CTRL2_output,    		
				OUTPUT	 => T3_output
				);
				
	CTRL3Module: entity work.CTRL3_Reg_Falling
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => T3_output,    		
				DATA_DIN_SEL => DATA_DIN_SEL,	
				DATA_ADDR_SEL => DATA_ADDR_SEL,
				DATA_RW => DATA_RW, 			 
				DST_MUX_SEL => DST_MUX_SEL,
				OUTPUT => 	CTRL3_output
				);
	
	T4_regModule: entity work.T2_Reg
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 	=> ENABLE,
				INPUT 	 => CTRL3_output,    		
				OUTPUT	 => T4_output
				);
				
				
	CTRL4Module: entity work.CTRL4_Reg_Falling
	port map(CLOCK 	=> CLOCK,				
				RESETN		=> RESETN,							
				ENABLE 		=> ENABLE,
				INPUT 		=> T4_output,    		
				GP_DIN_SEL	=> GP_DIN_SEL,
				GP_WE 		=> GP_WE,
				SR_DIN_SEL  => SR_DIN_SEL,
				SR_WE 		=> SR_WE
				);
	----- End Structural Components -----
	
	
end Structural;


