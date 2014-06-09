----------------------------------------------------------------------------------
-- School: University of Massachusetts Dartmouth
-- Department: Computer and Electrical Engineering
-- Class: ECE 368 Digital Design
-- Engineer: Daniel Noyes
--				 Massarrah Tannous
-- 
-- 
-- Create Date:    SPRING 2014
-- Module Name:    UMD_ALU_FPU
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:	 Xilinx ISE 14.7
-- Description: Debounce
-- 	Debounce switches
---------------------------------------
Library ieee;
USE ieee.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_UNSIGNED.all;

ENTITY DEBOUNCE IS
PORT (
  Clk       : IN STD_LOGIC;  		-- reduced system clock
  Key       : IN STD_LOGIC;  		-- active low input
  pulse     : OUT STD_LOGIC); 		--debounced output
END DEBOUNCE;

ARCHITECTURE clean_pulse OF DEBOUNCE IS
  SIGNAL cnt       :integer range 0 to 1000000 := 0;
BEGIN
  PROCESS (Clk,Key,cnt)
  BEGIN
    IF Key = '1' THEN
      cnt <= 0;
    ELSIF (clk'EVENT AND Clk = '1') THEN
      IF (cnt /= 1000000) THEN cnt <= cnt + 1; END IF;
    END IF;
    IF (cnt = 999999) AND (Key = '0') THEN pulse <= '1'; ELSE pulse <= '0'; END IF;
  END PROCESS;
END clean_pulse;
