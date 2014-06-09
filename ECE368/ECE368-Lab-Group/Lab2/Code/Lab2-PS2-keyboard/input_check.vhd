----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- Create Date:    SPRING 2014 
-- Design Name: 
-- Module Name:    input_mux - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Revision 0.02 - Created a central process for the buttons
-- Revision 0.03 - Swaped reset from rotar button to a push button due to input error
--						 From the push buttom double clicking. 
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;



entity input_check is
	Port (	
				ascii : in STD_LOGIC_VECTOR(7 downto 0);
				complete: in STD_LOGIC ; 
				RA			: OUT STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Mux Output
				RB			: OUT STD_LOGIC_VECTOR	(23 downto 0);	-- CCR Mux Output
				OPCODE	: OUT STD_LOGIC_VECTOR	(3 downto 0);	-- CCR Mux Output
				POSITION : OUT STD_LOGIC_VECTOR	(3 downto 0)
				
			);
end input_check;

architecture behavior of input_check is
	constant RA_key : STD_LOGIC_VECTOR(7 downto 0) := "01101000" ; --H
	constant RB_key : STD_LOGIC_VECTOR(7 downto 0) := "01101010" ; --J
	
	type states is (ra_state, rb_state,op_state);
	signal Value : std_logic_vector (3 downto 0);
signal STATE : states := OP_STATE;
	signal pos : integer range 0 to 6 := 6;
begin
	POSITION <= conv_std_logic_vector(pos,4);
	process(ascii, complete)
	BEGIN
		
		if (complete= '1' AND  complete'EVENT ) then
			case ascii is
						when x"2B" =>
							OPCODE<="0000"; -- +,
							STATE <= OP_STATE;
						when x"2D" =>
							OPCODE<="0001"; -- -,
							STATE <= OP_STATE;
						when x"3e" =>
							OPCODE<="1000"; -- >,
							STATE <= OP_STATE;
						when x"3C" =>
							OPCODE<="0111"; -- <,
							STATE <= OP_STATE;
						when x"7C" =>
							OPCODE<="0011"; -- |,
							STATE <= OP_STATE;
						when x"26" =>
							OPCODE<="0010"; -- &,
							STATE <= OP_STATE;
						when x"3D" =>
							OPCODE<="0100"; -- =,
							STATE <= OP_STATE;
						when x"2C" =>
							OPCODE<="1001"; -- LD .,
							STATE <= OP_STATE;
						when x"2E" =>
							OPCODE<="1010"; -- ST ,, ,
							STATE <= OP_STATE;
						when RA_key =>
							Pos <=0;
							STATE <= RA_STATE;
						when RB_key =>
							Pos <=0;
							STATE <= RB_STATE;
						when "00110000" =>
							Value <= "0000"; -- 0
						when "00110001"  =>
							Value <= "0001"; -- 1
						when"00110010"  =>
							Value <= "0010"; -- 2
						when"00110011"  =>
							Value <="0011"; -- 3
						when"00110100"  =>
							Value <= "0100"; -- 4
						when"00110101"  =>
							Value <= "0101"; -- 5
						when"00110110"  =>
							Value <= "0110"; -- 6
						when"00110111"  =>
							Value <= "0111"; -- 7
						when"00111000"  =>
							Value <= "1000"; -- 8
						when"00111001"  =>
							Value <= "1001"; -- 9
						when"01000001"  =>
							Value <= "1010"; -- A
						when"01000010"  =>
							Value <= "1011"; -- B
						when"01000011"  =>
							Value <= "1100"; -- C
						when"01000100"  =>
							Value <= "1101"; -- D
						when"01000101"  =>
							Value <= "1110"; -- E
						when"01000110"  =>
							Value <= "1111"; -- F 
						when others =>
							OPCODE<="0000"; -- +,; 
							value<= "0000";
							STATE <= OP_STATE;	
			end case; 		
			case STATE is
				when RA_STATE =>
					RA(23 - pos*4 downto 20 - pos*4) <= value;
					pos <= pos +1;
				when RB_STATE =>
					RB(23 - pos*4 downto 20 - pos*4) <= value;
					pos <= pos +1;
				when OP_STATE => 
					pos <= 0;
			end case;
					
		end if; 
	end process;
end behavior;

