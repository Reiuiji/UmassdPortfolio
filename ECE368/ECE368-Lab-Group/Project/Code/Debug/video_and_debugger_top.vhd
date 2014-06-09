--------------------------------------------------------------------------------
-- Company: 	  UMD ECE
-- Engineers:	  Benjamin Doiron
--
-- Create Date:   10:12:25 4/2/2014
-- Design Name:   Structure of Debugger
-- Module Name:   debugger_structural
-- Project Name:  Risc Machine Project 1
-- Target Device: Spartan 3E Board
-- Tool versions: Xilinx 14.7
-- Description:   This is the top level for the debugger
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Revision 0.02 - April 14th - Added signals and fixed structure
-- Revision 0.03 - April 14th - Created a structure which a Risc machine could be attached to easily.
-- Additional Comments: N/A
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.UMDRISC_pkg.ALL;

entity video_and_debugger_top is
	Port
	(
		PS_CLK	:	in  	STD_LOGIC;
		PS_DATA	:	in  	STD_LOGIC;
		CLK 	:		in		STD_LOGIC; 
		RESET	:		in 	STD_LOGIC;
		CLR		:	in  	STD_LOGIC;
		READSIGNAL: in 	STD_LOGIC;
		RISC_WE:					in STD_LOGIC;		
		--p_counter_addr:		in STD_LOGIC_VECTOR (4 downto 0); --  4 bit program counter number to use as the address in
		--RISC_ALU:				in STD_LOGIC_VECTOR (23 downto 0);
		--RISC_STORE_DATA:		in STD_LOGIC_VECTOR (23 downto 0);
		--RISC_DST_ADR:			in STD_LOGIC_VECTOR (23 downto 0);
		--RISC_CCR:				in STD_LOGIC_VECTOR (23 downto 0);
		--EX_IN : in STD_LOGIC_VECTOR (23 downto 0);
		--EX_OUT: out STD_LOGIC_VECTOR (23 downto 0);
		PC_OUT: out STD_LOGIC_VECTOR (7 downto 0);
		--risc_send:	  out STD_LOGIC;
		--EXT_MEM: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
		SEL_WE : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
		R1		:		out 	STD_LOGIC;
		G1		:   	out 	STD_LOGIC;
		B1		:   	out 	STD_LOGIC;
		HS		:   	out 	STD_LOGIC;
		VS		:	 	out 	STD_LOGIC
	);
end video_and_debugger_top;


architecture structural of video_and_debugger_top is

------------RISC----------------
component UMDRISC_24 is
	PORT (
		--INPUT 
		CLOCK 			: in STD_LOGIC;
		RESETN			: in STD_LOGIC;
		ENABLE			: in STD_LOGIC;
		--OUTPUT
		STORE_DATA0		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); --Destination Data
		DST_ADDR0		: OUT STD_LOGIC_VECTOR(MEM_WIDTH-1 DOWNTO 0); --Destination Address
		ALU_OUT0		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		LDST_OUT0		: OUT STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0);
		CCR0				: OUT STD_LOGIC_VECTOR(3 DOWNTO 0); --Condition Code Register (ALU)
		--External Memory
		EX_IN			: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		EX_OUT			: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
		PC_OUT	: OUT STD_LOGIC_VECTOR(PC_WIDTH-1 DOWNTO 0)
		
	);
end component;


------------DEBUGGER------------
component debugger_structural is
	Port
	(
		-- Inputs -- 
		clk_in: 				in STD_LOGIC;								-- The clock
		reset: 				in STD_LOGIC;								-- Reset signal
		readsignal:			in STD_LOGIC;
		
		-- Keyboard Inputs-- 
		scancode: 			in STD_LOGIC_VECTOR	( 7 downto 0);	-- Scancode taken from keyboard
		send_signal: 		in STD_LOGIC;								-- Send signal from keyboard

		-- Inputs from the RISC --
		RISC_WE:					in STD_LOGIC;		
		p_counter_addr:		in STD_LOGIC_VECTOR (4 downto 0); --  4 bit program counter number to use as the address in
		RISC_ALU:				in STD_LOGIC_VECTOR (23 downto 0);
		RISC_STORE_DATA:		in STD_LOGIC_VECTOR (23 downto 0);
		RISC_DST_ADR:			in STD_LOGIC_VECTOR (23 downto 0);
		RISC_CCR:				in STD_LOGIC_VECTOR (23 downto 0);
		
		-- Outputs to the RISC --
		risc_send:	  		out STD_LOGIC;
		data_output:  		out STD_LOGIC_VECTOR 	(23 downto 0);	-- Data to be sent to the RISC
		
		-- Output to the VGA -- 
		ascii_out: 	  		out STD_LOGIC_VECTOR 	( 7 downto 0)	-- ascii to be sent to the screen
	);
end component;


----------VGA/KB-----------
component vga_structural is
	Port
	(
		clk_in : 		in  	STD_LOGIC;
      clr : 			in  	STD_LOGIC;
		RESET: 			in 	STD_LOGIC;
		EXT_MEM: 		IN 	STD_LOGIC_VECTOR(7 DOWNTO 0);
		SEL_WE : 		IN 	STD_LOGIC_VECTOR(1 DOWNTO 0);
      R1 : 				out  	STD_LOGIC;
      G1 : 				out  	STD_LOGIC;
      B1 : 				out  	STD_LOGIC;
      hs : 				out  	STD_LOGIC;
      vs : 				out  	STD_LOGIC;
		scancode_in : 		in std_logic_vector(7 downto 0);
		keyboard_ASCII : 	in std_logic_vector(6 downto 0);
		keyboard_WE : 		in std_logic;
		WE_CLK : 			out std_logic
	);
