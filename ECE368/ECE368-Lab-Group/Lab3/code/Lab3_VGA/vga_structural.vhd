----------------------------------------------------------------
-- Company: 	UMD ECE
-- Engineer: 	Fortier
-- 
-- Create Date:    2/7/2013 
-- Design Name: 
-- Module Name:    VGA_Structural- Structural 
-- Project Name: VGA
-- Target Devices: Spartan 3E
-- Tool versions: Xilinx ISE 10.1
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
-------------------------------------------------------------------------VGA Sructural------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity vga_structural is
    Port ( clk_in : in  STD_LOGIC;
           ps_clk : in  STD_LOGIC;
           input : in  STD_LOGIC;
           clr : in  STD_LOGIC;
			  -- EXT_MEM: IN STD_LOGIC_VECTOR(7 DOWNTO 0);
			  ASCII : OUT STD_LOGIC_VECTOR(6 DOWNTO 0);--TEST
			  scanCode : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);--TEST
--			  MUX_CURSOR : OUT STD_LOGIC_VECTOR(11 DOWNTO 0);--TEST
			  SEL_WE : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
           R1 : out  STD_LOGIC;
           G1 : out  STD_LOGIC;
           B1 : out  STD_LOGIC;
           hs : out  STD_LOGIC;
           vs : out  STD_LOGIC);
end vga_structural;

