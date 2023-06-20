--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   23:58:44 01/09/2021
-- Design Name:   
-- Module Name:   C:/Users/Deniz/Desktop/Medication_Reminder/main_sim.vhd
-- Project Name:  Medication_Reminder
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: MAIN
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY main_sim IS
END main_sim;
 
ARCHITECTURE behavior OF main_sim IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT MAIN
    PORT(
         SET_SELECT : IN  std_logic_vector(1 downto 0);
         MCLK : IN  std_logic;
         SET_MODE : IN  std_logic;
         RESET : IN  std_logic;
         PLUS_ONE : IN  std_logic;
         START : IN  std_logic;
         LED_digit : OUT  std_logic_vector(3 downto 0);
         ALARM : OUT  std_logic;
         SEVSEG_DATA : OUT  std_logic_vector(6 downto 0);
         SEVSEG_CONTROL : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal SET_SELECT : std_logic_vector(1 downto 0) := (others => '0');
   signal MCLK : std_logic := '0';
   signal SET_MODE : std_logic := '0';
   signal RESET : std_logic := '0';
   signal PLUS_ONE : std_logic := '0';
   signal START : std_logic := '0';

 	--Outputs
   signal LED_digit : std_logic_vector(3 downto 0);
   signal ALARM : std_logic;
   signal SEVSEG_DATA : std_logic_vector(6 downto 0);
   signal SEVSEG_CONTROL : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant MCLK_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: MAIN PORT MAP (
          SET_SELECT => SET_SELECT,
          MCLK => MCLK,
          SET_MODE => SET_MODE,
          RESET => RESET,
          PLUS_ONE => PLUS_ONE,
          START => START,
          LED_digit => LED_digit,
          ALARM => ALARM,
          SEVSEG_DATA => SEVSEG_DATA,
          SEVSEG_CONTROL => SEVSEG_CONTROL
        );

   -- Clock process definitions
   MCLK_process :process
   begin
		MCLK <= '0';
		wait for MCLK_period/2;
		MCLK <= '1';
		wait for MCLK_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
         SET_MODE <= '0';SET_SELECT <= "00"; PLUS_ONE <= '0'; RESET <= '1'; START <= '0';
       wait for MCLK_period ;  
       SET_MODE <= '1';SET_SELECT <= "00"; PLUS_ONE <= '1'; RESET <= '0'; START <= '0';
      wait for MCLK_period;   
		 SET_MODE <= '0';SET_SELECT <= "00"; PLUS_ONE <= '0'; RESET <= '0'; START <= '1';
		  wait for MCLK_period*100000000;
		SET_MODE <= '0';SET_SELECT <= "00"; PLUS_ONE <= '0'; RESET <= '0'; START <= '1';

		
      -- insert stimulus here 

      wait;
   end process;

END;
