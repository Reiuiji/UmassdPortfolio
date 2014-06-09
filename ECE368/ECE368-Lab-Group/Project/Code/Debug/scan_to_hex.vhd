--------------------------------------------------------------------------------
-- Company: 	  UMD ECE
-- Engineers:	  Benjamin Doiron, Daniel Noyes
--
-- Create Date:   10:35:25 03/23/2014
-- Design Name:   Scan to Hex
-- Module Name:   scan_to_hex
-- Project Name:  Risc Machine Project 1
-- Target Device: Spartan 3E Board
-- Tool versions: Xilinx 14.7
-- Description:   This code takes in keystrokes and places them in a buffer.
-- The buffer is then read into a translator, changing it from scancode to hex values.
-- The hex values are then sent to the FPU once the enter key is pressed.
-- 
-- Revision:
-- Revision 0.01 - Ben: File Created
-- Revision 0.02 - Dan: Heavily modified code to work properly
-- Revision 0.03 - Ben: Implementation of second counter (cursor_counter)
-- 				  - Ben: Heavily modified the checks for each screen line
-- Revision 0.04 - Ben: Implemented high impedance when enter is pressed depending on what
--								the counter is. This way the processor will know immediately that there
--								is an error with a specific code input and so there's no confusion about
--								buffer needing to be reset before the data can be grabbed.
--						 Ben: Added a signal for read only so it doesn't try to enter new values.
--						 Ben: With high hopes, this should be the final revision.
-- Revision 0.05 - Ben: Yeah, I didn't think that was going to happen. Revising implementation for implementation.
--					 --Ben--: ~*~ This is a reminder to self to write the component to ignore high impedance sends ~*~
-- Revision 0.06   Ben: Reverted erroneous ascii values to their proper scancode values.
-- Revision 0.07	 Ben: Implemented a send signal for the risc machine to avoid duplicate/erroneous data sending.
-- Revision 0.08   Ben: 4/16/14 - Implemented a readonly signal that works properly.
--								This should be the final revision.
-- Revision 0.09   Ben: 4/16/14 - Added a cap for the number of lines.
--
-- Additional Comments: 
--			Note for Dan: If you're going to implement this with your instruction memory,
--				Make sure to have it so that if a high impedance is read, either perform no op
-- 			Or don't take in the instruction at all. Additionally, make it so that it sends out an error.
--------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;

entity scan_to_hex is
    Port ( 
	   Send : in STD_LOGIC; -- tells when input signal happens
		Resetn : in STD_LOGIC;
		readonly: in STD_LOGIC;
		scancode : in  STD_LOGIC_VECTOR (7 downto 0);	-- The input code
		output 	: out STD_LOGIC_VECTOR (23 downto 0);	-- The output code
		risc_send: out STD_LOGIC -- A send signal to let the risc know when to pull instructions
		
--		outCount : out STD_LOGIC_VECTOR (3 downto 0);
--		hexdebug : out STD_LOGIC_VECTOR (3 downto 0);
--		outbufdebug: out STD_LOGIC_VECTOR (47 downto 0);
--		outCursor : out STD_LOGIC_VECTOR (6 downto 0)
	);
end scan_to_hex;

architecture Behavioral of scan_to_hex is


signal counter : integer range 0 to 11;       -- A counter with a larger size than 6 to account for errors
signal cursor_counter: integer range 0 to 79; -- A counter for the number of characters able per line
signal line_counter: integer range 0 to 29;	-- A counter for the number of lines
signal Hex : STD_LOGIC_VECTOR(3 downto 0);

signal OutB : STD_LOGIC_VECTOR(23 downto 0);
type Buff_type is array (0 to 11) of std_logic_vector (3 downto 0);
signal Buff: Buff_type;


begin

