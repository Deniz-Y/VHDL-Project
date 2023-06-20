----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:42:57 01/09/2021 
-- Design Name: 
-- Module Name:    Time - Behavioral 
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


entity Timer is
Port (SCLK: IN std_logic;                             -- clock input (second)
		set_mode : IN STD_LOGIC;								--the mode to set an alarm
		start : in std_logic;									--the switch to start countdown
		RST : IN STD_LOGIC;										--the button to reset the timer and medication counter
		SET_SELECT : IN STD_LOGIC_VECTOR(1 downto 0);	--to select a digit being incremented while setting an alarm
		PLUSONE : IN STD_LOGIC;									--to increment the selected digit
		
		led : out std_logic_vector(3 downto 0);			--indicates the current digit being incremented
		alarm: out std_logic ;									--LED output showing it is time to take a medication
		counter: out std_logic_vector(7 downto 0);		--counts the number of medications taken
		
		--the digits used to display timer
		digitone : out std_logic_vector(3 downto 0) ; 
		digittwo : out std_logic_vector(3 downto 0) ;
		digitthree : out std_logic_vector(3 downto 0);
		digitfour : out std_logic_vector(3 downto 0)
  
     );
end Timer;

architecture Behavioral of Timer is

--intermediate signals
 signal r1 : std_logic_vector(3 downto 0):= "0000"; --- for alarm setting
 SIGNAL r2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL r4 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 
 signal d1 : std_logic_vector(3 downto 0):= "0000"; -- to store the time for using in the next countdown
 SIGNAL d2 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL d3 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL d4 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 
 SIGNAL s : STD_LOGIC_VECTOR(3 DOWNTO 0):= "0000"; --m1 m s1 s 
 SIGNAL s1 : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL m : STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
 SIGNAL m1 : STD_LOGIC_VECTOR(3 DOWNTO 0):= "0000" ;
 
 signal for_alarm : std_logic := '0';
 signal counter1 : std_logic_vector (3 downto 0) := "0001"; --ones place of counter
 signal counter2 : std_logic_vector (3 downto 0) := "0000"; --- tens place of counter
  

begin

PROCESS_SCLK : PROCESS(SCLK,RST) 
begin

--minute and second digits are set here
if (set_mode = '1') then
	if (SET_SELECT = "00" and rising_edge(PLUSONE)) then
		r4 <= r4 + 1 ;
		if r4 = 9 then
			r4 <= "0000";
		end if;
	end if;
   if (SET_SELECT = "01" and rising_edge(PLUSONE)) then
		r3 <= r3 + 1 ;
		if r3 = 5 then
			r3 <= "0000";
		end if;
   end if;
   if (SET_SELECT = "10" and rising_edge(PLUSONE)) then
		r2 <= r2 + 1 ;
		if r2 = 9  then
			r2 <= "0000";
		end if;
   end if;
   if (SET_SELECT = "11" and rising_edge(PLUSONE)) then
		r1 <= r1 + 1 ;
		if r1 = 5 then
			r1 <= "0000";
		end if;
	end if;
	
	--the time period input is saved  
	d1<= r1;
   d2<= r2;
   d3<= r3;
   d4<= r4;
	
--countdown starts	
elsif (set_mode='0' and start = '1') then
	r1<= m1;
   r2<= m;
   r3<= s1;
   r4<= s;	  
end if;


	
if(rising_edge(SCLK))then
	if(set_mode='0' and start = '1') then		--countdown starts
		if(s >= "0000") then						--decrements of the digits are defined 
			s <= s - 1;
			if(s = "0000") then 
				s<= "1001";
				s1<= s1 - 1;
				if(s1 = "0000") then
					m <= m - 1;
					s1 <= "0101";
					if(m = "0000") then
						m <= "1001";
						m1 <= m1 - 1;
						if(m1 =  "0000") then
							m1 <= "0101";
						end if;
					end if;
				end if;
			end if;
		end if;
		--when countdown is over, digits are reset and the LED alarm is set to '1'.
		if(s = "0000" and s1 = "0000" and m = "0000" and m1 =  "0000" ) then
			s <= "0000" ;
			s1 <= "0000";
			m <= "0000" ;
			m1 <=  "0000";
			for_alarm <= '1';		
		end if;
	
	elsif (set_mode='0' and start='0') then 		--once the 'start' switch is off, the LED alarm is reset
		for_alarm <= '0';
		m1<= d1;										--and digits are converted into the initial state and if user wants to  
		m<= d2;                              -----continue to use medication, it is enough to make the switch 'start' one.
		s1<= d3;                             ----If user do not want to change the time, he can do by using 'mode' switch like he did at first.
		s<= d4;
			  
	elsif (set_mode='1' and start='0') then		--when the 'mode' switch is on, a new time interval can be inputted
		m1<= r1;
      m<= r2;
      s1<= r3;
      s<= r4;
	end if;
end if;
	 
--for each rising edge of the 'for_alarm' signal, medication counter will increment
if rising_edge (for_alarm)  then
	counter1 <= counter1 + 1 ;
	if(counter1 = "1001") then			--our counter has two digits
		counter2 <= counter2 + 1 ;
		counter1 <= "0000" ;
	end if;
end if;
	 
--with reset button, everything on the sevensegment will be reset
if RST = '1' then
	r1<="0000";
   r2<="0000";
   r3<="0000";
   r4<="0000";
	counter1 <= "0001"; --returns to its initial value.
	counter2 <= "0000";
end if;
end process;	

--the LED bus shows the selected digit while setting an alarm
WITH SET_SELECT SELECT LED <=
	"0001" when "00", --led 16
	"0010" when "01", --led 13
	"0100" when "10", --led 6
	"1000" when "11", --led 3
	"0000" WHEN OTHERS;

--the intermediate signals are assigned into the related outputs	
 digitone <=r1 ;
 digittwo <=r2;
 digitthree<=r3 ;
 digitfour <=r4;
 alarm <= for_alarm;
  
 counter(7 downto 4) <= counter2;
 counter(3 downto 0) <= counter1;

end Behavioral;

