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
--      Drives the various RGB colors
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity RGB_DRIVER is

    Port (
		RGB : in  STD_LOGIC_VECTOR (2 downto 0);
		MUX_IN : in  STD_LOGIC;
		VIDEO_ON : in std_logic;
		RED : out  STD_LOGIC;
		GREEN : out  STD_LOGIC;
		BLUE : out  STD_LOGIC
	);

end RGB_DRIVER;

architecture Behavioral of RGB_DRIVER is

begin

	RED   <='1' when VIDEO_ON='0' else MUX_IN;
	GREEN <='0' when VIDEO_ON='0' else MUX_IN;
	BLUE  <='1' when VIDEO_ON='0' else MUX_IN;

end Behavioral;