--outbufdebug(47 downto 44) 	<= Buff( 0);
--outbufdebug(43 downto 40) 	<= Buff( 1);
--outbufdebug(39 downto 36) 	<= Buff( 2);
--outbufdebug(35 downto 32) 	<= Buff( 3);
--outbufdebug(31 downto 28) 	<= Buff( 4);
--outbufdebug(27 downto 24) 	<= Buff( 5);
--outbufdebug(23 downto 20) 	<= Buff( 6);
--outbufdebug(19 downto 16) 	<= Buff( 7);
--outbufdebug(15 downto 12) 	<= Buff( 8);
--outbufdebug(11 downto 8) 	<= Buff( 9);
--outbufdebug(7 downto 4) 	<= Buff(10);
--outbufdebug(3 downto 0) 	<= Buff(11);

--outCount <= conv_std_logic_vector(counter, 4);
--outCursor <= conv_std_logic_vector(cursor_counter, 7);

with scancode select
	Hex<=x"0" when x"45",--0 
		  x"1" when x"16",--1 
		  x"2" when x"1e",--2 
		  x"3" when x"26",--3 
		  x"4" when x"25",--4 
		  x"5" when x"2e",--5 
		  x"6" when x"36",--6 
		  x"7" when x"3d",--7 
		  x"8" when x"3e",--8 
		  x"9" when x"46",--9 
		  x"A" when x"1c",--a
		  x"B" when x"32",--b
		  x"C" when x"21",--c
		  x"D" when x"23",--d
		  x"E" when x"24",--e
		  x"F" when x"2b",--f
		  "ZZZZ" when others;
		
-- Hexdebug <= Hex;
output <= OutB;

process(Send)
begin
	if readonly = '0' then
		if Resetn = '0' then
			OutB <= (others => '0');
			Buff <= (others => (others =>'0'));
		else
			-- Keyboard Complete Signal
			if send'event and Send = '0' then
			risc_send <= '0';	
				if scancode = X"5A" then -- Enter Key
				