architecture Structural of vga_structural is
------------RAM----------------------------------------------------------
component xilinx_dual_port_ram_sync is
   generic(
      ADDR_WIDTH: integer:=12;
      DATA_WIDTH:integer:=7
   );
   port(
      clk: in std_logic;
		clr : in std_logic;
      we: in std_logic;
      addr_a: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      addr_b: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      din_a: in std_logic_vector(DATA_WIDTH-1 downto 0);
      dout_b: out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end component;

-------FONT ROM------------------------------------------------------------
component font_rom is
   port(
      clk: in std_logic;
      addr: in std_logic_vector(10 downto 0);
      data: out std_logic_vector(7 downto 0)
   );
end component;

------cursor--------------------------------------------------------------
component cursor is
    Port ( scancode : in STD_LOGIC_VECTOR (7 downto 0); 
           we : in  STD_LOGIC;
			  enb : in std_logic;
			  cursor_adr2 : out STD_LOGIC_VECTOR (11 downto 0));
end component;

-----------keyboard_controller--------------------------------------------
component PS2_Input_Controller is
	PORT (
		--Input
		CLOCK : in STD_LOGIC;
		RESET : in STD_LOGIC;
		PS2_CLOCK : in STD_LOGIC;
		PS2_DATA  : in STD_LOGIC;

		--Output
		ASCII   : out STD_LOGIC_VECTOR (6 downto 0); --6 downto 0 : OUTPUT ASCII (FROM U2)
		KEYCODE : out STD_LOGIC_VECTOR (7 downto 0);
		COMPLETE : out STD_LOGIC;
		WRITE_ENABLE : out STD_LOGIC
	);
end component;

----------vga_controller--------------------------------------------------
component vgaController is
    Port ( clkdiv, clr : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           red : out std_logic;
           grn : out std_logic;
           blu, vidon1 : out std_logic;
			  hc1, vc1 : out std_logic_vector(9 downto 0));
			  
end component;

--------MUX----------------------------------------------------------------
component MUX8to1 is
    Port ( sel : in  STD_LOGIC_VECTOR (2 downto 0);
           data : in  STD_LOGIC_VECTOR (7 downto 0);
           output : out  STD_LOGIC);
end component;

------blinker--------------------------------------------------------------
component blinker is
    Port ( addr_b : in  STD_LOGIC_VECTOR (11 downto 0);
			  clk : in STD_LOGIC;
           cursor_adr : in  STD_LOGIC_VECTOR (11 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0);
           font_rom : in  STD_LOGIC_VECTOR (7 downto 0));
end component;

--------clk divide---------------------------------------------------------
component clk_div is
    Port ( clk_in : in  STD_LOGIC;
           clk : out  STD_LOGIC);
end component;

-------rgb control----------------------------------------------------------
component rgb is
    Port ( rgb : in  STD_LOGIC_VECTOR (2 downto 0);
           mux_in : in  STD_LOGIC;
			  vidon : in std_logic;
           R1 : out  STD_LOGIC;
           G1 : out  STD_LOGIC;
           B1 : out  STD_LOGIC);
end component;
----------we_delay-----------------------------------------------------------
component we_delay is
    Port ( we_in, clk : in  STD_LOGIC;
           we_out : out  STD_LOGIC);
end component;
--------------------------NUMBER TO ASCII FOR DEBUGGER-----------------------
COMPONENT NUM_TO_ASCII is
    Port ( clk : IN STD_LOGIC;
	        SEL_WE : in  STD_LOGIC_VECTOR (1 downto 0);
			  NUMBER : in  STD_LOGIC_VECTOR (7 downto 0);
           ASCII : out  STD_LOGIC_VECTOR (6 downto 0));
end COMPONENT;
---------------------------MUX FOR DEBUGGER---------------------------------
COMPONENT MUX2TO1_DEBUGGER is
    Port ( WE,rWE : in  STD_LOGIC;
           SEL_WE : in  STD_LOGIC_VECTOR (1 downto 0);
           NUM_TO_ASCII, rDIN_A : in  STD_LOGIC_VECTOR (6 downto 0);
           CURS_ADDR, rCURS_ADDR : in  STD_LOGIC_VECTOR (11 downto 0);
           WE_OUT : out  STD_LOGIC;
           DIN_A : out  STD_LOGIC_VECTOR (6 downto 0);
           ADDR_A : out  STD_LOGIC_VECTOR (11 downto 0));
end COMPONENT;
----------------------------CURSOR INCREMENTER FOR DEBUGGER--------------------
COMPONENT CURSOR_INCREMENTER is
   Port ( CURS_ADDR : in  STD_LOGIC_VECTOR (11 downto 0);
           SEL_WE : in  STD_LOGIC_VECTOR (1 downto 0);
           CLK : in  STD_LOGIC;
           ADDR : out  STD_LOGIC_VECTOR (11 downto 0));
end COMPONENT;

--SIGNAL scanCode : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL MUX_CURSOR : STD_LOGIC_VECTOR(11 DOWNTO 0);
			 
SIGNAL EXT_MEM : STD_LOGIC_VECTOR(7 DOWNTO 0) := X"99";

SIGNAL wSCANCODE, wDATA, wMux2Mux : STD_LOGIC_VECTOR(7 DOWNTO 0);
SIGNAL wDIN_A, wDIN_A_OUT, wDOUT_B, wASCII : STD_LOGIC_VECTOR(6 DOWNTO 0);
SIGNAL wWE, wWE_OUT, wWE_delay, wR, wG, wB, wCLK,wCLK1, wMUX_IN, wenb, wvidon : STD_LOGIC;
SIGNAL wADDR_A, wADDR_B, wADDR_A_OUT, wADDR_FROM_INC : STD_LOGIC_VECTOR(11 DOWNTO 0);
SIGNAL wADDR : STD_LOGIC_VECTOR(10 DOWNTO 0);
SIGNAL wHC, wVC : STD_LOGIC_VECTOR(9 DOWNTO 0);

begin
scancode<=wSCANCODE;
wADDR_B<=wVC(8 DOWNTO 4)*X"50"+ wHC(9 DOWNTO 3);
wADDR<=wDOUT_B & wVC(3 DOWNTO 0);
U1: PS2_Input_Controller 
	PORT MAP (
		CLOCK     =>  clk_in,
		RESET     =>  CLR,
		PS2_CLOCK =>  PS_CLK,
		PS2_DATA  =>  INPUT,
		ASCII     =>  wDIN_A,
		KEYCODE   =>  wSCANCODE,
		COMPLETE  =>  wenb,
		WRITE_ENABLE  =>  wWE
	);
U2: CURSOR PORT MAP (SCANCODE=>wSCANCODE, WE=>wWE_delay,enb=>wenb, CURSOR_ADR2=>wADDR_A);
U3: xilinx_dual_port_ram_sync PORT MAP (CLK=>wCLK, clr => clr, WE=>wWE_OUT, ADDR_B=>wADDR_B, DIN_A=>wDIN_A_OUT, ADDR_A=>wADDR_A_OUT, DOUT_B=>wDOUT_B);  
U4: VGACONTROLLER PORT MAP (vidon1=>wvidon, CLKDIV=>wCLK, CLR=>CLR, RED=>wR, GRN=>wG, BLU=>wB, HS=>HS, VS=>VS, HC1=>wHC, VC1=>wVC);
U5: FONT_ROM PORT MAP (CLK=>wCLK, ADDR=>wADDR, DATA=>wDATA);
U6: CLK_DIV PORT MAP (CLK_IN=>CLK_IN, CLK=>wCLK);
U7: RGB PORT MAP (vidon=>wvidon, RGB(2)=>wR, RGB(1)=>wG, RGB(0)=>wB, R1=>R1, G1=>G1, B1=>B1, MUX_IN=>wMUX_IN);
U8: MUX8TO1 PORT MAP (DATA=>wMux2mux, SEL=>wHC(2 DOWNTO 0),OUTPUT=>wMUX_IN);  
U9: blinker PORT MAP (clk=>wclk, addr_b=>waddr_b, cursor_adr=>wADDR_A, output=>wMux2Mux, font_rom=>wdata);
U10: we_delay PORT MAP(we_in=>wWE, we_out=>wWE_delay, clk=>wclk);
U11: NUM_TO_ASCII PORT MAP(CLK=>wCLK1, NUMBER=>EXT_MEM, ASCII=>wASCII, SEL_WE=>SEL_WE);
U12: MUX2TO1_DEBUGGER PORT MAP(WE=>'1',  rWE=>wWE_DELAY, SEL_WE=>SEL_WE, 
				NUM_TO_ASCII=>wASCII, rDIN_A=>wDIN_A, CURS_ADDR=>wADDR_FROM_INC, rCURS_ADDR=>wADDR_A,
   			WE_OUT=>wWE_OUT, DIN_A=>wDIN_A_OUT, ADDR_A=>wADDR_A_OUT);
U13: CURSOR_INCREMENTER PORT MAP(CURS_ADDR=>wADDR_A, SEL_WE=>SEL_WE, CLK=>wCLK1, ADDR=>wADDR_FROM_INC);
U14: CLK_DIV PORT MAP (CLK_IN=>wCLK, CLK=>wCLK1);
MUX_CURSOR<=wADDR_A;
ASCII<=wASCII;
end Structural;
