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
--
-- Notes:
--      T1 Register: Stetting the out based on abd output, Clocked on RISING EDGE
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Cleaned up Code given
--      0.03  - Incorporated a enable switch
--      0.04  - Have the register latch data on the rising 
--              clock cycle.
--      0.05  - Modified based the properties for register T1
--
-- Additional Comments: 
--      The register latches it's data on the RISING edge
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

ENTITY T1_Reg IS

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT	: IN	STD_LOGIC_VECTOR(23 DOWNTO 0);
		CTL1	: OUT 	STD_LOGIC_VECTOR(11 DOWNTO 0);
		IMMED	: BUFFER	STD_LOGIC_VECTOR(11 DOWNTO 0);
		SIGN	: OUT	STD_LOGIC_VECTOR(15 DOWNTO 0)
		 
	);

END T1_Reg;

ARCHITECTURE Behavior OF T1_Reg IS	

BEGIN

	PROCESS(Resetn, Clock,ENABLE)
	BEGIN
		IF Resetn = '0' THEN
			CTL1 <= (OTHERS => '0');
			IMMED <= (OTHERS => '0');
			SIGN <= (OTHERS => '0');
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '1' THEN
				CTL1 <= INPUT(23 downto 12);
				IMMED <= INPUT(11 downto 0);
				SIGN <= INPUT(15 downto 0);
			END IF;
		END IF;
	END PROCESS;

END Behavior;
