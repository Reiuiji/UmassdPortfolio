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
--      Convert KeyCode into Ascii Characters
--
-- Notes:
--      [ ]:Need to Fix the Shift implement!
--
-- Revision: 
--      0.01  - File Created
--      0.02 - Cleaned up Given Code
--      0.03 - Restructured the Code for upper/lower case
--                Fortier had both case the same.
--      0.04 - Fixed up the Key Code input, see additional
--                comments for more info
--      0.05 - Converted the ascii values to Hex.
--      0.06 - incorporated state machine (based on LCD_Driver)
--
-- Additional Comments:
--      Key Code and research was done from the following links:
--      http://www.electronic-engineering.ch/microchip/projects/keyboard/v1xx/keyboard_v1xx.html
--      http://www.electronic-engineering.ch/microchip/projects/keyboard/v1xx/scancode.gif
--      http://www.jimprice.com/jim-asc.shtml#keycodes
-- 
-----------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.all;     
USE ieee.std_logic_arith.all;

entity KEYCODE_TO_ASCII is

	generic(
		DATA_WIDTH:integer:=8
	);

	port(--Input
		--CLOCK   : in STD_LOGIC;
		RESET   : in STD_LOGIC;
		KEYCODE : in STD_LOGIC_VECTOR(7 downto 0); --(DATA_WIDTH-1 downto 0);
		VALID_SIGNAL : in STD_LOGIC;
		-- Output
		COMPLETE: out STD_LOGIC; -- Hit Key sucessfully
		WRITE_ENABLE : out STD_LOGIC; -- Can that character write to screen?
		ASCII   : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0);
		KEYCODE_OUTPUT : out STD_LOGIC_VECTOR(DATA_WIDTH-1 downto 0)
	);

end KEYCODE_TO_ASCII;

architecture dataflow of KEYCODE_TO_ASCII is

	type StateType is (INIT, READ_BREAKCODE, READ_KEYCODE);
	signal STATE : StateType := INIT;

	signal ASCII_LOWER : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0');
	signal ASCII_UPPER : STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0) := (OTHERS => '0');

	shared variable Shift_Key : boolean := false;

