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
--      INPUT: 50 MHz Clock
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
use work.all;

entity VGA_Controller is

	PORT (
		--Input
		CLOCK : in STD_LOGIC; -- 50 MHz
		RESET : in STD_LOGIC;
		--KeyBoard INPUT
		ASCII        : in STD_LOGIC_VECTOR (6 downto 0);
		KEYCODE      : in STD_LOGIC_VECTOR (7 downto 0);
		VALID_KEY    : in STD_LOGIC;
		WRITE_ENABLE : in STD_LOGIC;

		--Output
		RED_VGA         : out STD_LOGIC;
		GREEN_VGA       : out STD_LOGIC;
		BLUE_VGA        : out STD_LOGIC;
		HORIZONTAL_SYNC : out STD_LOGIC;
		VERTICAL_SYNC   : out STD_LOGIC
	);

end VGA_Controller;

architecture Structural of VGA_Controller is

signal CLOCK_25MHz : STD_LOGIC;
signal CURSOR_ADDRESS : STD_LOGIC_VECTOR(11 downto 0);
signal CHARACTER_ADDRESS : STD_LOGIC_VECTOR(6 downto 0);
signal ADDRESS_B : STD_LOGIC_VECTOR(11 downto 0);
signal FONT_ROM_ADDRESS : STD_LOGIC_VECTOR(10 downto 0);
signal FONT_ROM_OUT : STD_LOGIC_VECTOR(7 downto 0);

signal BLINKER_OUT : STD_LOGIC_VECTOR(7 downto 0);
signal MUX_IN : STD_LOGIC;

signal RGB   : STD_LOGIC_VECTOR(2 downto 0);
signal VIDEO_ON : STD_LOGIC;

signal PIXEL_X : STD_LOGIC_VECTOR(9 downto 0);
signal PIXEL_Y : STD_LOGIC_VECTOR(9 downto 0);

begin

	ADDRESS_B  <=  PIXEL_Y(8 downto 4)*X"50" + PIXEL_X(9 downto 3);
	FONT_ROM_ADDRESS  <= CHARACTER_ADDRESS & PIXEL_Y(3 downto 0);

	----- Structural Components: -----
	-- 25MHz Clock UNIT
	CLOCK_25MHz_Unit : entity work.CLOCK_25MHz
	port map (
		--in
		CLOCK         => CLOCK,
		CLOCK_25MHz   => CLOCK_25MHz
	);

	-- Duel Memory RAM
--	VGA_RAM : entity work.xilinx_dual_port_ram_sync
--	PORT MAP (
--		CLK     =>  CLOCK_25MHz,
--		CLR     =>  RESET,
--		WE      =>  WRITE_ENABLE,
--		ADDR_A  =>  CURSOR_ADDRESS,
--		ADDR_B  =>  ADDRESS_B,
--		DIN_A   =>  ASCII,
--		DOUT_B  =>  CHARACTER_ADDRESS
--	);  

	-- VGA Driver Unit
	VGA_DRIVER : entity work.VGA_DRIVER
	PORT MAP (
		CLKDIV =>  CLOCK_25MHz,
		CLR    =>  RESET,
		HS     =>  HORIZONTAL_SYNC,
		VS     =>  VERTICAL_SYNC,
		RED    =>  RGB(2),
		GRN    =>  RGB(1),
		BLU    =>  RGB(0),
		VIDON1 =>  VIDEO_ON,
		HC1    =>  PIXEL_X,
		VC1    =>  PIXEL_Y
	);

	-- RGB DRIVER Unit
	RGB_DRIVER : entity work.RGB_DRIVER
	PORT MAP (
		RGB      =>  RGB,
		MUX_IN   =>  MUX_IN,
		VIDEO_ON =>  VIDEO_ON,
		RED      =>  RED_VGA,
		GREEN    =>  GREEN_VGA,
		BLUE     =>  BLUE_VGA
	);

	-- MUX DRIVER Unit
	MUX_DRIVER : entity work.MUX_DRIVER
	PORT MAP (
		DATA   =>  BLINKER_OUT,
		SEL     =>  PIXEL_X(2 downto 0),
		OUTPUT  =>  MUX_IN
	);

	-- RGB DRIVER Unit
	BLINKER : entity work.BLINKER
	PORT MAP (
		ADDR_B      =>  ADDRESS_B,
		CURSOR_ADR  =>  CURSOR_ADDRESS,
		CLK         =>  CLOCK_25MHz,
		OUTPUT      =>  BLINKER_OUT,
		FONT_ROM    =>  FONT_ROM_OUT
	);

	-- FONT ROM
	FONT_ROM : entity work.FONT_ROM
	PORT MAP (
		CLK     =>  CLOCK_25MHz,
		ADDR    =>  FONT_ROM_ADDRESS,
		DATA    =>  FONT_ROM_OUT
	);

	-- CURSOR
	CURSOR : entity work.CURSOR
	PORT MAP (
		SCANCODE     =>  KEYCODE,
		WE           =>  WRITE_ENABLE,
		ENB          =>  VALID_KEY,
		CURSOR_ADR2  =>  CURSOR_ADDRESS
	);
	
end Structural;
