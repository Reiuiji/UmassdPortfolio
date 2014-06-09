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
--      Removed the Debug utility,
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Reformat the File
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

entity VGA_TOPLEVEL is

	PORT (
		--Input
		CLOCK : in STD_LOGIC; -- 50 MHz
		RESET : in STD_LOGIC;
		PS2_CLOCK : in STD_LOGIC;
		PS2_DATA : in STD_LOGIC;
		
		LED : out STD_LOGIC_VECTOR(7 downto 0);
		--Output
		RED_VGA   : out STD_LOGIC;
		GREEN_VGA   : out STD_LOGIC;
		BLUE_VGA   : out STD_LOGIC;
		HORIZONTAL_SYNC  : out STD_LOGIC;
		VERTICAL_SYNC  : out STD_LOGIC
	);

end VGA_TOPLEVEL;

architecture Structural of VGA_TOPLEVEL is

signal ASCII   : STD_LOGIC_VECTOR(6 downto 0);
signal KEYCODE : STD_LOGIC_VECTOR(7 downto 0);
signal COMPLETE : STD_LOGIC;
signal WRITE_ENABLE : STD_LOGIC;


begin
LED(6 downto 0) <= ASCII;
LED(7) <= COMPLETE;
	-- Duel Memory RAM
	PS2_INPUT : entity work.PS2_Input_Controller
	PORT MAP (
		CLOCK     =>  CLOCK,
		RESET     =>  RESET,
		PS2_CLOCK =>  PS2_CLOCK,
		PS2_DATA  =>  PS2_DATA,
		ASCII     =>  ASCII,
		KEYCODE   =>  KEYCODE,
		COMPLETE  =>  COMPLETE,
		WRITE_ENABLE  =>  WRITE_ENABLE
	);  

	-- VGA Driver Unit
	VGA_DRIVER : entity work.VGA_Controller
	PORT MAP (
		CLOCK         =>  CLOCK,
		RESET         =>  RESET,
		ASCII         =>  ASCII,
		KEYCODE       =>  KEYCODE,
		VALID_KEY     =>  COMPLETE,
		WRITE_ENABLE  =>  WRITE_ENABLE,
		
		RED_VGA         =>  RED_VGA,
		GREEN_VGA        =>  GREEN_VGA ,
		BLUE_VGA         =>  BLUE_VGA,
		HORIZONTAL_SYNC  =>  HORIZONTAL_SYNC,
		VERTICAL_SYNC    =>  VERTICAL_SYNC
	);

end Structural;