begin

	with KEYCODE select
		ASCII_LOWER <=
			-- Alphabet
			x"61" when x"1C",	-- a
			x"62" when x"32",	-- b
			x"63" when x"21",	-- c
			x"64" when x"23",	-- d
			x"65" when x"24",	-- e
			x"66" when x"2B",	-- f
			x"67" when x"34",	-- g
			x"68" when x"33",	-- h
			x"69" when x"43",	-- i
			x"6A" when x"3B",	-- j
			x"6B" when x"42",	-- k
			x"6C" when x"4B",	-- l
			x"6D" when x"3A",	-- m
			x"6E" when x"31",	-- n
			x"6F" when x"44",	-- o
			x"70" when x"4D",	-- p
			x"71" when x"15",	-- q
			x"72" when x"2D",	-- r
			x"73" when x"1B",	-- s
			x"74" when x"2C",	-- t
			x"75" when x"3C",	-- u
			x"76" when x"2A",	-- v
			x"77" when x"1D",	-- w
			x"78" when x"22",	-- x
			x"79" when x"35",	-- y
			x"7A" when x"1A",	-- z

			--Top Row
			x"60" when x"0E",	-- `
			x"31" when x"16",	-- 1
			x"32" when x"1E",	-- 2
			x"33" when x"26",	-- 3
			x"34" when x"25",	-- 4
			x"35" when x"2E",	-- 5
			x"36" when x"36",	-- 6
			x"37" when x"3D",	-- 7
			x"38" when x"3E",	-- 8
			x"39" when x"46",	-- 9
			x"30" when x"45",	-- 0
			x"2D" when x"4E",	-- -
			x"3D" when x"55",	-- =

			--Enter Corner
			x"5B" when x"54",	-- [
			x"5D" when x"5B",	-- ]
			x"5C" when x"5D",	-- \ 
			x"3B" when x"4C",	-- ;
			x"27" when x"52",	-- '
			x"2C" when x"41",	-- ,
			x"2E" when x"49",	-- .
			x"2F" when x"4A",	-- /

			--Function Keys -- Based on the IBM PC Codes
			x"1B" when x"76",	-- Esc (Escape)
			x"3B" when x"05",	-- F1
			x"3C" when x"06",	-- F2
			x"3D" when x"04",	-- F3
			x"3E" when x"0C",	-- F4
			x"3F" when x"03",	-- F5
			x"40" when x"0B",	-- F6
			x"41" when x"83",	-- F7
			x"42" when x"0A",	-- F8
			x"43" when x"01",	-- F9
			x"44" when x"09",	-- F10
			x"85" when x"78",	-- F11
			x"86" when x"07",	-- F12
			x"09" when x"0D",	-- Tab (Horizontal Tab)
			x"0D" when x"5A",	-- Enter (Carriage Return)

			--need no value *(special characters)
			x"00" when x"58",	-- Caps Lock
			x"00" when x"14",	-- Ctrl
			x"00" when x"11",	-- Alt
			x"00" when x"66",	-- Back Space

			--Direction Keys
			x"48" when x"75",	-- Up
			x"50" when x"72",	-- Down
			x"4B" when x"6B",	-- Left
			x"4D" when x"74",	-- Right

			--Unknown input
			x"00" when OTHERS; -- Null


	with KEYCODE select
		ASCII_UPPER <=
			-- Alphabet
			x"41" when x"1C",	-- A
			x"42" when x"32",	-- B
			x"43" when x"21",	-- C
			x"44" when x"23",	-- D
			x"45" when x"24",	-- E
			x"46" when x"2B",	-- F
			x"47" when x"34",	-- G
			x"48" when x"33",	-- H
			x"49" when x"43",	-- I
			x"4A" when x"3B",	-- J
			x"4B" when x"42",	-- K
			x"4C" when x"4B",	-- L
			x"4D" when x"3A",	-- M
			x"4E" when x"31",	-- N
			x"4F" when x"44",	-- O
			x"50" when x"4D",	-- P
			x"51" when x"15",	-- Q
			x"52" when x"2D",	-- R
			x"53" when x"1B",	-- S
			x"54" when x"2C",	-- T
			x"55" when x"3C",	-- U
			x"56" when x"2A",	-- V
			x"57" when x"1D",	-- W
			x"58" when x"22",	-- X
			x"59" when x"35",	-- Y
			x"5A" when x"1A",	-- Z

			-- Special Upper case Characters (top left to bottom right)
			-- Top Row
			x"7E" when x"0E",	-- ~
			x"21" when x"16",	-- !
			x"40" when x"1E",	-- @
			x"23" when x"26",	-- #
			x"24" when x"25",	-- $
			x"25" when x"2E",	-- %
			x"5E" when x"36",	-- ^
			x"26" when x"3D",	-- &
			x"2A" when x"3E",	-- *
			x"28" when x"46",	-- (
			x"29" when x"45",	-- )
			x"5F" when x"4E",	-- _
			x"2B" when x"55",	-- +

			-- Enter Corner
			x"7B" when x"54",	-- {
			x"7D" when x"5B",	-- }
			x"7C" when x"5D",	-- |
			x"3A" when x"4C",	-- :
			x"22" when x"52",	-- "
			x"3C" when x"41",	-- <
			x"3E" when x"49",	-- >
			x"3F" when x"4A",	-- ?

			-- Unknown Key
			x"00" when OTHERS; -- Null


	PROCESS (KEYCODE,VALID_SIGNAL, RESET)

	BEGIN

		if (RESET = '1') then
			STATE <= init;
		elsif (VALID_SIGNAL= '1' AND  VALID_SIGNAL'EVENT ) then
			case STATE is

				when init =>
					COMPLETE <= '0';
					WRITE_ENABLE <= '0';
					-- Special Key was Clicked, Reset since you dont want to input it
					if keycode=x"E0" then
						state <= init;
					-- A Key was pressed
					elsif keycode=x"F0" then
						state <= READ_KEYCODE;
					else
					-- No break code yet
						state <= READ_BREAKCODE;
					end if;
				
					-- Shift Key was press (on)
					if (keycode=x"12" or keycode=x"54") then
						Shift_Key := true;
					end if;


				when READ_BREAKCODE =>
					if keycode=x"F0" then
						state <= READ_KEYCODE;
					elsif keycode=x"E0" then
						state <= READ_BREAKCODE;
					else
						state <= init;
					end if;

				when READ_KEYCODE =>
					state <= init;
					-- Shift Key was released (off)
					if (keycode=x"12" or keycode=x"54") then
						Shift_Key := false;
					else 
						if (Shift_Key = true) then
							ascii <= ASCII_UPPER(DATA_WIDTH-1 downto 0);
						else
							ascii <= ASCII_LOWER(DATA_WIDTH-1 downto 0);
						end if;
					end if;
					KEYCODE_OUTPUT <= KEYCODE;
					
--					if (keycode=x"76" or keycode=x"05" or keycode=x"06" or keycode=x"04" or keycode=x"0C" or keycode=x"03" 
--								      or keycode=x"03" or keycode=x"0B" or keycode=x"83" or keycode=x"0A" or keycode=x"01"
--								      or keycode=x"09" or keycode=x"78" or keycode=x"07" or keycode=x"0D" or keycode=x"5A"
--								      or keycode=x"75" or keycode=x"72" or keycode=x"6B" or keycode=x"74"  ) then
--
--						WRITE_ENABLE <= '0';
--					else
						WRITE_ENABLE <= '1';
					--end if;

					COMPLETE <= '1';

				when OTHERS =>

			end case;
		end if;
	end process;
end architecture dataflow;


