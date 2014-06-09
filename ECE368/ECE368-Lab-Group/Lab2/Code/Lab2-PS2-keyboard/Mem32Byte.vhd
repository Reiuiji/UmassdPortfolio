----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
--
-- Create Date:    Spring 2014
-- Module Name:    Mem32Byte
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Duel ACCESS memory
--
-- Notes:
-- 
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;   

entity Mem32Byte is
    Port ( CLOCK : in  STD_LOGIC;
           RESET : in  STD_LOGIC;
           ADDRESS_IN : in  STD_LOGIC_VECTOR(4 downto 0); --32bit selector address
           DATA_IN : in  STD_LOGIC_VECTOR(7 downto 0);
           ADDRESS_OUT : in  STD_LOGIC_VECTOR(4 downto 0); -- 32bit selector address
           DATA_OUT : out  STD_LOGIC_VECTOR(7 downto 0);
			  --READ_ENABLE : in STD_LOGIC; -- want to read
           WRITE_ENABLE : in  STD_LOGIC); -- check to be able to write to that address
end Mem32Byte;

architecture Behavioral of Mem32Byte is

	type ram_32B is array (0 to 31) -- 32 bytes
				of STD_LOGIC_VECTOR(7 downto 0);
	signal RAM: ram_32B :=(others => (others =>'0'));
begin

	mem_write: process(CLOCK, RESET, WRITE_ENABLE, ADDRESS_IN, DATA_IN)
	begin
		if RESET='1' then
			for i in RAM'range loop --zero 
				RAM(i) <= (others => '0');
			end loop;
		else
			if (CLOCK'event and (CLOCK = '1')) then
				if (WRITE_ENABLE='1') then
					RAM(conv_integer(ADDRESS_IN)) <= DATA_IN;
				end if;
			end if;
		end if;
	end process mem_write;

	mem_read: process(CLOCK, RESET, ADDRESS_OUT ) --, READ_ENABLE)
	begin
		if RESET='1' then
			DATA_OUT <= (OTHERS => '0');
		else
			if(CLOCK'event and (CLOCK='0') ) then
				--if (READ_ENABLE ='1') then
					DATA_OUT <= RAM(conv_integer(ADDRESS_OUT));
				--end if;
			end if;
		end if;
	end process mem_read;

end Behavioral;

