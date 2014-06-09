----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineers: 		Benjamin Doiron and Keith Kevelson
-- 
-- Create Date:   	2/22/2014 
-- Design Name: 
-- Module Name:   	CURSOR_Control - Behavioral
-- Project Name: 		VGA
-- Target Devices: 	Spartan 3E
-- Tool versions: 	Xilinx ISE 14.7
-- Description: 
--
-- Dependencies: 
--
-- Revision: 0.02
-- Revision 0.01: 	File Created
-- Revision 0.02: 	First modification for Lab #3
-- Comments: 			Initial design and code by Professor Fortier
--							Created on 2/7/2013
----------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;----------------whatever is coming in from adr_a, on ram, will have cursor behavior
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.all;

entity cursor is
    Port ( 
				scancode 		: in 	STD_LOGIC_VECTOR (7 downto 0); -- The input keycode
				we 				: in 	STD_LOGIC; -- The write enable
				enb 				: in 	STD_LOGIC; -- The enable
				cursor_adr2 	: out STD_LOGIC_VECTOR (11 downto 0) -- The cursor address
			 );
end cursor;

architecture Behavioral of cursor is
signal cursor_adr:  integer :=0;
begin
process(we)
variable count1, count2 : integer := 0;					
begin
--WE is only going active if something valid from ascii table comes in (see scan_to_ascii) 
if we='0' and we' event then --once data is into tile memory (high to low transition)
	if  scancode/=x"74" and scancode/=x"5A" and scancode/=x"6B" and scancode/=x"66" and scancode/=x"72" and scancode/=x"75" then
		count1:=count1+1;
		if count1=2 then
				if   		(cursor_adr =   78 or cursor_adr =   79) then cursor_adr <=   78;
				elsif 	(cursor_adr =  158 or cursor_adr =  159) then cursor_adr <=  158;
				elsif 	(cursor_adr =  238 or cursor_adr =  239) then cursor_adr <=  238;
				elsif 	(cursor_adr =  318 or cursor_adr =  319) then cursor_adr <=  318;
				elsif 	(cursor_adr =  398 or cursor_adr =  399) then cursor_adr <=  398;
				elsif 	(cursor_adr =  478 or cursor_adr =  479) then cursor_adr <=  478;
				elsif 	(cursor_adr =  558 or cursor_adr =  559) then cursor_adr <=  558;
				elsif 	(cursor_adr =  638 or cursor_adr =  639) then cursor_adr <=  638;
				elsif 	(cursor_adr =  718 or cursor_adr =  719) then cursor_adr <=  718;
				elsif 	(cursor_adr =  798 or cursor_adr =  799) then cursor_adr <=  798;
				elsif 	(cursor_adr =  878 or cursor_adr =  879) then cursor_adr <=  878;
				elsif 	(cursor_adr =  958 or cursor_adr =  959) then cursor_adr <=  958;
				elsif 	(cursor_adr = 1038 or cursor_adr = 1039) then cursor_adr <= 1038;
				elsif 	(cursor_adr = 1118 or cursor_adr = 1119) then cursor_adr <= 1118;
				elsif 	(cursor_adr = 1198 or cursor_adr = 1199) then cursor_adr <= 1198;
				elsif 	(cursor_adr = 1278 or cursor_adr = 1279) then cursor_adr <= 1278;
				elsif 	(cursor_adr = 1358 or cursor_adr = 1359) then cursor_adr <= 1358;
				elsif 	(cursor_adr = 1438 or cursor_adr = 1439) then cursor_adr <= 1438;
				elsif 	(cursor_adr = 1518 or cursor_adr = 1519) then cursor_adr <= 1518;
				elsif 	(cursor_adr = 1598 or cursor_adr = 1599) then cursor_adr <= 1598;
				elsif 	(cursor_adr = 1678 or cursor_adr = 1679) then cursor_adr <= 1678;
				elsif 	(cursor_adr = 1758 or cursor_adr = 1759) then cursor_adr <= 1758;
				elsif 	(cursor_adr = 1838 or cursor_adr = 1839) then cursor_adr <= 1838;
				elsif 	(cursor_adr = 1918 or cursor_adr = 1919) then cursor_adr <= 1918;
				elsif 	(cursor_adr = 1998 or cursor_adr = 1999) then cursor_adr <= 1998;
				elsif 	(cursor_adr = 2078 or cursor_adr = 2079) then cursor_adr <= 2078;
				elsif 	(cursor_adr = 2158 or cursor_adr = 2159) then cursor_adr <= 2158;
				elsif 	(cursor_adr = 2238 or cursor_adr = 2239) then cursor_adr <= 2238;
				elsif 	(cursor_adr = 2318 or cursor_adr = 2319) then cursor_adr <= 2318;
				elsif 	(cursor_adr = 2398 or cursor_adr = 2399) then cursor_adr <= 2398;
				elsif    (cursor_adr > 2400) then cursor_adr <= 2400;
				else		cursor_adr <= cursor_adr+1;
				end if;
			count1:=0;
		end if;

	else
		count2:=count2+1;			
		if count2=2 then
		
			if(scancode = x"5a") then													-- IF THE ENTER KEY IS PRESSED
					if   		(cursor_adr <   79) then cursor_adr <=   80;
					elsif 	(cursor_adr <  159) then cursor_adr <=  160;
					elsif 	(cursor_adr <  239) then cursor_adr <=  240;
					elsif 	(cursor_adr <  319) then cursor_adr <=  320;
					elsif 	(cursor_adr <  399) then cursor_adr <=  400;
					elsif 	(cursor_adr <  479) then cursor_adr <=  480;
					elsif 	(cursor_adr <  559) then cursor_adr <=  560;
					elsif 	(cursor_adr <  639) then cursor_adr <=  640;
					elsif 	(cursor_adr <  719) then cursor_adr <=  720;
					elsif 	(cursor_adr <  799) then cursor_adr <=  800;
					elsif 	(cursor_adr <  879) then cursor_adr <=  880;
					elsif 	(cursor_adr <  959) then cursor_adr <=  960;
					elsif 	(cursor_adr < 1039) then cursor_adr <= 1040;
					elsif 	(cursor_adr < 1119) then cursor_adr <= 1120;
					elsif 	(cursor_adr < 1199) then cursor_adr <= 1200;
					elsif 	(cursor_adr < 1279) then cursor_adr <= 1280;
					elsif 	(cursor_adr < 1359) then cursor_adr <= 1360;
					elsif 	(cursor_adr < 1439) then cursor_adr <= 1440;
					elsif 	(cursor_adr < 1519) then cursor_adr <= 1520;
					elsif 	(cursor_adr < 1599) then cursor_adr <= 1600;
					elsif 	(cursor_adr < 1679) then cursor_adr <= 1680;
					elsif 	(cursor_adr < 1759) then cursor_adr <= 1760;
					elsif 	(cursor_adr < 1839) then cursor_adr <= 1840;
					elsif 	(cursor_adr < 1919) then cursor_adr <= 1920;
					elsif 	(cursor_adr < 1999) then cursor_adr <= 2000;
					elsif 	(cursor_adr < 2079) then cursor_adr <= 2080;
					elsif 	(cursor_adr < 2159) then cursor_adr <= 2160;
					elsif 	(cursor_adr < 2239) then cursor_adr <= 2240;
					elsif 	(cursor_adr < 2319) then cursor_adr <= 2320;
					elsif 	(cursor_adr < 2399) then cursor_adr <= 2400;
					end if;


			elsif(scancode = x"6B") then cursor_adr<=cursor_adr-1;			-- IF THE LEFT ARROW IS PRESSED
					if   		(cursor_adr <    0) then cursor_adr <=    0;
					elsif		(cursor_adr =   80) then cursor_adr <=   80;
					elsif		(cursor_adr =  160) then cursor_adr <=  160;
					elsif		(cursor_adr =  240) then cursor_adr <=  240;
					elsif		(cursor_adr =  320) then cursor_adr <=  320;
					elsif		(cursor_adr =  400) then cursor_adr <=  400;
					elsif		(cursor_adr =  480) then cursor_adr <=  480;
					elsif		(cursor_adr =  560) then cursor_adr <=  560;
					elsif		(cursor_adr =  640) then cursor_adr <=  640;
					elsif		(cursor_adr =  720) then cursor_adr <=  720;
					elsif		(cursor_adr =  800) then cursor_adr <=  800;
					elsif		(cursor_adr =  880) then cursor_adr <=  880;
					elsif		(cursor_adr =  960) then cursor_adr <=  960;
					elsif		(cursor_adr = 1040) then cursor_adr <= 1040;
					elsif		(cursor_adr = 1120) then cursor_adr <= 1120;
					elsif		(cursor_adr = 1200) then cursor_adr <= 1200;
					elsif		(cursor_adr = 1280) then cursor_adr <= 1280;
					elsif		(cursor_adr = 1360) then cursor_adr <= 1360;
					elsif		(cursor_adr = 1440) then cursor_adr <= 1440;
					elsif		(cursor_adr = 1520) then cursor_adr <= 1520;
					elsif		(cursor_adr = 1600) then cursor_adr <= 1600;
					elsif		(cursor_adr = 1680) then cursor_adr <= 1680;
					elsif		(cursor_adr = 1760) then cursor_adr <= 1760;
					elsif		(cursor_adr = 1840) then cursor_adr <= 1840;
					elsif		(cursor_adr = 1920) then cursor_adr <= 1920;
					elsif		(cursor_adr = 2000) then cursor_adr <= 2000;
					elsif		(cursor_adr = 2080) then cursor_adr <= 2080;
					elsif		(cursor_adr = 2160) then cursor_adr <= 2160;
					elsif		(cursor_adr = 2240) then cursor_adr <= 2240;
					elsif		(cursor_adr = 2320) then cursor_adr <= 2320;
					elsif 	(cursor_adr = 2400) then cursor_adr <= 2400;
					end if;
				
				
			elsif(scancode = x"74") then cursor_adr<=cursor_adr+1;			-- IF THE RIGHT ARROW IS PRESSED
					if   		(cursor_adr =   79) then cursor_adr <=   79;
					elsif 	(cursor_adr =  159) then cursor_adr <=  159;
					elsif 	(cursor_adr =  239) then cursor_adr <=  239;
					elsif 	(cursor_adr =  319) then cursor_adr <=  319;
					elsif 	(cursor_adr =  399) then cursor_adr <=  399;
					elsif 	(cursor_adr =  479) then cursor_adr <=  479;
					elsif 	(cursor_adr =  559) then cursor_adr <=  559;
					elsif 	(cursor_adr =  639) then cursor_adr <=  639;
					elsif 	(cursor_adr =  719) then cursor_adr <=  719;
					elsif 	(cursor_adr =  799) then cursor_adr <=  799;
					elsif 	(cursor_adr =  879) then cursor_adr <=  879;
					elsif 	(cursor_adr =  959) then cursor_adr <=  959;
					elsif 	(cursor_adr = 1039) then cursor_adr <= 1039;
					elsif 	(cursor_adr = 1119) then cursor_adr <= 1119;
					elsif 	(cursor_adr = 1199) then cursor_adr <= 1199;
					elsif 	(cursor_adr = 1279) then cursor_adr <= 1279;
					elsif 	(cursor_adr = 1359) then cursor_adr <= 1359;
					elsif 	(cursor_adr = 1439) then cursor_adr <= 1439;
					elsif 	(cursor_adr = 1519) then cursor_adr <= 1519;
					elsif 	(cursor_adr = 1599) then cursor_adr <= 1599;
					elsif 	(cursor_adr = 1679) then cursor_adr <= 1679;
					elsif 	(cursor_adr = 1759) then cursor_adr <= 1759;
					elsif 	(cursor_adr = 1839) then cursor_adr <= 1839;
					elsif 	(cursor_adr = 1919) then cursor_adr <= 1919;
					elsif 	(cursor_adr = 1999) then cursor_adr <= 1999;
					elsif 	(cursor_adr = 2079) then cursor_adr <= 2079;
					elsif 	(cursor_adr = 2159) then cursor_adr <= 2159;
					elsif 	(cursor_adr = 2239) then cursor_adr <= 2239;
					elsif 	(cursor_adr = 2319) then cursor_adr <= 2319;
					elsif 	(cursor_adr = 2399) then cursor_adr <= 2399;
					elsif    (cursor_adr > 2400) then cursor_adr <= 2400;
					end if;


			elsif(scancode = x"66") then cursor_adr<=cursor_adr-1;			-- IF THE DELETE KEY IS PRESSED
					if   		(cursor_adr <    0) then cursor_adr <=    0;
					elsif		(cursor_adr =   80) then cursor_adr <=   80;
					elsif		(cursor_adr =  160) then cursor_adr <=  160;
					elsif		(cursor_adr =  240) then cursor_adr <=  240;
					elsif		(cursor_adr =  320) then cursor_adr <=  320;
					elsif		(cursor_adr =  400) then cursor_adr <=  400;
					elsif		(cursor_adr =  480) then cursor_adr <=  480;
					elsif		(cursor_adr =  560) then cursor_adr <=  560;
					elsif		(cursor_adr =  640) then cursor_adr <=  640;
					elsif		(cursor_adr =  720) then cursor_adr <=  720;
					elsif		(cursor_adr =  800) then cursor_adr <=  800;
					elsif		(cursor_adr =  880) then cursor_adr <=  880;
					elsif		(cursor_adr =  960) then cursor_adr <=  960;
					elsif		(cursor_adr = 1040) then cursor_adr <= 1040;
					elsif		(cursor_adr = 1120) then cursor_adr <= 1120;
					elsif		(cursor_adr = 1200) then cursor_adr <= 1200;
					elsif		(cursor_adr = 1280) then cursor_adr <= 1280;
					elsif		(cursor_adr = 1360) then cursor_adr <= 1360;
					elsif		(cursor_adr = 1440) then cursor_adr <= 1440;
					elsif		(cursor_adr = 1520) then cursor_adr <= 1520;
					elsif		(cursor_adr = 1600) then cursor_adr <= 1600;
					elsif		(cursor_adr = 1680) then cursor_adr <= 1680;
					elsif		(cursor_adr = 1760) then cursor_adr <= 1760;
					elsif		(cursor_adr = 1840) then cursor_adr <= 1840;
					elsif		(cursor_adr = 1920) then cursor_adr <= 1920;
					elsif		(cursor_adr = 2000) then cursor_adr <= 2000;
					elsif		(cursor_adr = 2080) then cursor_adr <= 2080;
					elsif		(cursor_adr = 2160) then cursor_adr <= 2160;
					elsif		(cursor_adr = 2240) then cursor_adr <= 2240;
					elsif		(cursor_adr = 2320) then cursor_adr <= 2320;
					elsif 	(cursor_adr = 2400) then cursor_adr <= 2400;
					end if;
					
			elsif (scancode=x"72") then--down arrow	-- Error, scancode given was F1
				cursor_adr 	<= cursor_adr;
					
			elsif(scancode = x"75") then--up arrow -- Error, scancode given was F2
				cursor_adr	<=	cursor_adr;
				
			end if;
			
	count2:=0;
		end if;
		
	end if;
end if;

end process;
cursor_adr2<=conv_std_logic_vector(cursor_adr, 12);
end Behavioral;

