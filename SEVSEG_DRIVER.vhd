----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:40:54 01/09/2021 
-- Design Name: 
-- Module Name:    SEVSEG_DRIVER - Behavioral 
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
USE IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEVSEG_DRIVER is
 PORT (  
			  D4 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  D3 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  D2 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  D1  : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  D5 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
			  D6 : IN  STD_LOGIC_VECTOR (3 DOWNTO 0);
           CLK : IN  STD_LOGIC;
			  SEV_SEG_DATA : OUT  STD_LOGIC_VECTOR (3 DOWNTO 0);
           SEV_SEG_DRIVER : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0)
			  );
END SEVSEG_DRIVER;

ARCHITECTURE BEHAVIORAL OF SEVSEG_DRIVER IS

SIGNAL COUNTER : STD_LOGIC_VECTOR(2 DOWNTO 0) := "000";

BEGIN

---mods

--INCREMENT COUNTER
PROCESS_CLK : PROCESS(CLK)
BEGIN
	IF(CLK'EVENT AND CLK = '1') THEN
			COUNTER <= COUNTER + 1;
			IF(COUNTER = "101" )THEN
			 COUNTER <= "000";
			END IF;
	END IF;
END PROCESS;

-- SEV_SEG DATA
WITH COUNTER SELECT SEV_SEG_DATA <=

	D1 WHEN "000",
	D2 WHEN "001",
	D3 WHEN "010",
	D4 WHEN "011",
	D5 WHEN  "100",
	D6 when "101",
	"1001" WHEN OTHERS; 
--DATA END

--SEV_SEG_CONTROLLER
WITH COUNTER SELECT SEV_SEG_DRIVER <=
"01111111" WHEN "000", 
"10111111" WHEN "001", 
"11011111" WHEN "010", 
"11101111" WHEN "011", 
"11111101" WHEN "100", 
"11111110" WHEN "101", 

"00001111" WHEN OTHERS;
--SEV_SEG CONTROLLER END

END BEHAVIORAL;