end component;

-------KEYBOARD-------
component keyboard_top is
	Port
	(
		ps_clk :  in STD_LOGIC;
		input  :  in STD_LOGIC;
		we_clk :  in STD_LOGIC;
		we	   : 	out STD_LOGIC;
		scancode:out STD_LOGIC_VECTOR(7 downto 0);
		output : out STD_LOGIC_VECTOR(6 downto 0)
		
	);
end component;

-----MUX2TO1-----
component MUX2TO1 is
    Port( 
				IN0 :     in  STD_LOGIC_VECTOR (6 downto 0);
				IN1 : 	 in  STD_LOGIC_VECTOR (7 downto 0);
				OUTPUT : 	out  STD_LOGIC_VECTOR (6 downto 0);
				SEL : 		 in  STD_LOGIC
			);
end component;

--- Debugger Signals -- 
SIGNAL sDEBUG_ASCII : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL sDEBUGGER_TO_RISC : STD_LOGIC_VECTOR (23 downto 0);

--- VGA Signals ---
SIGNAL sVGA_WE_CLK : STD_LOGIC;

--- Keyboard Signals ---
SIGNAL sKB_WE : STD_LOGIC;
SIGNAL sKB_SCAN : STD_LOGIC_VECTOR (7 downto 0);
SIGNAL sKB_ASCII : STD_LOGIC_VECTOR (6 downto 0);

--- MUX Signals --- 
SIGNAL sMUX_ASCII : STD_LOGIC_VECTOR (6 downto 0);
SIGNAL sSEL : STD_LOGIC;
SIGNAL RISC_LDST : STD_LOGIC_VECTOR(23 downto 0);
SIGNAL ENABLE : STD_LOGIC := '1';

--- RISC Signals ---
SIGNAL RISC_STORE_DATA: STD_LOGIC_VECTOR (23 downto 0);
SIGNAL RISC_DST_ADR: STD_LOGIC_VECTOR (23 downto 0);
SIGNAL RISC_ALU: STD_LOGIC_VECTOR (23 downto 0);
SIGNAL RISC_CCR: STD_LOGIC_VECTOR (23 downto 0);

SIGNAL EX_IN : STD_LOGIC_VECTOR (23 downto 0);
SIGNAL EX_OUT: STD_LOGIC_VECTOR (23 downto 0);
SIGNAL EXT_MEM: STD_LOGIC_VECTOR(7 DOWNTO 0);

SIGNAL p_counter_addr: STD_LOGIC_VECTOR (4 downto 0);

begin

RISC : UMDRISC_24 PORT MAP
		(
		CLOCK => CLK,
		RESETN => RESET,
		ENABLE => ENABLE,
		--OUTPUT
		STORE_DATA0 => RISC_STORE_DATA,
		DST_ADDR0 => RISC_DST_ADR(MEM_WIDTH-1 downto 0),
		ALU_OUT0 => RISC_ALU,
		LDST_OUT0 => RISC_LDST,
		CCR0 => RISC_CCR(3 downto 0),
		--External Memory
		EX_IN => EX_IN,
		EX_OUT => EX_OUT,
		PC_OUT => PC_OUT 
		);

S1: debugger_structural PORT MAP 
			(
				clk_in => 		CLK,
				reset  => 		RESET,
				readsignal =>  READSIGNAL,
				scancode =>		sKB_SCAN,
				send_signal =>	PS_CLK,
				data_output =>	sDEBUGGER_TO_RISC,
				ascii_out =>	sDEBUG_ASCII,
				RISC_WE => RISC_WE,
				p_counter_addr => p_counter_addr,
				RISC_ALU => RISC_ALU,
				RISC_STORE_DATA => RISC_STORE_DATA,
				RISC_DST_ADR => RISC_DST_ADR,
				RISC_CCR =>	RISC_CCR		
			);
			
S2: vga_structural 		PORT MAP 
			(
				clk_in 				=> CLK,
				clr 					=>	CLR,
				RESET 				=>	RESET,
				EXT_MEM 				=> EXT_MEM,
				SEL_WE  				=> SEL_WE,
				R1 					=> R1,
				G1  					=>	G1,
				B1  					=>	B1,
				hs  					=>	hs,
				vs  					=>	vs,
				scancode_in 		=> sKB_SCAN,  	
				keyboard_ASCII 	=> sMUX_ASCII, 	
				keyboard_WE  		=> sKB_we,	 	
				WE_CLK 				=>	sVGA_WE_CLK
			);
			
S3: keyboard_top 			PORT MAP 
			(
				ps_clk 	=> PS_CLK,
				input 	=> PS_DATA,
				we_clk 	=> sVGA_we_clk,
				we 		=> sKB_we,	
				scancode => sKB_SCAN,
				output 	=> sKB_ASCII
			);
			
S4: MUX2TO1					PORT MAP 
			(
				IN0 		=> sKB_ASCII,
				IN1 		=> sDEBUG_ASCII,	
				OUTPUT 	=> sMUX_ASCII,	
				SEL 		=> READSIGNAL			
			);

end structural;