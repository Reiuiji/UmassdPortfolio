----------------------------------------------------------------
-- Company: 	UMD ECE
-- Engineer: 	Fortier
-- 
-- Create Date:    2/7/2013 
-- Design Name: 
-- Module Name:    CURSOR_Control - Behavioral 
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
--------------------------------------------------------------------------CURSOR_control------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;----------------whatever is coming in from adr_a, on ram, will have cursor behavior
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use ieee.numeric_std.all;


entity cursor is
    Port ( scancode : in STD_LOGIC_VECTOR (7 downto 0); 
           we : in  STD_LOGIC;
			  enb : in std_logic;
			  cursor_adr2 : out STD_LOGIC_VECTOR (11 downto 0));
end cursor;

architecture Behavioral of cursor is
signal cursor_adr:  integer :=0;
begin
process(we)
variable count1, count2 : integer := 0;					
begin
--WE is only going active if something valid from ascii table comes in (see scan_to_ascii)

if we='0' and we' event then --once data is into tile memory (high to low transition)
	if scancode/=x"72" and scancode/=x"5A" and scancode/=x"75" and scancode/=x"6B" and scancode/=x"74" and scancode/=x"66" then
		count1:=count1+1;
		if count1=2 then
			if (cursor_adr<2400) then --2400=80x30
				cursor_adr<=cursor_adr+1;
			end if;
			count1:=0;
		end if;
	else
		count2:=count2+1;			
		if count2=2 then
			if (scancode=x"72") then--down arrow
				cursor_adr<=cursor_adr+80;-- 79 not 80 b/c by just hittin an arrow does the first if statement above as well
				if cursor_adr > 2400 then-- =2400
					cursor_adr<=2400;
				end if;
			elsif(scancode = x"5A") then -- Enter Key
				
					if (cursor_adr< 79)then
						cursor_adr <= 80;
					elsif (cursor_adr < 159)then
						cursor_adr <= 160;
					elsif (cursor_adr < 239)then
						cursor_adr <= 240;
					elsif (cursor_adr < 319)then
						cursor_adr <= 320;
					elsif (cursor_adr < 399)then
						cursor_adr <= 400;
					elsif (cursor_adr < 479)then
						cursor_adr <= 480;
					elsif (cursor_adr < 559)then
						cursor_adr <= 560;
					elsif (cursor_adr < 639)then
						cursor_adr <= 640;
					elsif (cursor_adr < 719)then
						cursor_adr <= 720;
					elsif (cursor_adr < 799)then
						cursor_adr <= 800;
					elsif (cursor_adr < 879)then
						cursor_adr <= 880;
					elsif (cursor_adr < 959)then
						cursor_adr <= 960;
					elsif (cursor_adr < 1039)then
						cursor_adr <= 1040;
					elsif (cursor_adr < 1119)then
						cursor_adr <= 1120;
					elsif (cursor_adr < 1199)then
						cursor_adr <= 1200;
					elsif (cursor_adr < 1279)then
						cursor_adr <= 1280;
					elsif (cursor_adr < 1259)then
						cursor_adr <= 1360;
					elsif (cursor_adr < 1339)then
						cursor_adr <= 1440;
					elsif (cursor_adr < 1519)then
						cursor_adr <= 1520;
					elsif (cursor_adr < 1599)then
						cursor_adr <= 1600;
					elsif (cursor_adr < 1679)then
						cursor_adr <= 1680;
					elsif (cursor_adr < 1759)then
						cursor_adr <= 1760;
					elsif (cursor_adr < 1839)then
						cursor_adr <= 1840;
					elsif (cursor_adr < 1919)then
						cursor_adr <= 1920;
					elsif (cursor_adr < 1999)then
						cursor_adr <= 2000;
					elsif (cursor_adr < 2079)then
						cursor_adr <= 2080;
					elsif (cursor_adr < 2159)then
						cursor_adr <= 2160;
					elsif (cursor_adr < 2239)then
						cursor_adr <= 2240;
					elsif (cursor_adr < 2319)then
						cursor_adr <= 2320;
					elsif (cursor_adr < 2399)then
						cursor_adr <= 2400;
					end if;
					
				
			elsif(scancode = x"75") then--up arrow
				cursor_adr<=cursor_adr-80;
				if cursor_adr < 0 then
					cursor_adr<=0;
				end if;
			elsif(scancode = x"6B") then --left arrow
				cursor_adr<=cursor_adr-1;
				if cursor_adr < 0 then
					cursor_adr<=0;
				end if;
			elsif(scancode = x"74") then -- right arrow
				cursor_adr<=cursor_adr+1;
				if cursor_adr > 2400 then-- =2400
					cursor_adr<=2400;
				end if;
			elsif(scancode= x"66") then --delete
				cursor_adr<=cursor_adr-1;
				if cursor_adr < 0 then
					cursor_adr<=0;
	 
				end if;
			
			end if;
			
	count2:=0;
		end if;
		
	end if;
end if;

end process;
cursor_adr2<=conv_std_logic_vector(cursor_adr, 12);
end Behavioral;

