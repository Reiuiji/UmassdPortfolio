LIBRARY ieee;
USE ieee.std_logic_1164.all;     
USE ieee.std_logic_arith.all ;
entity KeytoAscii is
	 port(
		kk : in STD_LOGIC_VECTOR(7 downto 0);
 
		valid: in STD_LOGIC; 
		complete: out STD_LOGIC;
		 asc : out STD_LOGIC_VECTOR(7 downto 0) 
	     );
end KeytoAscii;

architecture dataflow of KeytoAscii is
	
	shared variable isShift : boolean := false;
	shared variable isBreak : boolean := false;
	shared variable isBreakShift : boolean := false;
	shared variable justShifted : boolean := false;
begin

	process(kk,valid)
	
	BEGIN
	
	
	--kk_OUT <= KK;
	if (valid= '1' AND  valid'EVENT ) then
			complete <= '0';
	 
			if (kk = x"F0" ) then  --break code
				isBreak := true; 
				justShifted :=TRUE;
				
			elsif ((kk = x"12" OR  kk= x"59") AND  isBreak = false) then  -- L shift: x12, R shift: x59
				isShift := true ;
				justShifted :=true;
					
			elsif ((kk = x"12" OR  kk= x"59") AND  isBreak = true) then  -- L shift: x12, R shift: x59
				isShift := false ;
				justShifted :=TRUE;
			end if;
			
			if (justShifted = false) then
			if (isBreak = false ) then 
				if (isShift = true ) then
					case kk is
						when x"0E" =>
							asc<="01111110"; -- ~, SHIFT `
						when x"16" =>
							asc<="00100001"; -- !, SHIFT 1
						when x"4c" =>
							asc<="00111010"; -- :, SHIFT ; 
						when x"1E" =>
							asc<="01000000"; -- @
						when x"26" =>
							asc<="00100011"; -- #
						when x"25" =>
							asc<="00100100"; -- $
						when x"2E" =>
							asc<="00100101"; -- %
						when x"36" =>
							asc<="01011110"; -- ^
						when x"3D" =>
							asc<="00100110"; -- &
						when x"3E" =>
							asc<="00101010"; -- *
						when x"46" =>
							asc<="00101000"; --(
						when x"45" =>
							asc<="00101001"; -- )
						when x"55" =>
							asc<="00101011"; -- +
						when x"4E" =>
							asc<="01011111"; -- _
						when x"54" =>
							asc<="01111011"; -- {
						when x"5D" =>
							asc<="01111100"; -- |
						when x"5B" =>
							asc<="01111101"; -- }
						when x"52" =>
							asc<="00100010"; -- "
						when x"4A" =>
							asc<="00111111"; -- ?
						when x"41" =>
							asc<="00111100"; -- <
						when x"49" =>
							asc<="00111110"; -- >
						when x"1C" =>
								asc<="01000001"; -- A
						when x"32" =>
								asc<="01000010"; -- B
						when x"21" =>
								asc<="01000011"; -- C
						when x"23" =>
								asc<="01000100"; -- D
						when x"24" =>
								asc<="01000101"; -- E
						when x"2B" =>
								asc<="01000110"; -- F
						when x"34" =>
								asc<="01000111"; -- G
						when x"33" =>
								asc<="01001000"; -- H
						when x"43" =>
								asc<="01001001"; -- I
						when x"3B" =>
								asc<="01001010"; -- J
						when x"42" =>
								asc<="01001011"; -- K
						when x"4B" =>
								asc<="01001100"; -- L
						when x"3A" =>
								asc<="01001101"; -- M
						when x"31" =>
								asc<="01001110"; -- N
						when x"44" =>
								asc<="01001111"; -- O
						when x"4D" =>
								asc<="01010000"; -- P
						when x"15" =>
								asc<="01010001"; -- Q
						when x"2D" =>
								asc<="01010010"; -- R
						when x"1B" =>
								asc<="01010011"; -- S
						when x"2C" =>
								asc<="01010100"; -- T
						when x"3C" =>
								asc<="01010101"; -- U
						when x"2A" =>
								asc<="01010110"; -- V
						when x"1D" =>
								asc<="01010111"; -- W
						when x"22" =>
								asc<="01011000"; -- X
						when x"35" =>
								asc<="01011001"; -- Y
						when x"1A" =>
								asc<="01011010"; -- Z
						when others =>
								asc<="00000000"; 
					end case;
					complete <= '1';
					--isShift := false;
				else
					case kk is
						when x"52" =>
								asc<="00100111"; -- '
						when x"41" =>
								asc<="00101100"; -- ,
						when x"0E" =>
								asc<="01100000"; -- `
						when x"4E" =>
								asc<="00101101"; -- -
						when x"49" =>
								asc<="00101110"; -- .
						when x"4A" =>
								asc<="00101111"; -- /
						when x"54" =>
								asc<="01011011"; -- [
						when x"5D" =>
								asc<="01011100"; -- \
						when x"5B" =>
								asc<="01011101"; -- ]
						when x"29" =>
								asc<="00100000"; -- space
						when x"4C" =>
								asc<="00111011"; -- ;
						when x"55" =>
								asc<="00111101"; -- =
						when x"45" =>
								asc<="00110000"; -- 0
						when x"16" =>
								asc<="00110001"; -- 1
						when x"1E" =>
								asc<="00110010"; -- 2
						when x"26" =>
								asc<="00110011"; -- 3
						when x"25" =>
								asc<="00110100"; -- 4
						when x"2E" =>
								asc<="00110101"; -- 5
						when x"36" =>
								asc<="00110110"; -- 6
						when x"3D" =>
								asc<="00110111"; -- 7
						when x"3E" =>
								asc<="00111000"; -- 8
						when x"46" =>
								asc<="00111001"; -- 9
						when x"1C" =>
								asc<="01100001"; -- a
						when x"32" =>
								asc<="01100010"; -- b
						when x"21" =>
								asc<="01100011"; -- c
						when x"23" =>
								asc<="01100100"; -- d
						when x"24" =>
								asc<="01100101"; -- e
						when x"2B" =>
								asc<="01100110"; -- f
						when x"34" =>
								asc<="01100111"; -- g
						when x"33" =>
								asc<="01101000"; -- h
						when x"43" =>
								asc<="01101001"; -- i
						when x"3B" =>
								asc<="01101010"; -- j
						when x"42" =>
								asc<="01101011"; -- k
						when x"4B" =>
								asc<="01101100"; -- l
						when x"3A" =>
								asc<="01101101"; -- m
						when x"31" =>
								asc<="01101110"; -- n
						when x"44" =>
								asc<="01101111"; -- o
						when x"4D" =>
								asc<="01110000"; -- p
						when x"15" =>
								asc<="01110001"; -- q
						when x"2D" =>
								asc<="01110010"; -- r
						when x"1B" =>
								asc<="01110011"; -- s
						when x"2C" =>
								asc<="01110100"; -- t
						when x"3C" =>
								asc<="01110101"; -- u
						when x"2A" =>
								asc<="01110110"; -- v
						when x"1D" =>
								asc<="01110111"; -- w
						when x"22" =>
								asc<="01111000"; -- x
						when x"35" =>
								asc<="01111001"; -- y
						when x"1A" =>
								asc<="01111010"; -- z
						when x"76" =>		
								asc<="01000101"; 	-- Esc
						when x"05"=>	
								asc<="00110001"; 	-- F1
						when x"06"=>	
								asc<="00110010"; 	-- F2
						when x"04"=>
								asc<="00110011"; 	-- F3
						when x"0C"=>
								asc<="00110100"; 	-- F4
						when x"03"=>
								asc<="00110101"; 	-- F5
						when x"0B"=>
								asc<="00110110"; 	-- F6
						when x"83"=>
								asc<="00110111"; 	-- F7
						when x"0A"=>
								asc<="00111000"; 	-- F8
						when x"01"=>
								asc<="00111001" ;-- F9
						when x"09"=>
								asc<="00110000" ;	-- F10
						when x"78"=>
								asc<="00110001"; 	-- F11
						when x"07"=>
								asc<="00110010" ;	-- F12
						when x"0D"=>
								asc<="01010100"; 	-- Tab
						when x"58"=>
								asc<="01000011"; 	-- Caps Lock
						when x"14"=>
								asc<="01000011" ;	-- Ctrl
						when x"11"=>
								asc<="01000001"; 	-- Alt
						when x"66"=>
								asc<="01000010" ;	-- Back Space
						when x"5A"=>	
								asc<="01000101"; 	-- Enter

						when others =>
								asc<="00000000"; --space
						end case;
						complete <= '1';
					end if;
					else 
						--if (isShift = false) then
							isBreak := false;
						--if (isShift = true AND (kk = x"12" OR  kk= x"59")) then
						--	isShift := false; 
						
						--end if;
				end if;
				else 
					justShifted :=false;
				end if;
			end if; 
	end process;
end architecture dataflow;


