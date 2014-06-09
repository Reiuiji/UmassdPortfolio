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

ENTITY CTRL4_Reg_Falling IS

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT		: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		GP_DIN_SEL		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Reg Address to write to
		GP_WE				: OUT STD_LOGIC; -- write enable for general purpose register
		SR_DIN_SEL		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0); -- Shadow Register to write to
		SR_WE				: OUT STD_LOGIC  -- write enable for shadow register
	);

END CTRL4_Reg_Falling;

ARCHITECTURE Behavior OF CTRL4_Reg_Falling IS	
		signal OPCODE : std_logic_vector(3 downto 0) := "0000";
		signal ID : std_logic_vector(1 downto 0) := "00";
		signal REGA : std_logic_vector(3 downto 0) := "0000";
		signal REGS : std_logic_vector(1 downto 0) := "00";
BEGIN
	OPCODE <= INPUT(23 downto 20);
	ID <= INPUT(13 downto 12);
	REGA <= INPUT(19 downto 16);
	REGS <= INPUT(15 downto 14);
	
	PROCESS(Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
			GP_DIN_SEL <="0000";	
			GP_WE		  <= '0';	
			SR_DIN_SEL <="00"; 
			SR_WE		  <= '0';	

			
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
				
				SR_DIN_SEL <= REGS ; 
				GP_DIN_SEL <= REGA ; 
	
				-- SR_WE:  0-else 1-SR wb
				if (OPCODE = "1011" AND (ID = "11") ) then -- Shadow Register
					SR_WE <= '1';
				else 
					SR_WE <= '0';	
				end if;
				
				-- GP_WE:  0-else 1-rega wb
				if (OPCODE >= "0000" AND OPCODE <= "1011" ) then -- general purpose Register
					GP_WE <= '1';
				else 
					GP_WE <= '0';
				end if;
				
			END IF;
		END IF;
	END PROCESS;
END Behavior;
