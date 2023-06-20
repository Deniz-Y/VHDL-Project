----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:35:47 01/09/2021 
-- Design Name: 
-- Module Name:    MAIN - Behavioral 
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


entity MAIN is
 PORT (	SET_SELECT : IN  STD_LOGIC_VECTOR (1 DOWNTO 0);    --to select a digit being incremented while setting an alarm
			MCLK : IN  STD_LOGIC;	  
			SET_MODE : IN STD_LOGIC;   --the mode to set an alarm
			RESET : IN STD_LOGIC;         --the button to reset the timer and medication counter
			PLUS_ONE : IN STD_LOGIC;      --to increment the selected digit
			START :IN STD_LOGIC;       --the switch to start countdown
			  
			LED_digit : out std_logic_vector(3 downto 0);   --indicates the current digit being incremented
			ALARM : OUT STD_LOGIC ;                          --LED output showing it is time to take a medication
			SEVSEG_DATA : OUT  STD_LOGIC_VECTOR (6 DOWNTO 0);
			SEVSEG_CONTROL : OUT  STD_LOGIC_VECTOR (7 DOWNTO 0));
end MAIN;

architecture Behavioral of MAIN is

--intermediate signals
signal WIRE_HUNDREDHZ_CLOCK : std_logic;
signal WIRE_SEVSEG_DATA : std_logic_vector( 3 downto 0);
signal WIRE_SECONDCLOCK : std_logic;

signal minute : std_logic_vector( 3 downto 0);
signal minute1 : std_logic_vector( 3 downto 0);
signal second : std_logic_vector( 3 downto 0);
signal second1 : std_logic_vector( 3 downto 0);
signal COUNTER : std_logic_vector (7 downto 0);   --counts the number of medications taken

BEGIN


--ADD CLOCK GENERATOR
CLOCK_GENERATOR : entity WORK.CLOCK_GENERATOR PORT MAP(
	MCLK => MCLK,
	
  HUNDREDHZCLOCK => WIRE_HUNDREDHZ_CLOCK,
	SECONDCLK => WIRE_SECONDCLOCK
);

--ADD DRIVER
DRIVER : ENTITY WORK.SEVSEG_DRIVER PORT MAP(
 D1 => minute1,
 D2 => minute,
 D3 => second1,
 D4 => second,
 D5 => COUNTER(7 downto 4),
 D6=>  COUNTER (3 downto 0),
 CLK => WIRE_HUNDREDHZ_CLOCK,
 SEV_SEG_DATA => WIRE_SEVSEG_DATA,
 SEV_SEG_DRIVER => SEVSEG_CONTROL
);

--ADD DECODER
DECODER : ENTITY WORK.SEVSEG_DECODER PORT MAP(
	INPUT => WIRE_SEVSEG_DATA,
	SEVSEG_BUS => SEVSEG_DATA
);

--ADD Timer
TIMER : ENTITY WORK.Timer PORT MAP(
	RST => RESET,
	set_mode => SET_MODE,
	PLUSONE=> PLUS_ONE,
	SET_SELECT => SET_SELECT,
	start => START,
	
	digitfour  =>second ,
	digitthree  =>second1,
	digittwo=>minute ,
	digitone =>minute1,
	SCLK => WIRE_SECONDCLOCK,
	alarm => ALARM,
	led => LED_digit,
	counter => COUNTER	
);

END BEHAVIORAL;

