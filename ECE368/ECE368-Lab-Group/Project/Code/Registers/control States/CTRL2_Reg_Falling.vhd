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
		SRC1_SEL : OUT STD_LOGIC;
		SRC2_SEL : OUT STD_LOGIC
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
			SRC1_SEL <= '0';
			SRC2_SEL <= '0';
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
			
				if (OPCODE = "0000" OR OPCODE = "0001" OR OPCODE = "0010" OR OPCODE = "00011" OR OPCODE = "0100") then 
					SRC2_SEL <= '1';
				else 
					SRC2_SEL <= '0';
				end if;
			
				if (OPCODE = "1011" AND (ID /= "11") ) then 
					SRC1_SEL <= '1';
				else 
					SRC1_SEL <= '0';
				end if;
			END IF;
		END IF;
	END PROCESS;
END Behavior;
