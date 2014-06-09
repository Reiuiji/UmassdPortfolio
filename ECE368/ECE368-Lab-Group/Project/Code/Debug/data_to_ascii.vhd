--------------------------------------------------------------------------------
-- Company: 	  UMD ECE
-- Engineers:	  Daniel Noyes, Benjamin Doiron
--
-- Create Date:   10:35:25 03/23/2014
-- Design Name:   Transfer
-- Module Name:   Transfer
-- Project Name:  Risc Machine Project 1
-- Target Device: Spartan 3E Board
-- Tool versions: Xilinx 14.7
-- Description:   
-- 
-- Revision:
-- Revision 0.01 - Dan: File Created (Majority of code)
-- Revision 0.02 - Ben: Reimplemented to suit current code (Minor fixing)
--
-- Additional Comments: 
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TRANSFER is
    port (
        CLOCK: in STD_LOGIC;
        Sent: in STD_LOGIC;
        INPUT: in STD_LOGIC_VECTOR(23 DOWNTO 0);
        OUTPUT: out STD_LOGIC_VECTOR(7 DOWNTO 0);
		  MUX_OUT: out STD_LOGIC_VECTOR(1 DOWNTO 0);
		  INST_SEND: out STD_LOGIC;
		  addressflag: out STD_LOGIC
    );
end TRANSFER;


Architecture TRANSFER_ARCH of TRANSFER is

    type transfer_state is (init, s0, s1, s2, s3, s4, s5);
    signal T_state: transfer_state;
    signal TOASCII: STD_LOGIC_VECTOR(3 DOWNTO 0);
	 signal MUXINC: integer range 0 to 3;
	 signal addr: integer range 0 to 30;
			 
begin
with TOASCII select
    OUTPUT <= 	x"30" when x"0", 	
					x"31" when x"1",  
					x"32" when x"2",  
					x"33" when x"3",  
					x"34" when x"4",  
					x"35" when x"5",  
					x"36" when x"6",  
					x"37" when x"7",  
					x"38" when x"8",  
					x"39" when x"9",  
					x"41" when x"A",	
					x"42" when x"B",	
					x"43" when x"C",	
					x"44" when x"D",	
					x"45" when x"E",	
					x"46" when x"F",	
					x"00" when others;
				 
P1:process(clock)        -- exec. Once when clock rises

    begin
    if (clock'event and clock='1') then

    case T_state is
        when init =>
            if Sent='1' then
                T_state <= s0;
					 INST_SEND <= '0';
            else
                T_state <= init;
					 INST_SEND <= '0';
            end if;

        when s0 =>
            if Sent='1' then
                T_state <= s1;
            else
                T_state <= init;
            end if;

        when s1 =>
            if Sent='1' then
                T_state <= s2;
            else
                T_state <= init;
            end if;

        when s2 =>
            if Sent='1' then
                T_state <= s3;
            else
                T_state <= init;
            end if;

        when s3 =>
            if Sent='1' then
                T_state <= s4;
            else
                T_state <= init;
            end if;

        when s4 =>
            if Sent='1' then
                T_state <= s5;
            else
                T_state <= init;
            end if;

        when s5 =>
					if MUXINC = 0 then
						MUX_OUT <= "01";
						MUXINC <= 1;
						T_state <= init;
						
					elsif MUXINC = 1 then 
						MUX_OUT <= "10";
						MUXINC <= 2;
						T_state <= init;
						
					elsif MUXINC = 2 then 
						MUX_OUT <= "11";
						MUXINC <= 3;				
						T_state <= init;
						
					elsif MUXINC = 3 then 
						MUX_OUT <= "00";
						MUXINC <= 0;
						INST_SEND <= '1';						
						T_state <= init;
						addressflag <= '1';
					end if;
					
    end case ;
    end if;
end process;

p2:process(T_state) -- combin. process
    begin case (T_state) is
          when init => TOASCII <= "ZZZZ";
          when s0 => TOASCII <= INPUT(23 DOWNTO 20);
          when s1 => TOASCII <= INPUT(19 DOWNTO 16);
          when s2 => TOASCII <= INPUT(15 DOWNTO 12);
          when s3 => TOASCII <= INPUT(11 DOWNTO 8);
          when s4 => TOASCII <= INPUT(7 DOWNTO 4);
          when s5 => TOASCII <= INPUT(3 DOWNTO 0);
    end case;
end process;
end TRANSFER_ARCH;