--					if 	(counter = 0) then
--						OutB (23 downto 0) 	<= "ZZZZZZZZZZZZZZZZZZZZZZZZ";
--						
--					elsif (counter = 1) then
--						OutB (23 downto 20) 	<= buff(0);
--						OutB (19 downto  0)  <= "ZZZZZZZZZZZZZZZZZZZZ";
--	
--					elsif (counter = 2) then 
--						OutB (23 downto 20) 	<= buff(0);
--						OutB (19 downto 16)  <= buff(1);
--						OutB (15 downto  0)  <= "ZZZZZZZZZZZZZZZZ";
--	
--					elsif (counter = 3) then
--						OutB (23 downto 20) 	<= buff(0);
--						OutB (19 downto 16)  <= buff(1);
--						OutB (15 downto 12)  <= buff(2);
--						OutB (11 downto  0)  <= "ZZZZZZZZZZZZ";
--						
--					elsif (counter = 4) then
--						OutB (23 downto 20) 	<= buff(0);
--						OutB (19 downto 16)  <= buff(1);
--						OutB (15 downto 12)  <= buff(2);
--						OutB (11 downto  8)  <= buff(3); 
--						OutB (7  downto  0)  <= "ZZZZZZZZ";
--					
--					elsif (counter = 5) then
--						OutB (23 downto 20) 	<= buff(0);
--						OutB (19 downto 16)  <= buff(1);
--						OutB (15 downto 12)  <= buff(2);
--						OutB (11 downto  8)  <= buff(3); 
--						OutB (7  downto  4)  <= buff(4);
--						OutB (3  downto  0)  <= "ZZZZ";
	
					if (counter > 5) then
					
						OutB(23 downto 20) <= buff(0);
						OutB(19 downto 16) <= buff(1);
						OutB(15 downto 12) <= buff(2);
						OutB(11 downto  8) <= buff(3);
						OutB(7  downto  4) <= buff(4);
						OutB(3  downto  0) <= buff(5);						
						risc_send <= '1';
					
					end if;
					
				counter <= 0;
				cursor_counter <= 0;
				Buff <= (others => (others =>'0'));
				line_counter <= line_counter + 1;
				
				else
					if(cursor_counter < counter) then cursor_counter <= counter; end if; 

				if(line_counter < 28) then	
					if (counter = 0 and cursor_counter = 0) then
						if (scancode = X"66") then 				-- If backspace is pressed
							counter <= counter;
							cursor_counter <= cursor_counter;
						elsif (scancode = X"6B") then			-- If left is pressed
							counter <= counter;
							cursor_counter <= cursor_counter;
						elsif (Hex /= "ZZZZ") then				-- If a hex key is entered
							buff(counter) <= Hex;
							counter <= counter + 1;
							cursor_counter <= cursor_counter + 1;
						else									-- Otherwise, includes right or space
							cursor_counter <= cursor_counter + 1;
						end if;
							
							
					elsif (counter = 0 and cursor_counter > 0) then
						if (scancode = X"66") then 				-- If backspace is pressed
							counter <= counter;
							cursor_counter <= cursor_counter - 1;
						elsif (scancode = X"6B") then			-- If left is pressed
							counter <= counter;
							cursor_counter<= cursor_counter - 1;
						elsif (Hex /= "ZZZZ") then				-- If a hex key is entered
							buff(counter) <= Hex;
							counter <= counter + 1;
							cursor_counter <= cursor_counter + 1;
						else									-- Otherwise, includes right or space
							if(cursor_counter < 78) then 
								cursor_counter <= 78;
							else
								cursor_counter <= cursor_counter + 1;
							end if;
						end if;
						
						
					elsif (counter = 11 and cursor_counter < 78) then
						if (scancode = X"66") then 				-- If backspace is pressed
							if (cursor_counter = 11) then
								counter <= counter - 1;
								cursor_counter <= cursor_counter - 1;
							elsif (cursor_counter > 11) then
								cursor_counter <= cursor_counter - 1;
							end if;
						elsif (scancode = X"6B") then			-- If left is pressed
							if (cursor_counter = 11) then
								counter <= counter - 1;
								cursor_counter <= cursor_counter - 1;
							elsif (cursor_counter > 11) then
								cursor_counter <= cursor_counter - 1;
							end if;
						elsif (Hex /= "ZZZZ") then				-- If a hex key is entered
							buff(counter) <= Hex;
							counter <= counter;
							cursor_counter <= cursor_counter + 1;					
						else									-- Otherwise
							cursor_counter <= cursor_counter + 1;
						end if;
						
						
					elsif (counter = 11 and (cursor_counter = 78 or cursor_counter > 78)) then
						if (scancode = X"66") then 				-- If backspace is pressed
							cursor_counter <= cursor_counter - 1;
						elsif (scancode = X"6B") then			-- If left is pressed
							cursor_counter <= cursor_counter - 1;
						elsif (Hex /= "ZZZZ") then				-- If a hex key is entered
							buff(counter) <= Hex;
							counter <= counter;
							cursor_counter <= cursor_counter;				
						else									-- Otherwise, includes right or space
							cursor_counter <= cursor_counter;
						end if;
						
					-- Normal Entry
					else
						if scancode = X"66" then				-- If backspace is pressed
							counter <= counter - 1;
							cursor_counter <= cursor_counter - 1;
						elsif scancode = X"6B" then				-- If left is pressed
							counter <= counter - 1;
							cursor_counter <= cursor_counter - 1;
						elsif (Hex /= "ZZZZ") then				-- If a hex key is entered
							buff(counter) <= Hex;
							counter <= counter + 1;
							cursor_counter <= cursor_counter + 1;
						else									-- Otherwise, includes right or space
							cursor_counter <= cursor_counter + 1;
						end if;
					end if;
				end if;
				end if;
			end if;
		end if;
	else
		OutB <= (others => 'Z');
		Buff <= (others => (others =>'Z'));
	end if;

end process; 
end Behavioral;