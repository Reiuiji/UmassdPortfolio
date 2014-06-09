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
USE work.UMDRISC_pkg.ALL;

entity PC is
	Port (
		CLOCK				: in	STD_LOGIC;
		RESETN			: in	STD_LOGIC;
		ENABLE			: in	STD_LOGIC;
		
		--input Data to Program counter
		PC_IN				: in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- Change PC to what is on this signal
		PC_FROM_STACK	: in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- change PC from what was on the stack
		PC_FROM_CRTL2  : in STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- change PC from the control2 due to branch 
		PC_SEL			: in STD_LOGIC_VECTOR (1 downto 0); -- Selector to chose what the PC will be
		
		PC_OUT		: out	STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0) -- output of current Program counter
	);
end PC;

architecture Structural of PC is

signal PC_MUX		: STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
signal PC_1			: STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);
signal PC_Inc			: STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0); -- increment by 1 (+1)

begin
	PC_OUT <= PC_1;

	PC_REG: entity work.PC_RegHold_F
	PORT MAP(
			Clock 	=> CLOCK,
			Resetn 	=> RESETN,
			ENABLE 	=> ENABLE,
			INPUT 	=> PC_MUX,
			OUTPUT 	=> PC_1
				);
	PC_inc1: entity work.add_1
	PORT MAP(
			INPUT 	=> PC_1,
			OUTPUT 	=> PC_Inc
				);

	PC_MUX_U: entity work.PC_MUX_4to1
	PORT MAP(
			SEL 	=> PC_SEL,
			IN_1 	=> PC_Inc,
			IN_2 	=> PC_IN,
			IN_3 	=> PC_FROM_STACK,
			IN_4  => PC_FROM_CRTL2, 
			OUTPUT 	=> PC_MUX
				);

end Structural;
