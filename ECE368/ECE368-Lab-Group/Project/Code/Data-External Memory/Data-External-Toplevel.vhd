------------------------------------------------------------
-- School:     University of Massachusetts Dartmouth      --
-- Department: Computer and Electrical Engineering        --
-- Class:      ECE 368 Digital Design                     --
-- Engineer:   Daniel Noyes                               --
--             Massarrah Tannous                          --
------------------------------------------------------------
--
-- Create Date:    Spring 2014
-- Module Name:    DataMemory/External Memory Manager
-- Project Name:   UMD-RISC 24
-- Target Devices: Spartan-3E
-- Tool versions:  Xilinx ISE 14.7
--
-- Description:
--      Code was modified from Handout Code: Dr.Fortier(c)
--      [Description]
--
-- Notes:
--      [Insert Notes]
--
-- Revision: 
--      0.01  - File Created
--      0.02  - [Insert]
--
-- Additional Comments: 
--      [Insert Comments]
-- 
-----------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE work.UMDRISC_pkg.ALL;

entity DATA_EXT_MEM is
	Port (
		CLOCK			: in	STD_LOGIC;
		RESETN			: in	STD_LOGIC;
		ENABLE			: in	STD_LOGIC;
		
		--input Data to Data / External Memory
		STORE_DATA		: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- Store Data input
		ALU_IN	     	: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- Alu Input
		DST_ADDR		: in STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0); -- Destination address input
		LDST_IN			: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- load/store 
		INST_WD 		: in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- load/store 

        --External Access
        EX_IN           : in STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
        EX_OUT          : out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

        --CONTROL SIGNALS
		-- DATA MEMORY
        DATA_DIN_SEL	: in	STD_LOGIC; -- select data for data mem . 0: DST_DATA, 1: Store data
        DATA_ADDR_SEL	: in	STD_LOGIC; -- select address for data mem . 0: DST_ADDR, 1: ALU_IN
		DATA_RW			: in	STD_LOGIC; -- write to the data memory block
		--EXTERNAL MEMORY
		EXTM_DIN_SEL	: in	STD_LOGIC_VECTOR (1 downto 0); -- 3 mux. 0: LDST, 1: INSTWD, 2: EX_IN
		EXTM_ADDR_SEL	: in	STD_LOGIC;
		EXTM_RW			: in	STD_LOGIC; -- Write to the external memory block
		--Destination data
		DST_MUX_SEL		: in	STD_LOGIC_VECTOR (1 downto 0); -- 3 mux. 0: ALU_IN, 1: DATA_MEM, 2: EXT_MEM

		--OUTPUT
		DST_DATA_OUT		: out STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0); -- of destination data
		DST_ADDR_OUT		: out STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0) -- of destination Address
	);
end DATA_EXT_MEM;

architecture Structural of DATA_EXT_MEM is
SIGNAL DATA_DIN			: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL DATA_ADDR		: STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0);
SIGNAL EXTM_DIN			: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL EXTM_ADDR		: STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0);
SIGNAL DATA_OUT			: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL EXTM_OUT			: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);

SIGNAL DST_DATA_1		: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL DST_DATA_2		: STD_LOGIC_VECTOR (DATA_WIDTH-1 downto 0);
SIGNAL DST_ADDR_1		: STD_LOGIC_VECTOR (MEM_WIDTH-1 downto 0);


begin
EX_OUT <= EXTM_OUT;

--MUX units
	U_data_din_mux: entity work.MUX_2to1
	PORT MAP (
		SEL		=> DATA_DIN_SEL,
		IN_1	=> DST_DATA_2,
		IN_2	=> STORE_DATA,
		OUTPUT	=> DATA_DIN
	);

	U_data_addr_mux: entity work.MUX_2to1_8
	PORT MAP (
		SEL		=> DATA_ADDR_SEL,
		IN_1	=> DST_ADDR,
		IN_2	=> ALU_IN(MEM_WIDTH-1 downto 0),
		OUTPUT=> DATA_ADDR
	);

	U_extm_din_mux: entity work.MUX_3to1
	PORT MAP (
		SEL		=> EXTM_DIN_SEL,
		IN_1	=> LDST_IN,
		IN_2	=> INST_WD,
		IN_3	=> EX_IN,
		OUTPUT	=> EXTM_DIN
	);

	U_extm_addr_mux: entity work.MUX_2to1_8
	PORT MAP (
		SEL		=> EXTM_ADDR_SEL,
		IN_1	=> DST_ADDR(MEM_WIDTH-1 downto 0),
		IN_2	=> ALU_IN(MEM_WIDTH-1 downto 0),
		OUTPUT	=> EXTM_ADDR
	);

	U_dst_data_mux: entity work.MUX_3to1
	PORT MAP (
		SEL		=> DST_MUX_SEL,
		IN_1	=> ALU_IN,
		IN_2	=> DATA_OUT,
		IN_3	=> EXTM_OUT,
		OUTPUT	=> DST_DATA_1
	);

--Register Units
	U_DST_ADDR_0: entity work.RegR8 -- latch on rising
	PORT MAP (
		Clock	=> CLOCK,
		RESETN	=> RESETN,
		ENABLE	=> ENABLE,
		INPUT	=> DST_ADDR,
		OUTPUT	=> DST_ADDR_1
	);
	U_DST_ADDR_1: entity work.RegHold_F8 -- latch on falling to a hold then output on rising
	PORT MAP (
		Clock	=> CLOCK,
		RESETN	=> RESETN,
		ENABLE	=> ENABLE,
		INPUT	=> DST_ADDR_1,
		OUTPUT	=> DST_ADDR_OUT
	);

	U_DST_DATA_0: entity work.RegR -- latch on rising
	PORT MAP (
		Clock	=> CLOCK,
		RESETN	=> RESETN,
		ENABLE	=> ENABLE,
		INPUT	=> DST_DATA_1,
		OUTPUT	=> DST_DATA_2
	);
	U_DST_DATA_1: entity work.RegHold_F -- latch on falling to a hold then output on rising
	PORT MAP (
		Clock	=> CLOCK,
		RESETN	=> RESETN,
		ENABLE	=> ENABLE,
		INPUT	=> DST_DATA_2,
		OUTPUT	=> DST_DATA_OUT
	);

--Memory Units
	U_DATA_MEM: entity work.RAM_8x24RW
	PORT MAP (
		CLOCK		=> CLOCK,
		READ_WRITE	=> DATA_RW,
		DATA_IN		=> DATA_DIN,
		ADDR_IN		=> DATA_ADDR,
		DATA_OUT	=> DATA_OUT
   );
	U_EXT_MEM: entity work.RAM_8x24RW
	PORT MAP (
		CLOCK		=> CLOCK,
		READ_WRITE	=> EXTM_RW,
		DATA_IN		=> EXTM_DIN,
		ADDR_IN		=> EXTM_ADDR,
		DATA_OUT	=> EXTM_OUT
   );

end Structural;
