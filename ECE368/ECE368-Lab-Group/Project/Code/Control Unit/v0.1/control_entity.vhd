LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

ENTITY control_entity IS
	PORT(
		--Is a control line required to determine which register I write to here if I don't define this in the ALU
		 ADD0		: OUT STD_LOGIC;
		 SUB0		: OUT STD_LOGIC;
		 AND0  	: OUT STD_LOGIC;
		 OR0 		: OUT STD_LOGIC;
		 MOV0		: OUT STD_LOGIC;
		 ADDI0	: OUT STD_LOGIC;
		 ANDI0	: OUT STD_LOGIC;
		 SL0		: OUT STD_LOGIC;
		 SR0		: OUT STD_LOGIC;
		 Opcode	: IN STD_LOGIC_VECTOR (3 DOWNTO 0);
		 Opcode_Out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
		 Write2Register : OUT STD_LOGIC;
		 Clock, Reset : IN STD_LOGIC;
		 Enable : IN STD_LOGIC
	);
END control_entity;
		 
ARCHITECTURE behavior OF control_entity IS 
		 
		SIGNAL ADD1, SUB1, AND1, OR1, MOV1, ADDI1, ANDI1, SL1, SR1 : STD_LOGIC := '0';

BEGIN

ADD1	<= '1' WHEN Opcode = "0000" ELSE '0';
SUB1	<= '1' WHEN Opcode = "0001" ELSE '0';
AND1	<= '1' WHEN Opcode = "0010" ELSE '0';
OR1	<= '1' WHEN Opcode = "0011" ELSE '0';
MOV1	<= '1' WHEN Opcode = "0100" ELSE '0';
ADDI1	<= '1' WHEN Opcode = "0101" ELSE '0';
ANDI1	<= '1' WHEN Opcode = "0110" ELSE '0'; 
SL1	<= '1' WHEN Opcode = "0111" ELSE '0'; 
SR1	<= '1' WHEN Opcode = "1000" ELSE '0'; 

PROCESS(Clock,Reset)
BEGIN
	if Reset = '1' THEN
		ADD0	<= '0';
		SUB0	<= '0';
		AND0	<= '0';
		OR0	<= '0';
		MOV0	<= '0';
		ADDI0	<= '0';
		ANDI0	<= '0';
		SL0	<= '0';
		SR0	<= '0';
		Opcode_Out <= "0000";
		Write2Register <= '0';
	elsif Enable ='1' then
		if Clock'Event and Clock = '1' then
			ADD0	<= ADD1;
			SUB0	<= SUB1;
			AND0	<= AND1;
			OR0	<= OR1;
			MOV0	<= MOV1;
			ADDI0	<= ADDI1;
			ANDI0	<= ANDI1;
			SL0	<= SL1;
			SR0	<= SR1;
			Opcode_Out <= Opcode;
			Write2Register <= ADD1 OR SUB1 OR AND1 OR OR1 OR MOV1 OR ADDI1 OR ANDI1 OR SL1 OR SR1;
		end if;
	end if;
end PROCESS;
END behavior;
