-------------	-----------------------------------------------
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
--      0.05  - Perform the functionality of the CRTL3
--
-- Additional Comments: 
--      The register latches it's data on the FALLING edge
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

ENTITY CTRL3_Reg_Falling IS

	PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		INPUT		: IN STD_LOGIC_VECTOR(23 DOWNTO 0);
		DATA_DIN_SEL		: OUT STD_LOGIC;
		DATA_ADDR_SEL		: OUT STD_LOGIC;
		DATA_RW 				: OUT STD_LOGIC; 
		DST_MUX_SEL 		: OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
		OUTPUT 				: OUT STD_LOGIC_VECTOR(23 DOWNTO 0)
	);

END CTRL3_Reg_Falling;

ARCHITECTURE Behavior OF CTRL3_Reg_Falling IS	
		signal OPCODE : std_logic_vector(3 downto 0) := "0000";
		signal ID : std_logic_vector(1 downto 0) := "00";
BEGIN
	OPCODE <= INPUT(23 downto 20);
	ID <= INPUT(13 downto 12);
	PROCESS(Resetn, Clock)
	BEGIN
		IF Resetn = '0' THEN
		
			DATA_DIN_SEL <= '0';
			DATA_ADDR_SEL <= '0';
			DATA_RW 		<= '0';
			DST_MUX_SEL <= "00";		
			OUTPUT <= x"000000";  		
	
		ELSIF ENABLE = '1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
				OUTPUT <= INPUT;
				
				--DATA_ADDR_SEL  : 0- DST_ADDR 1011 & (ID = 10 OR 01) 
				-- 					 1- ALU_SEL  1100 & (ID = 10 OR 01)
				if ((OPCODE = "1011" AND ID ="01") OR (OPCODE = "1011" AND ID ="10")) then 
					DATA_ADDR_SEL <= '0';
				elsif ((OPCODE = "1100" AND ID ="01") OR (OPCODE = "1100" AND ID ="10")) then
					DATA_ADDR_SEL <= '1';
				else 
					DATA_ADDR_SEL <= '0';
				end if;
				
				
				--	DATA_DIN_SEL  : 0- DST_DATA   : 1001, 1011 & ID = 01 
				--						 1- STORE_DATA : 1010
				if (OPCODE = "1010") then 
					DATA_DIN_SEL <= '1';
				elsif (OPCODE = "1001" OR (OPCODE = "1011" AND ID= "01") ) then 
					DATA_DIN_SEL <= '1';
				else 
					DATA_DIN_SEL <= '0';
				end if;
				

				--DATA_RW: 0- Read : else
			   --			  1- Write : 1010 OR (1011 and ID= 01) 
 				if (OPCODE = "1010" OR (OPCODE = "1011" AND ID = "01") ) then 
					DATA_RW <= '1';
				else 
					DATA_RW <= '0';
				end if;

				
				-- DST_MUX_SEL: 00- ALU: ELSE
				--					 01- Data Mem  1100 & ID= 01
				--					 10- Ecternal Mem		1011 & ID=00, 1011 & ID= 10,01		
				if (OPCODE = "1100" AND ID = "01") then 
					DST_MUX_SEL <= "01";
				elsif ((OPCODE = "1011" AND ID = "00") OR (OPCODE = "1011" AND (ID = "01" OR ID = "01"))) then
					DST_MUX_SEL <= "10";
				else 
					DST_MUX_SEL <= "00";
				end if;
				
			END IF;
		END IF;
	END PROCESS;
END Behavior;
