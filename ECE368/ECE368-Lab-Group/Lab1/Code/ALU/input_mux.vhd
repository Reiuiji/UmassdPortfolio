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



entity input_mux is
	Port (	
				Sel_BTN : std_logic_vector (4 downto 0);	
				Value_SW : std_logic_vector (3 downto 0);
				--test :out STD_LOGIC_VECTOR	(3 downto 0);	
				RA			: OUT STD_LOGIC_VECTOR	(23 downto 0);	-- ALU Mux Output
				RB			: OUT STD_LOGIC_VECTOR	(23 downto 0);	-- CCR Mux Output
				OPCODE	: OUT STD_LOGIC_VECTOR	(3 downto 0);	-- CCR Mux Output
				POSITION : OUT STD_LOGIC_VECTOR	(3 downto 0)
				--LED_SEL	: BUFFER STD_LOGIC_VECTOR	(2 downto 0);
				--LED_Value : BUFFER STD_LOGIC_VECTOR	(3 downto 0)
			);
end input_mux;

architecture behavior of input_mux is
	signal Value : std_logic_vector (23 downto 0) := (OTHERS => '0'); -- Shift operations
	--signal position : integer range 0 to 6 := 0;
	
	signal RA0 : std_logic_vector (23 downto 0) := (OTHERS => '0');
	signal RA1 : std_logic_vector (23 downto 0) := (OTHERS => '0');
	
	signal RB0 : std_logic_vector (23 downto 0) := (OTHERS => '0');
	signal RB1 : std_logic_vector (23 downto 0) := (OTHERS => '0');
	

	signal OPCODE0 : std_logic_vector (3 downto 0) := (OTHERS => '0');	
	signal OPCODE1 : std_logic_vector (3 downto 0) := (OTHERS => '0');
	
	
	signal pos : integer range 0 to 6 := 6;
type OUT_STATE is (RESET, STD);
signal OUTPUT_STATE : OUT_STATE := STD;
	--signal sel : std_logic_vector (3 downto 0) := (OTHERS => '0');
	--signal Value_SW : std_logic_vector (3 downto 0) := (OTHERS => '0');

begin

RA <= RA0;
RB <= RB0;
OPCODE <= OPCODE0;
POSITION <= conv_std_logic_vector(pos,4); --std_logic_vector(to_signed(pos, 4));

--
--	with OUTPUT_STATE select
--		RA0 <= RA1 when STD,
--				X"000000" when RESET;
--			
--	with OUTPUT_STATE select
--		RB0 <= RB1 when STD,
--				X"000000" when RESET;
--
--	with OUTPUT_STATE select
--		OPCODE0 <= OPCODE1 when STD,
--				X"0" when RESET;

--	process(OUTPUT_STATE)
--	begin
--		OUTPUT_
	

	process(Sel_BTN)
	begin 
--		if  ( Sel_BTN(4) = '1' and Sel_BTN(4)'event ) then -- Seems to double or triple click when changing push button.
--			--OUTPUT_STATE <= STD;
--			--RA <= RA + X"000001";
----			if(pos < 6) then
----				pos <= pos+1;
----			else
--				--pos <= 0;
--				--RA0 <= x"000000";
--				--RB0 <= x"000000";
----			end if;
--			
--			--test <= conv_std_logic_vector(position, 3)(2 downto 0);
----			Value((position * 4+3) downto (position * 4 )) <= Value_SW(3 downto 0);
----			position <= (position + 1) ; 
----			
----			if (position = 6) then 
----				position <= 0;
----			end if;
--		end if;
		
		if  ( Sel_BTN(3) = '1' and Sel_BTN(3)'event ) then 
			OPCODE0 <= Value_SW;
		end if;
		
		if  ( Sel_BTN(2) = '1' and Sel_BTN(2)'event ) then 
			if(pos < 5) then
				pos <= pos+1;
			else
				pos <= 0;
			end if;
		end if;
		
		if  ( Sel_BTN(1) = '1' and Sel_BTN(1)'event ) then 
			RB0(23 - pos*4 downto 20 - pos*4) <= Value_SW;
		end if;
		
		if  ( Sel_BTN(0) = '1' and Sel_BTN(0)'event ) then 
			RA0(23 - pos*4 downto 20 - pos*4) <= Value_SW;
		end if;
		
	end process;
	----- Create Values -----
--	process(Sel_BTN(3))
--	begin 
--		
--	end process;
--	
--	process(Sel_BTN(2))
--	begin 
--		
--	end process;
--	
--	process(Sel_BTN(1))
--	begin 
--		
--	end process;
--	process(Sel_BTN(0))
--	begin 
--
--	end process;
--	with Sel_BTN select
--		RA 		<= Value when "00001", 	-- RA
--					x"A22222" when "01000",
--					RA when OTHERS;
--	with Sel_BTN select
--		RB			<=	Value when "00010", 	-- RB
--					X"B22222" when "01000",
--					RB when OTHERS;
--	with Sel_BTN select
--		OPCODE	<=	Value_SW when "00100", -- OPCODE
--					 "0000" when "01000",
--					 OPCODE  when OTHERS; 
	--LED_SEL <= SEL;
	--LED_VALUE <= Value_SW;
	--test <= OPCODE;
end behavior;

