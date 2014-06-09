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
use work.all;

entity PS2_Input_Controller is

	generic(
		DATA_WIDTH:integer:=8
	);

	PORT (
		--Input
		CLOCK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		PS2_CLOCK : in STD_LOGIC;
		PS2_DATA  : in STD_LOGIC;

		--Output
		ASCII   : out STD_LOGIC_VECTOR (DATA_WIDTH-2 downto 0); --6 downto 0 : OUTPUT ASCII (FROM U2)
		KEYCODE : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		COMPLETE : out STD_LOGIC;
		WRITE_ENABLE : out STD_LOGIC
	);

end PS2_Input_Controller;

architecture Structural of PS2_Input_Controller is

signal VALID : STD_LOGIC;
signal KEYCODE_FROM_PS2 : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal KEYCODE_FROM_ASCII : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

--SYNC falling edge input signals

signal KEYCODE_FSYNC : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
signal ASCII_FSYNC : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);


begin
	ASCII <= ASCII_FSYNC(DATA_WIDTH-2 downto 0); -- 6 downto 0

	----- Structural Components: -----
	-- PS2controller UNIT
	PS2controller_Unit : entity work.PS2controller
	port map (
		--in
		RESET         => RESET,
		PS2_CLOCK     => PS2_CLOCK,
		PS2_DATA      => PS2_DATA,
		--out
		KEYCODE       => KEYCODE_FROM_PS2,
		VALID         => VALID
	);

	-- KEYCODE_TO_ASCII Unit
	KEYCODE_TO_ASCII_Unit : entity work.KEYCODE_TO_ASCII
	port map (
		--in
		RESET         => RESET,
		KEYCODE       => KEYCODE_FROM_PS2,
		VALID_SIGNAL  => VALID,

		--out
		COMPLETE      => COMPLETE,
		WRITE_ENABLE  => WRITE_ENABLE,
		ASCII         => KEYCODE_FSYNC,
		KEYCODE_OUTPUT=> KEYCODE_FROM_ASCII
	);

	-- KEYCODE FSYNC Unit
	KEYCODE_FSYNC_Unit : entity work.Sync_Falling
	port map (
		--in
		CLOCK       => CLOCK,
		INPUT       => KEYCODE_FSYNC,
		--out
		OUTPUT      => KEYCODE
	);

	-- ASCII FSYNC Unit
	ASCII_FSYNC_Unit : entity work.Sync_Falling
	port map (
		--in
		CLOCK       => CLOCK,
		INPUT       => KEYCODE_FROM_ASCII,
		--out
		OUTPUT      => ASCII_FSYNC
	);
	
	
end Structural;

