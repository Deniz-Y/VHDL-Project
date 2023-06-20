----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:39:27 01/09/2021 
-- Design Name: 
-- Module Name:    CLOCK_GENERATOR - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CLOCK_GENERATOR is
Port ( MCLK : in  STD_LOGIC;
		SECONDCLK : out STD_LOGIC;
       HUNDREDHZCLOCK : out  STD_LOGIC);
			  
end CLOCK_GENERATOR;

architecture Behavioral of CLOCK_GENERATOR is
SIGNAL COUNTER : integer := 0;
SIGNAL COUNTERS : integer := 0;
signal temp : std_logic := '0';
signal temps: std_logic := '0';
begin

CLK_PROCESS: PROCESS(MCLK)

BEGIN
if rising_edge(mclk) then 
counter <= counter + 1;
if counter<50000 then 
temp <= '1';
else 
temp <= '0';
counter <= 0; 
end if ;
end if;

if rising_edge(mclk) then
counters <= counters + 1;
if counters<100000000 then 
temps <= '1';
else 
temps <= '0';
counters <= 0; 
end if; 
end if;
	
END PROCESS;
hundredhzclock <= temp;
secondclk <= temps ;
end Behavioral;

