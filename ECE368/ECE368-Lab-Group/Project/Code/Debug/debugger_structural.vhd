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
-- Revision 0.02 - 4/17/14 Modified to suit changes made to scan_to_hex and data_to_ascii
-- Additional Comments: N/A
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity debugger_structural is
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
end debugger_structural;



architecture structural of debugger_structural is
-------------HEX DATA TO RISC--------------
component scan_to_hex is
	Port
	(
		Send:				in STD_LOGIC;
		Resetn:			in STD_LOGIC;
		readonly: 		in STD_LOGIC;
		scancode:		in STD_LOGIC_VECTOR 	( 7 downto 0);	
		
		risc_send: 	  out STD_LOGIC;		
		output:		  out STD_LOGIC_VECTOR 	(23 downto 0)
	);
end component;


-----------RISC DATA TO VGA OUT------------
component TRANSFER is
    port (
        CLOCK: in STD_LOGIC;
        Sent: in STD_LOGIC;
        INPUT: in STD_LOGIC_VECTOR(23 DOWNTO 0);
        OUTPUT: out STD_LOGIC_VECTOR(7 DOWNTO 0);
		  MUX_OUT: out STD_LOGIC_VECTOR(1 DOWNTO 0);
		  INST_SEND: out STD_LOGIC;
		  addressflag: out STD_LOGIC
    );
end component;

-----------32x24 bit Storage RAM------------
component RAM_5x24 is
	generic(
		RAM_WIDTH:	integer:=5; -- 00 - 1F choice
		DATA_WIDTH: integer:=24
	);
	port(
		CLOCK			: in std_logic;
		WE				: in std_logic;
		--RESETN			: in std_logic;
        --OUTPUT RAM
		OUT_ADDR		: in std_logic_vector(RAM_WIDTH-1 downto 0);
		OUT_DATA		: out std_logic_vector(DATA_WIDTH-1 downto 0);
		--INPUT RAM
		IN_ADDR		    : in std_logic_vector(RAM_WIDTH-1 downto 0);
		IN_DATA			: in std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end component;

----------MUX4TO1----------
component MUX4TO1 is
    Port ( 
			  IN0 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  IN1 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  IN2 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  IN3 	: in  STD_LOGIC_VECTOR (23 downto 0);
			  SEL 	: in  STD_LOGIC_VECTOR  (1 downto 0);
           OUTPUT : out STD_LOGIC_VECTOR (23 downto 0)
			);
end component;

----INSTRUCTION COUNTER-----
component instruction_counter is
	Port (
		clock: 		in  STD_LOGIC;
		RISC_SD:		in  STD_LOGIC;
		TRANS_SEND: in  STD_LOGIC;
		SEND_OUT:	out STD_LOGIC
	);
end component;

----Address Manager----
component addressmanager is
Port (
			clock: in std_logic;
			inputflag: in std_logic;
			outputaddr: out std_logic_vector(4 downto 0)
		);
end component;

SIGNAL IN0_ALU, IN1_STORE_DATA, IN2_DST_ADR, IN3_CCR: STD_LOGIC_VECTOR (23 downto 0);
SIGNAL OUT_ADDRESS: STD_LOGIC_VECTOR (4 downto 0);
SIGNAL MUX_OUTPUT: STD_LOGIC_VECTOR (23 downto 0);
SIGNAL MUX_SELECT: STD_LOGIC_VECTOR (1 downto 0);
SIGNAL SEND_RISC, SEND_TRANS, SENT_FOR_TRANS, TRANS_ADDR: STD_LOGIC;

begin
RISC_SEND <= send_risc;

U1: scan_to_hex 	PORT MAP (Send => send_signal, Resetn => reset, readonly => readsignal, scancode => scancode, risc_send => SEND_RISC, output => data_output );
U2: TRANSFER		PORT MAP (CLOCK => clk_in, INPUT => MUX_OUTPUT, OUTPUT => ASCII_OUT, MUX_OUT => MUX_SELECT, INST_SEND => SEND_TRANS, Sent => Sent_for_trans, addressflag => TRANS_Addr);
U3: RAM_5x24		PORT MAP (CLOCK => clk_in, WE => RISC_WE, IN_ADDR => p_counter_addr, IN_DATA => RISC_ALU,				OUT_ADDR => OUT_ADDRESS, OUT_DATA => IN0_ALU);
U4: RAM_5x24		PORT MAP (CLOCK => clk_in, WE => RISC_WE, IN_ADDR => p_counter_addr, IN_DATA => RISC_STORE_DATA, 	OUT_ADDR => OUT_ADDRESS, OUT_DATA => IN1_STORE_DATA);
U5: RAM_5x24		PORT MAP (CLOCK => clk_in, WE => RISC_WE, IN_ADDR => p_counter_addr, IN_DATA => RISC_DST_ADR, 		OUT_ADDR => OUT_ADDRESS, OUT_DATA => IN2_DST_ADR);
U6: RAM_5x24		PORT MAP (CLOCK => clk_in, WE => RISC_WE, IN_ADDR => p_counter_addr, IN_DATA => RISC_CCR, 			OUT_ADDR => OUT_ADDRESS, OUT_DATA => IN3_CCR);
U7: MUX4TO1			PORT MAP (IN0 => IN0_ALU, IN1 => IN1_STORE_DATA, IN2 => IN2_DST_ADR, IN3 => IN3_CCR, SEL => MUX_SELECT, OUTPUT => MUX_OUTPUT);
U8: instruction_counter PORT MAP (CLOCK => clk_in, RISC_SD => SEND_RISC, TRANS_SEND => SEND_TRANS, SEND_OUT => Sent_for_trans);
U9: addressmanager PORT MAP (CLOCK => clk_in, inputflag => TRANS_Addr, outputaddr => OUT_ADDRESS);
end structural;