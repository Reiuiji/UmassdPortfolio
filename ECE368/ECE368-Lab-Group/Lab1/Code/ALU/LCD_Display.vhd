----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- Create Date:    SPRING 2014
-- Design Name: 
-- Module Name:    LCD_DISPLAY - behavior
-- Project Name: 		
-- Target Devices: 
-- Tool versions: 
-- Description: This LCD driver was modified from the cosmiac tutorial 6 by Rahul Vora.
--					 http://www.cosmiac.org/tutorial_6.html
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Revision 0.02 - Implemented a LCD buffer
-- Revision 0.03 - Implemented a hexnum to display converter
-- Revision 0.04 - Added a refresh cycle at 1 Hz
-- Revision 0.05 - Finished implementing Next Line Function
-- Revision 0.06 - Added the CCR registers into the LCD
-- Revision 0.07 - Convert design from bit to std_logic
-- Revision 0.08 - Cleaned up the test signals and set up for ALU
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;


entity LCD_DISPLAY is
	port(
		clk, reset : in STD_LOGIC;
		SF_D : out STD_LOGIC_vector(3 downto 0);
		LCD_E, LCD_RS, LCD_RW, SF_CE0 : out STD_LOGIC;
		A,B,C : in STD_LOGIC_vector(23 downto 0) ;
		OPCODE, CCR, POSITION: in STD_LOGIC_vector(3 downto 0)
		);
end LCD_DISPLAY;

architecture behavior of LCD_DISPLAY is

type tx_sequence is (high_setup, high_hold, oneus, low_setup, low_hold, fortyus, done);
signal tx_state : tx_sequence := done;
signal tx_byte : STD_LOGIC_vector(7 downto 0);
signal tx_init : STD_LOGIC := '0';

type init_sequence is (idle, fifteenms, one, two, three, four, five, six, seven, eight, done);
signal init_state : init_sequence := idle;
signal init_init, init_done : STD_LOGIC := '0';

signal i : integer range 0 to 750000 := 0;
signal i2 : integer range 0 to 2000 := 0;
signal i3 : integer range 0 to 82000 := 0;
signal ir : integer range 0 to 50000000 := 0; -- 50 MHz in which brings it to 1 second 
signal DISP_INDEX : integer range 0 to 32 := 0;

signal SF_D0, SF_D1 : STD_LOGIC_vector(3 downto 0);
signal LCD_E0, LCD_E1 : STD_LOGIC;
signal mux : STD_LOGIC;

signal HEXNUM : STD_LOGIC_vector(4 downto 0); -- [special char][hex number]
signal NUM : STD_LOGIC_vector(7 downto 0);

signal LCD_BUFFER : STD_LOGIC_vector(127 downto 0) := (OTHERS => '0');

type display_state is (init, function_set, entry_set, set_display, clr_display, pause, set_addr, DISP, NEWLINE, done);
signal cur_state : display_state := init;

--signal newlinecheck : bit_vector(7 downto 0) := (OTHERS => "01101101");

