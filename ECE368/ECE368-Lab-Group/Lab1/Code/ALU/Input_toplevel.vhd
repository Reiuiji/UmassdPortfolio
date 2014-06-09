----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- Create Date:    22:52:01 02/03/2014 
-- Design Name: 
-- Module Name:    Input_toplevel - Sturctural  
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Input_toplevel is
    Port (  CLOCK 	: in 	STD_LOGIC;								-- 50 MHz Oscillator
			  BTN_WEST : in  STD_LOGIC;
           BTN_NORTH : in  STD_LOGIC;
           BTN_EAST : in  STD_LOGIC;
           BTN_SOUTH : in  STD_LOGIC;
           BTN_CTR : in  STD_LOGIC;
           SW : in  STD_LOGIC_VECTOR (3 downto 0);
           --LD0 : out  STD_LOGIC;
			  --,LD1,LD2,LD3,LD4,LD5,LD6 
			  --test : out STD_LOGIC_VECTOR (3 downto 0);
			  OPCODE_Value	: out STD_LOGIC_VECTOR (3 downto 0) ;
           --RA	:buffer STD_LOGIC_VECTOR (23 downto 0);
			  --RB	:buffer STD_LOGIC_VECTOR (23 downto 0);
			  --LCD DISPLAY PORTS
			  SF_D : out STD_LOGIC_VECTOR(3 downto 0); 
			  LCD_E, LCD_RS, LCD_RW, SF_CE0 : out STD_LOGIC ;
			  
			  LED2 : out STD_LOGIC_VECTOR(3 downto 0)
			  );
end Input_toplevel;
			  

architecture Sturctural  of Input_toplevel is

signal DEBOUNCE_BTN_CENTER : STD_LOGIC :='0'; 
signal DEBOUNCE_BTN_WEST : STD_LOGIC :='0'; 
signal DEBOUNCE_BTN_EAST : STD_LOGIC :='0'; 
signal DEBOUNCE_BTN_NORTH : STD_LOGIC :='0'; 
signal DEBOUNCE_BTN_SOUTH : STD_LOGIC :='0'; 

Signal CCR : STD_LOGIC_VECTOR (3 downto 0);	-- Condition Codes (N,Z,V,C)
Signal ALU_OUT	: STD_LOGIC_VECTOR (23 downto 0);	-- Output from ALU

	-- 24-bit Outputs
	signal RA	: STD_LOGIC_VECTOR (23 downto 0) ;--:= (OTHERS => x"123456"); -- Arithmetic Unit Output
	signal RB	: STD_LOGIC_VECTOR (23 downto 0) ; -- Logic Unit Output
	signal OPCODE_SIG	: STD_LOGIC_VECTOR (3 downto 0); -- Operation Code
	signal POSITION	: STD_LOGIC_VECTOR (3 downto 0); -- position location to change bit
	
	

begin
	--RA (3 downto 0) <= SW;
	--RB <= x"BBBBBB";
	--OPCODE_SIG <= "0000";
	LED2 <= POSITION;
	
	PROCESS (CLOCK)
	BEGIN
	If( CLOCK = '1' and CLOCK'event )then
			OPCODE_Value <= OPCODE_SIG ;
	end if ;
	END PROCESS;
	----- Structural Components: -----
	-- ALU Units
	debounce_unit : entity work.debounce
	port map (
		Clk     => CLOCK,  		-- reduced system clock
		Key     => BTN_CTR,	-- active low input
		pulse   => DEBOUNCE_BTN_CENTER   		--debounced output
	);
	
	Debounce_unit_WEST : entity work.debounce
		port map (
		Clk     => CLOCK,  		-- reduced system clock
		Key     => BTN_WEST,	-- active low input
		pulse   => DEBOUNCE_BTN_WEST   		--debounced output
	);

	Debounce_unit_EAST : entity work.debounce
		port map (
		Clk     => CLOCK,  		-- reduced system clock
		Key     => BTN_EAST,	-- active low input
		pulse   => DEBOUNCE_BTN_EAST   		--debounced output
	);
	
	Debounce_unit_NORTH : entity work.debounce
		port map (
		Clk     => CLOCK,  		-- reduced system clock
		Key     => BTN_NORTH,	-- active low input
		pulse   => DEBOUNCE_BTN_NORTH   		--debounced output
	);
	
	Debounce_unit_SOUTH : entity work.debounce
		port map (
		Clk     => CLOCK,  		-- reduced system clock
		Key     => BTN_SOUTH,	-- active low input
		pulse   => DEBOUNCE_BTN_SOUTH   		--debounced output
	);
	
	
	input_unit : entity work.input_mux
	port map(  
				 Sel_BTN(0) => DEBOUNCE_BTN_WEST, 
             Sel_BTN(1) => DEBOUNCE_BTN_NORTH, 
             Sel_BTN(2) => DEBOUNCE_BTN_EAST , 
             Sel_BTN(3) => DEBOUNCE_BTN_SOUTH,
             Sel_BTN(4) => DEBOUNCE_BTN_CENTER,
				 Value_SW => SW, 
			    RA => RA,
			    RB => RB,
			    OPCODE => OPCODE_SIG,
				 POSITION => POSITION
			  );

	
	alu_unit : entity work.alu_toplevel
	port map(CLK 			=> CLOCK,
				RA 			=> RA,					-- ALU Input
				RB 			=> RB,					-- ALU Input
				OPCODE 		=> OPCODE_SIG,				-- Only need least significant 3 bits
				CCR			=> CCR,					-- CCR
				ALU_OUT		=> ALU_OUT				-- ALU_OUT
				);

	LCD_Display : entity work.LCD_Display
	port map(CLK			=> CLOCK,
				RESET			=> DEBOUNCE_BTN_SOUTH,
				A				=> RA,
				B				=> RB,
				C				=> ALU_OUT,
				OPCODE		=> OPCODE_SIG,
				CCR			=> CCR,
				SF_D			=> SF_D,
				LCD_E			=> LCD_E,
				LCD_RS		=> LCD_RS,
				LCD_RW		=> LCD_RW,
				SF_CE0		=> SF_CE0,
				POSITION    => POSITION
				);
				

end Sturctural ;


	
