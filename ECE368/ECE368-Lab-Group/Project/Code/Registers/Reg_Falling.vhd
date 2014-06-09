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

ENTITY RegF IS

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT	: IN	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		OUTPUT	: OUT 	STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0) 
	);

END RegF;

ARCHITECTURE Behavior OF RegF IS	

BEGIN

	PROCESS(Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
			OUTPUT <= (OTHERS => '0');
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
				OUTPUT <= INPUT;
			END IF;
		END IF;
	END PROCESS;

END Behavior;