begin

	SF_CE0 <= '1'; --disable intel strataflash
	LCD_RW <= '0'; --write only

	--The following "with" statements simplify the process of adding and removing states.

	--when to transmit a command/data and when not to
	with cur_state select
		tx_init <= '0' when init | pause | done,
			'1' when others;

	--control the bus
	with cur_state select
		mux <= '1' when init,
			'0' when others;

	--control the initialization sequence
	with cur_state select
		init_init <= '1' when init,
			'0' when others;
	
	--register select
	with cur_state select
		LCD_RS <= '0' when function_set|entry_set|set_display|clr_display|set_addr|NEWLINE,
			'1' when others;

	--what byte to transmit to LCD
	--refer to datasheet for an explanation of these values
	with cur_state select
		tx_byte <= "00101000" when function_set,
			"00000110" when entry_set,
			"00001100" when set_display,
			"00000001" when clr_display,
			"10000000" when set_addr,
			NUM		  when DISP,
			X"C0"		  when NEWLINE,
			"00000000" when others;
		
	--LCD decoder
	with HEXNUM select
		NUM <= 
		"00110000" when "00000", -- 0
		"00110001" when "00001", -- 1
		"00110010" when "00010", -- 2
		"00110011" when "00011", -- 3
		"00110100" when "00100", -- 4
		"00110101" when "00101", -- 5
		"00110110" when "00110", -- 6
		"00110111" when "00111", -- 7
		"00111000" when "01000", -- 8
		"00111001" when "01001", -- 9
		"01000001" when "01010", -- A
		"01000010" when "01011", -- B
		"01000011" when "01100", -- C
		"01000100" when "01101", -- D
		"01000101" when "01110", -- E
		"01000110" when "01111", -- F 
		"00101011" when "10000", -- ADD
		"00101101" when "10001", -- SUB
		"00100110" when "10010", -- AND
		"01111100" when "10011", -- OR
		"00111101" when "10100", -- CMP
		"00101011" when "10101", -- ADDI
		"00100110" when "10110", -- ANDI
		"01111111" when "10111", -- SL
		"01111110" when "11000", -- SR
		"00101100" when "11001", -- LW
		"00101110" when "11010", -- SW
		"01100011" when "11011", -- CCR(0): Carry
		"01101111" when "11100", -- CCR(1): OverFlow
		"01111010" when "11101", -- CCR(2): Zero
		"11101001" when "11110", -- CCR(3): Negative
		"11111110" when "11111", -- space
		--x"80" when "11111", -- hex 40 for Next Line
		"11111110" when OTHERS; -- ERROR so space

	--Set the LCD buffer
	LCD_Buff: process(clk)
	begin
	
	if(clk='1' and clk'event) then
	
		LCD_BUFFER(127 downto 104) <= A;
		LCD_BUFFER(87 downto 64) <= B;
		LCD_BUFFER(99 downto 96) <= OPCODE; -- op Codes
		LCD_BUFFER(95 downto 92) <= OPCODE; -- op Codes
		LCD_BUFFER(63 downto 40) <= C;
		LCD_BUFFER(23 downto 20) <= POSITION;
		LCD_BUFFER(15 downto 12) <= CCR;
		LCD_BUFFER(11 downto 8) <= CCR;
		LCD_BUFFER(7 downto 4) <= CCR;
		LCD_BUFFER(3 downto 0) <= CCR;
	
	end if;
	
	end process LCD_Buff;

	--main state machine
	display: process(clk, reset)
	begin
		if(reset='1') then
			cur_state <= function_set;
		elsif(clk='1' and clk'event) then
			case cur_state is
				--refer to intialize state machine below
				when init =>
					if(init_done = '1') then
						cur_state <= function_set;
					else
						cur_state <= init;
					end if;

				--every other state but pause uses the transmit state machine
				when function_set =>
					if(i2 = 2000) then
						cur_state <= entry_set;
					else
						cur_state <= function_set;
					end if;	
				
				when entry_set =>
					if(i2 = 2000) then
						cur_state <= set_display;
					else
						cur_state <= entry_set;
					end if;
				
				when set_display =>
					if(i2 = 2000) then
						cur_state <= clr_display;
					else
						cur_state <= set_display;
					end if;
				
				when clr_display =>
					i3 <= 0;
					if(i2 = 2000) then
						cur_state <= pause;
					else
						cur_state <= clr_display;
					end if;

				when pause =>
					if(i3 = 82000) then
						cur_state <= set_addr;
						i3 <= 0;
					else
						cur_state <= pause;
						i3 <= i3 + 1;
					end if;

				when set_addr =>
					if(i2 = 2000) then
						DISP_INDEX <= 1;
						HEXNUM(4) <= '0';
						HEXNUM(3 downto 0) <= LCD_BUFFER(127 downto 124);
						cur_state <= DISP;
					else
						cur_state <= set_addr;
					end if;
					
				when NEWLINE =>
				if(i2 = 2000) then
						cur_state <= DISP;
					else
						cur_state <= NEWLINE;
					end if;
					
					
				when DISP =>
					if(i2 = 2000) then
						if(DISP_INDEX = 32) then
							cur_state <= done;
						else
							DISP_INDEX <= DISP_INDEX + 1;
							if(DISP_INDEX> 5 and DISP_INDEX< 10) then
								if(DISP_INDEX = 6 or DISP_INDEX = 9) then
									HEXNUM <= "11111"; -- Space
								else
									HEXNUM(3 downto 0) <= LCD_BUFFER((127-4*DISP_INDEX) downto (124-4*DISP_INDEX));
									HEXNUM(4) <= '1';								
									
								end if;
							else 
									if(DISP_INDEX > 27) then
										if(DISP_INDEX = 28) then
											if(LCD_BUFFER(127-4*DISP_INDEX) = '1') then -- CCR(3)
												HEXNUM <= "11110";
											else
												HEXNUM <= "11111";
											end if;
										end if;
										if(DISP_INDEX = 29) then
											if(LCD_BUFFER(127-4*DISP_INDEX - 1) = '1') then -- CCR(2)
												HEXNUM <= "11101";
											else
												HEXNUM <= "11111";
											end if;
										end if;
										if(DISP_INDEX = 30) then
											if(LCD_BUFFER(127-4*DISP_INDEX - 2) = '1') then -- CCR(1)
												HEXNUM <= "11100";
											else
												HEXNUM <= "11111";
											end if;
										end if;
										if(DISP_INDEX = 31) then
											if(LCD_BUFFER(127-4*DISP_INDEX - 3) = '1') then -- CCR(0)
												HEXNUM <= "11011";
											else
												HEXNUM <= "11111";
											end if;
										end if;
										
									else
										if(DISP_INDEX> 21 and DISP_INDEX< 28 and not (DISP_INDEX = 26)) then
											HEXNUM <= "11111";
										else
											HEXNUM(4) <= '0';
											HEXNUM(3 downto 0) <= LCD_BUFFER((127-4*DISP_INDEX) downto (124-4*DISP_INDEX));
										end if;
									end if;
							end if;
						end if;
						if(Disp_INDEX = 16) then
							cur_state <=  NEWLINE;
						end if;
					else
						cur_state <= DISP;
					end if;

				when done =>
					if(ir = 50000000) then
					ir <= 0;
					cur_state <= function_set;
					else
					ir <= ir + 1;
					cur_state <= done;
					end if;
			end case;
		end if;
	end process display;

	with mux select
		SF_D <= SF_D0 when '0', --transmit
			SF_D1 when others;	--initialize
	with mux select
		LCD_E <= LCD_E0 when '0', --transmit
			LCD_E1 when others; --initialize

	--specified by datasheet
	transmit : process(clk, reset, tx_init)
	begin
		if(reset='1') then
			tx_state <= done;
		elsif(clk='1' and clk'event) then
			case tx_state is
				when high_setup => --40ns
					LCD_E0 <= '0';
					SF_D0 <= tx_byte(7 downto 4);
					if(i2 = 2) then
						tx_state <= high_hold;
						i2 <= 0;
					else
						tx_state <= high_setup;
						i2 <= i2 + 1;
					end if;

				when high_hold => --230ns
					LCD_E0 <= '1';
					SF_D0 <= tx_byte(7 downto 4);
					if(i2 = 12) then
						tx_state <= oneus;
						i2 <= 0;
					else
						tx_state <= high_hold;
						i2 <= i2 + 1;
					end if;

				when oneus =>
					LCD_E0 <= '0';
					if(i2 = 50) then
						tx_state <= low_setup;
						i2 <= 0;
					else
						tx_state <= oneus;
						i2 <= i2 + 1;
					end if;

				when low_setup =>
					LCD_E0 <= '0';
					SF_D0 <= tx_byte(3 downto 0);
					if(i2 = 2) then
						tx_state <= low_hold;
						i2 <= 0;
					else
						tx_state <= low_setup;
						i2 <= i2 + 1;
					end if;

				when low_hold =>
					LCD_E0 <= '1';
					SF_D0 <= tx_byte(3 downto 0);
					if(i2 = 12) then
						tx_state <= fortyus;
						i2 <= 0;
					else
						tx_state <= low_hold;
						i2 <= i2 + 1;
					end if;

				when fortyus =>
					LCD_E0 <= '0';
					if(i2 = 2000) then
						tx_state <= done;
						i2 <= 0;
					else
						tx_state <= fortyus;
						i2 <= i2 + 1;
					end if;

				when done =>
					LCD_E0 <= '0';
					if(tx_init = '1') then
						tx_state <= high_setup;
						i2 <= 0;
					else
						tx_state <= done;
						i2 <= 0;
					end if;

			end case;
		end if;
	end process transmit;
					
	--specified by datasheet
	power_on_initialize: process(clk, reset, init_init) --power on initialization sequence
	begin
		if(reset='1') then
			init_state <= idle;
			init_done <= '0';
		elsif(clk='1' and clk'event) then
			case init_state is
				when idle =>	
					init_done <= '0';
					if(init_init = '1') then
						init_state <= fifteenms;
						i <= 0;
					else
						init_state <= idle;
						i <= i + 1;
					end if;
				
				when fifteenms =>
					init_done <= '0';
					if(i = 750000) then
						init_state <= one;
						i <= 0;
					else
						init_state <= fifteenms;
						i <= i + 1;
					end if;

				when one =>
					SF_D1 <= "0011";
					LCD_E1 <= '1';
					init_done <= '0';
					if(i = 11) then
						init_state<=two;
						i <= 0;
					else
						init_state<=one;
						i <= i + 1;
					end if;

				when two =>
					LCD_E1 <= '0';
					init_done <= '0';
					if(i = 205000) then
						init_state<=three;
						i <= 0;
					else
						init_state<=two;
						i <= i + 1;
					end if;

				when three =>
					SF_D1 <= "0011";
					LCD_E1 <= '1';
					init_done <= '0';
					if(i = 11) then	
						init_state<=four;
						i <= 0;
					else
						init_state<=three;
						i <= i + 1;
					end if;

				when four =>
					LCD_E1 <= '0';
					init_done <= '0';
					if(i = 5000) then
						init_state<=five;
						i <= 0;
					else
						init_state<=four;
						i <= i + 1;
					end if;

				when five =>
					SF_D1 <= "0011";
					LCD_E1 <= '1';
					init_done <= '0';
					if(i = 11) then
						init_state<=six;
						i <= 0;
					else
						init_state<=five;
						i <= i + 1;
					end if;

				when six =>
					LCD_E1 <= '0';
					init_done <= '0';
					if(i = 2000) then
						init_state<=seven;
						i <= 0;
					else
						init_state<=six;
						i <= i + 1;
					end if;

				when seven =>
					SF_D1 <= "0010";
					LCD_E1 <= '1';
					init_done <= '0';
					if(i = 11) then
						init_state<=eight;
						i <= 0;
					else
						init_state<=seven;
						i <= i + 1;
					end if;

				when eight =>
					LCD_E1 <= '0';
					init_done <= '0';
					if(i = 2000) then
						init_state<=done;
						i <= 0;
					else
						init_state<=eight;
						i <= i + 1;
					end if;

				when done =>
					init_state <= done;
					init_done <= '1';

			end case;

		end if;
	end process power_on_initialize;

end behavior;
