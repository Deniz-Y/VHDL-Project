----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:41:51 01/09/2021 
-- Design Name: 
-- Module Name:    SEVSEG_DECODER - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity SEVSEG_DECODER is
 PORT ( INPUT : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
           SEVSEG_BUS : OUT  STD_LOGIC_VECTOR (6 DOWNTO 0));
END SEVSEG_DECODER;

ARCHITECTURE BEHAVIORAL OF SEVSEG_DECODER IS

BEGIN

WITH INPUT SELECT SEVSEG_BUS <=
	"0000001" when "0000", --0
	"1001111" when "0001", --1
	"0010010" when "0010", --2
	"0000110" when "0011", --3
	"1001100" when "0100", --4
	"0100100" when "0101", --5
	"0100000" when "0110", --6
	"0001111" when "0111", --7
	"0000000" when "1000", --8
	"0000100" when "1001", --9
	"0000100" WHEN OTHERS;
END BEHAVIORAL;
