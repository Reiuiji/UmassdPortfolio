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
--
-- Additional Comments: 
--      The register latches it's data on the FALLING edge
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

ENTITY CTRL1_Reg_Falling IS

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT		: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		SR_SEL 	: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		SRC0_SEL : OUT STD_LOGIC;
		SRC1_SEL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SRC2_SEL : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		OPCODE   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); 		
		SRC1		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		SRC2		: OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		DST		: OUT STD_LOGIC_VECTOR(11 DOWNTO 0)
	);

END CTRL1_Reg_Falling;

ARCHITECTURE Behavior OF CTRL1_Reg_Falling IS	


BEGIN

	PROCESS(Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
			SR_SEL 	<= (OTHERS => '0');
			SRC0_SEL <= '0';
			SRC1_SEL <= (OTHERS => '0');
			SRC2_SEL <= (OTHERS => '0');
			OPCODE   <= (OTHERS => '0'); 		
			SRC1		<= (OTHERS => '0');
			SRC2		<= (OTHERS => '0');
			DST 		<= (OTHERS => '0');
		
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
				SR_SEL 	<= INPUT(15 downto 14);
				SRC1_SEL <= INPUT(19 downto 16);
				SRC2_SEL <= INPUT(15 downto 12);
				
				OPCODE   <= INPUT(23 downto 20); 		
				SRC1		<= INPUT(19 downto 16);
				SRC2		<= INPUT(15 downto 12);
				DST 		<= INPUT(11 downto 0);
	
				if (INPUT(23 downto 20) = "1101" OR INPUT(23 downto 20) = "1111") then 
					SRC0_SEL <= '1';
				else 
					SRC0_SEL <= '0';
				end if;
			
			END IF;
		END IF;
	END PROCESS;

END Behavior;
