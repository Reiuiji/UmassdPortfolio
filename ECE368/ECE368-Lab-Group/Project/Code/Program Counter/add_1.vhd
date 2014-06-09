------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    incermenter (+1)
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--
-- Notes:
--      +1 the given input to output
--
-- Revision: 
--      0.01  - File Created
--      0.02  - Clean up Code Layout
--
-- Additional Comments: 
--      [None]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.UMDRISC_pkg.ALL;

entity add_1 is

	Port (
		INPUT	: in 	STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0);	-- Input
		OUTPUT	: out 	STD_LOGIC_VECTOR (PC_WIDTH-1 downto 0)  -- Output
	);

end add_1;

architecture Combinational of add_1 is

begin
    
    OUTPUT <= INPUT + X"1";

end Combinational;

