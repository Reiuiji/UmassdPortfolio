----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
--
-- Create Date:    SPRING 2014
-- Module Name:    UMD_LOAD_STORE_FPU
-- Project Name: 	 UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Arithmetic Logic Unit - Load/Store Unit.
-- 	Performs all memory operations.
--
--		Example for memory read/write instructions using only one register.
---------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity load_store_unit is

	Port (  CLK		: in 	STD_LOGIC;								-- 50 MHz Oscillator
			  OPCODE	: in 	STD_LOGIC_VECTOR (3 downto 0);	--	Opcode for current instruction
			  RA		: in 	STD_LOGIC_VECTOR (23 downto 0);	-- Memory input 1 
			  IMMED	: in 	STD_LOGIC_VECTOR (23 downto 0);	-- Memory input 2 (Since we are not indexing into memory, unused)
			  
           F 		: out STD_LOGIC_VECTOR  (23 downto 0)	-- 24-bit memory output
			  );	
			  
end load_store_unit;

architecture Behavioral of load_store_unit is

	-- Since this ALU memory block does not interface with the final machine's
	--	memory, we will use one 24-bit register to show the basic functionality
	--	of a load/store.
	signal memory_register : std_logic_vector (23 downto 0) := (OTHERS => '0');
	
	-- Decode opcode to determine when a load/store will occur. 
	-- Since we are multiplexing the output, we are free to read from memory
	--	on all cycles other than SW. Only on SW do we want to write into memory.
	-- 
	-- '1' = write, '0' = read
	signal wen : std_logic := '0';
begin

	-- Assign write enable based on current opcode
	wen <= '1' when opcode="1010" else '0';

	-- Write to memory register during rising clock edge of SW instruction
	process(clk)
	begin
		if (clk'event and clk='1') then
			if (wen = '1') then -- If current instruction is SW
				memory_register <= RA;
			end if;
		end if;
	end process;

	-- Output value in memory when we are not writing to it
	F <= memory_register;
	
end Behavioral;

