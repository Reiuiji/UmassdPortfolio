----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
--
-- Create Date:    Spring 2014
-- Module Name:    Mem32Byte
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: FSM that reads in 11-bit PS/2
--		data from keyboard and exports keycode byte.
--
-- Notes:
-- 
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity PS2controller is
    Port ( reset : in  STD_LOGIC;
           PS2_CLOCK : in  STD_LOGIC;
           PS2_DATA : in  STD_LOGIC;
           keycode : out  STD_LOGIC_VECTOR (7 downto 0);
			  valid : out STD_LOGIC);
end PS2controller;

architecture Behavioral of PS2controller is

type state_type is (s_start, s_d0, s_d1, s_d2, s_d3, s_d4, s_d5, s_d6, s_d7, 
		s_parity, s_stop);
signal state : state_type;
begin
	FSM: process (PS2_CLOCK, reset)
	begin
		if (reset = '1') then
			state <= s_start;
		-- this FSM is driven by the keyboard clock signal
		elsif (PS2_CLOCK'EVENT and PS2_CLOCK = '1') then
			case state is
			when s_start =>
				state <= s_d0;
			when s_d0 =>
				state <= s_d1;
			when s_d1 =>
				state <= s_d2;
			when s_d2 =>
				state <= s_d3;
			when s_d3 =>
				state <= s_d4;
			when s_d4 =>
				state <= s_d5;
			when s_d5 =>
				state <= s_d6;
			when s_d6 =>
				state <= s_d7;
			when s_d7 =>
				state <= s_parity;
			when s_parity =>
				state <=s_stop;
			when s_stop =>
				state <=s_start;
			when others =>
			end case;
		end if;
	end process;

	output_logic: process (state, PS2_DATA)
	begin
		case state is
		when s_d0 =>
			keycode(0) <= PS2_DATA; -- read in bit 0 from keyboard
		when s_d1 =>
			keycode(1) <= PS2_DATA; -- read in bit 1 from keyboard
		when s_d2 =>
			keycode(2) <= PS2_DATA; -- read in bit 2 from keyboard
		when s_d3 =>
			keycode(3) <= PS2_DATA; -- read in bit 3 from keyboard
		when s_d4 =>
			keycode(4) <= PS2_DATA; -- read in bit 4 from keyboard
		when s_d5 =>
			keycode(5) <= PS2_DATA; -- read in bit 5 from keyboard
		when s_d6 =>
			keycode(6) <= PS2_DATA; -- read in bit 6 from keyboard
		when s_d7 =>
			keycode(7) <= PS2_DATA; -- read in bit 7 from keyboard
		when others =>
		end case;
	end process;
	
	valid <= '1' when state = s_stop else '0';
end Behavioral;