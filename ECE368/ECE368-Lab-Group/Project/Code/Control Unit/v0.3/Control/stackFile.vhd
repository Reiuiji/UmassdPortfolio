------------------------------------------------------------
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
--      0.03  - Perform the functionality of the Stack File
--
-- Additional Comments: 
--      The latches it's data on the RISING edge
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE work.UMDRISC_pkg.ALL;

Entity stackFile is
PORT(
		Clock	: IN 	STD_LOGIC;
		Resetn	: IN	STD_LOGIC;
		ENABLE	: IN	STD_LOGIC;
		ENABLEP	: IN	STD_LOGIC;
		pushPop	: IN	STD_LOGIC; --Signal 0: for push, 1 for pop
		INPUT		: IN STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0);
		isSuccess : OUT STD_LOGIC; --0 if operation not sucessfull, 1 if sucessful
		OUTPUT : OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0)
	);
End stackFile;

Architecture Behavioral of stackFile is
		Signal Position : Integer := 0;
		Signal isFull : std_logic:='0';
		Signal isEmpty: std_logic := '1';
		Signal Stack : std_logic_vector(PC_WIDTH*4 -1 downto 0) ;--:= (others => '0');
BEGIN
		
	PROCESS(Resetn, Clock)
	 
	BEGIN
		IF Resetn = '0' THEN
			OUTPUT <= (others => '0');
			isSuccess <= '0';
			 Position <= 0;
			 isFull <='0';
			 isEmpty<= '1';
			Stack <= (others => '0');
			
		ELSIF ENABLE = '1' AND ENABLEP='1' THEN
			IF Clock'EVENT AND Clock = '0' THEN
				If pushPop = '0' THEN
					If isFull='1' then
						isSuccess <= '0';
						output <= input; 
					Else
						Stack(((position+1) *PC_WIDTH)-1 downto (position*PC_WIDTH)) <= input(PC_WIDTH -1 downto 0); 
						position <= position +1;
						if position >= 3 Then
 							isFull <='1';
						End if; 
						isEmpty <= '0';
						isSuccess <='1';
						output <= input; 
					End IF; 
				Else 							--Pop 
					If isEmpty ='1' Then
						isSuccess <= '0';
						output <= input; 
					Else 
						isFull	 <= '0';
						isSuccess <='1';
						output(PC_WIDTH -1 downto 0)<=Stack((position *PC_WIDTH)-1 downto ((position-1)*PC_WIDTH));
						position <= position -1;
						if position = 0 then
							isEmpty <='1';
						End if; 
						
					End IF; 
				End if;
			END IF;
		END IF;
	END PROCESS;
End Behavioral;

