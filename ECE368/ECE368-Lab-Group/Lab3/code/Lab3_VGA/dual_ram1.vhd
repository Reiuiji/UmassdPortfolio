----------------------------------------------------------------
-- Company: 		UMD ECE
-- Engineer: 		Fortier
-- 
-- Create Date:    	2/7/2013 
-- Design Name: 
-- Module Name:    	Dual-port RAM with synchronous read
-- 				Modified from XST 8.1i rams_11
-- Project Name: 	VGA
-- Target Devices: 	Spartan 3E
-- Tool versions: 	Xilinx ISE 10.1
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity xilinx_dual_port_ram_sync is
   generic(
      ADDR_WIDTH: integer:=12;
      DATA_WIDTH:integer:=7
   );
   port(
      clk: in std_logic;
      we: in std_logic;
		CLR : in std_logic;
      addr_a: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      addr_b: in std_logic_vector(ADDR_WIDTH-1 downto 0);
      din_a: in std_logic_vector(DATA_WIDTH-1 downto 0);
--		dout_a: out std_logic_vector(DATA_WIDTH-1 downto 0);
		dout_b: out std_logic_vector(DATA_WIDTH-1 downto 0)
   );
end xilinx_dual_port_ram_sync;

architecture beh_arch of xilinx_dual_port_ram_sync is
   type ram_type is array (0 to 2**ADDR_WIDTH-1)
        of std_logic_vector (DATA_WIDTH-1 downto 0);
   signal ram: ram_type;--:=(others=> x"03");
   signal addr_a_reg, addr_b_reg:
          std_logic_vector(ADDR_WIDTH-1 downto 0);
	signal current_data : std_logic_vector(6 downto 0);
begin
   process(clk)
   begin
		if(clr = '1') then
--			ram(to_integer(unsigned(addr_b_reg))) <= x"00";
--			for i in ram'range loop --zero 
--				ram(i) <= (others => '0');
--			end loop;
		else
		  if (clk'event and clk = '1') then
			  if (we = '1') then
				  ram(to_integer(unsigned(addr_a))) <= din_a;
			  end if;
			  addr_a_reg <= addr_a;
			  addr_b_reg <= addr_b;
		  end if;
		end if;
   end process;
--	dout_a <= ram(to_integer(unsigned(addr_a_reg)));
   dout_b <= ram(to_integer(unsigned(addr_b_reg)));
	
--process(clk)---------for blinking of cursor---------

--variable count : integer;
--begin	
--if clk' event and clk='1'then
--	if ram (to_integer(unsigned(addr_a_reg))) /= "0000001" then
--	current_data <= ram (to_integer(unsigned(addr_a_reg)));
--	end if;

--	if ram (to_integer(unsigned(addr_a_reg)))= current_data or ram (to_integer(unsigned(addr_a_reg)))= "0000001" then 
--			count:=count+1;
		
--		if count=20000000 then--blink at a little over half second rate
--			if(ram (to_integer(unsigned(addr_a_reg)))= current_data) then
--				ram (to_integer(unsigned(addr_a_reg)))<="0000001";
	
--			elsif(ram (to_integer(unsigned(addr_a_reg)))= "0000001") then
--				ram (to_integer(unsigned(addr_a_reg)))<= current_data;
--			end if;
--			count:=0;
--		end if; 
--	end if;
--end if;
--end process;
end beh_arch;