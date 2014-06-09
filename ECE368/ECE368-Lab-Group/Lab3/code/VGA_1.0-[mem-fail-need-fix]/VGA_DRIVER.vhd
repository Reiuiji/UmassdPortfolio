------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    Mem32Byte
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      [Description]
--
-- Notes:
--      [Insert Notes]
--
-- Revision: 
--      0.01  - File Created
--      0.02  - [Insert]
--
-- Additional Comments: 
--      [Insert Comments]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity VGA_DRIVER is
    Port ( clkdiv, clr : in std_logic;
           hs : out std_logic;
           vs : out std_logic;
           red : out std_logic;
           grn : out std_logic;
           blu : out std_logic;
		vidon1 : out std_logic;
		   hc1, vc1 : out std_logic_vector(9 downto 0));
			  
end VGA_DRIVER;


architecture Behavioral of VGA_DRIVER is

constant hpixels: std_logic_vector(9 downto 0) := "1100100000";	 	--Value of pixels in a horizontal line = 800

constant vlines: std_logic_vector(9 downto 0) := "1000001001";	 	--Number of horizontal lines in the display = 521
	
constant hbp: std_logic_vector(9 downto 0) := "0010010000";	 
	--Horizontal back porch = 144 (128+16)

constant hfp: std_logic_vector(9 downto 0) := "1100010000";	 
	--Horizontal front porch = 784 (128+16+640)

constant vbp: std_logic_vector(9 downto 0) := "0000011111";	 
	--Vertical back porch = 31 (2+29)

constant vfp: std_logic_vector(9 downto 0) := "0111111111";	 
	--Vertical front porch = 511 (2+29+480)
	
signal hc, vc: std_logic_vector(9 downto 0):= "0000000000";--These are the Horizontal and Vertical counters




signal vsenable, vidon: std_logic;--Enable for the Vertical counter

signal pixel_x, pixel_y : std_logic_vector(9 downto 0):="0000000000";

begin			
	
--Runs the horizontal counter
  process(clkdiv)
  begin
	if clr = '1' then
	   hc <= "0000000000";
	elsif(clkdiv = '1' and clkdiv'EVENT) then
	   if hc = hpixels then						   --If the counter has reached the end of pixel count
		hc <= "0000000000";							--reset the counter
		vsenable <= '1';							--Enable the vertical counter to increment
	   else
		hc <= hc + 1;								--Increment the horizontal counter
		vsenable <= '0';							--Leave the vsenable off
	   end if;
	end if;
  end process;

  hs <= '0' when hc(9 downto 7) = "000" else '1';		
  --Horizontal Sync Pulse is low when hc is 0 - 127


--Runs the vertical counter
process(clkdiv)
begin
   if clr = '1' then
	vc <= "0000000000";
   elsif(clkdiv = '1' and clkdiv'EVENT and vsenable = '1') then
   --Increment when enabled
	if vc = vlines then							--Reset when the number of lines is reached
	   vc <= "0000000000";
	else vc <= vc + 1;	--Increment the vertical counter
	end if;
   end if;
end process;

vs <= '0' when vc(9 downto 1) = "000000000" else '1';		
--Vertical Sync Pulse is low when vc is 0 or 1


red <= '1' when (hc = "1010101100" and vidon ='1') else '0';
--Red pixel on at a horizontal count = 684 = 144 + 540

grn <= '1' when (hc = "0100000100" and vidon ='1') else '0';
--Green pixel on at a horizontal count = 260 = 144 + 116

blu <= '1' when (vc = "0100100001" and vidon ='1') else '0';
--Blue pixel on at a vertical count = 289 = 31 + 258

vidon <= '1' when (((hc < hfp) and (hc > hbp)) and ((vc < vfp) and (vc > vbp))) else '0';	
--Enable video out when within the porches

process(clkdiv)
begin
if(clkdiv = '1' and clkdiv'EVENT) then
if(hc>hbp and hc<hfp) then
	pixel_x<=pixel_x+1;

elsif(hc=hfp) then
	pixel_x<="0000000000";
end if;

if(vc>vbp and vc<vfp and vsenable='1') then
	pixel_y<=pixel_y+1;

elsif(vc=vfp) then
	pixel_y<="0000000000";
end if;
end if;
end process;

hc1<=pixel_x;
vc1<=pixel_y;
vidon1<=vidon;



end Behavioral;
