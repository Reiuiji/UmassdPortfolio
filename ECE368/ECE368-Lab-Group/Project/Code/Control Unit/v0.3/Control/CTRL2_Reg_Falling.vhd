------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    RegF
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Presenation Code: Dr.Fortier(c)
--      24 bit register
--
-- Notes:
--      Clock on FALLING EDGE
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Cleaned up Code given
--      0.03  - Incorporated a enable switch
--      0.04  - Have the register latch data on the falling 
--              clock cycle.
--      0.05  - Perform the functionality of the CRTL2
--
-- Additional Comments: 
--      The register latches it's data on the FALLING edge
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

ENTITY CTRL2_Reg_Falling IS

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT		: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		NVZC_COMPARE	: in STD_LOGIC;
		SRC1_SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		SRC2_SEL : OUT STD_LOGIC; 
		Stack_Enable : OUT STD_LOGIC;
		pushPop : OUT STD_LOGIC;
		ALU_SEL : out STD_LOGIC_VECTOR(3 DOWNTO 0);
		PC_New : OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
		PC_SEL : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		OUTPUT		: out  STD_LOGIC_VECTOR(23 DOWNTO 0)
	);

END CTRL2_Reg_Falling;

ARCHITECTURE Behavior OF CTRL2_Reg_Falling IS	
		signal OPCODE : std_logic_vector(3 downto 0) := "0000";
		signal ID : std_logic_vector(1 downto 0) := "00";
BEGIN
	OPCODE <= INPUT(23 downto 20);
	ID <= INPUT(13 downto 12);
	
	PROCESS(Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
			SRC1_SEL <= "00";
			SRC2_SEL <= '0';
			Stack_Enable <= '0';
			pushPop <= '0';
			ALU_SEL <="0000";
			OUTPUT <= x"000000";  		
	
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
				
				OUTPUT <=INPUT; 
				-- SRC2_SEL:  0- I format 1 R format
				if (OPCODE = "0000" OR OPCODE = "0001" OR OPCODE = "0010" OR OPCODE = "00011" OR OPCODE = "0100") then 
					SRC2_SEL <= '1';
				else 
					SRC2_SEL <= '0';
				end if;
				
				
				-- SRC1_SEL:  0-REGA 1- SR 2-Datat Hazard 3-Branch 
				if (OPCODE = "1011" AND (ID /= "11") ) then -- Shadow Register
					SRC1_SEL <= "01";			
				elsif (OPCODE = "1111" AND NVZC_COMPARE = '1') then -- Branch
					SRC1_SEL <= "11";			
				else	-- Operand1
						SRC1_SEL <= "00";
				end if;
				
				-- Stack_Enable : 1-JUMP,RTL  0 - else
				if (OPCODE = "1101" OR OPCODE = "1110" ) then -- JUMP, RTL
					Stack_Enable <= '1';			
				else	
						Stack_Enable <= '0';
				end if;
				
				--pushPop: 1- pop , 0- push 
				if OPCODE = "1110" then --pop: RTL
						pushPop <= '1';
						PC_Sel <=  "10";
 				elsif  OPCODE = "1101" then  --push: JUMP
						pushPop <= '0';
						PC_New <= INPUT(PC_WIDTH-1 DOWNTO 0);
						PC_SEL <= "11";
				elsif  (OPCODE = "1111" AND NVZC_COMPARE = '1') then  -- BRANCH
						PC_SEL <= "01";
				else 
						PC_SEL <= "00";
				end if;
				
				
				
				--ALU_SEL
				if (OPCODE = "1111" AND NVZC_COMPARE = '1') then --Branch
					ALU_SEL <= "0000";
				else 
					ALU_SEL <= OPCODE; 
				end if;
				
			END IF;
		END IF;
	END PROCESS;
END Behavior;
