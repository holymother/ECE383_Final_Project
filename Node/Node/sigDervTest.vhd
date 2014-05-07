--Test module for the sigmoid derivative module
--383 Final Project
--By C2C William Parks
--6 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY sigDervTest IS
END sigDervTest;
 
ARCHITECTURE behavior OF sigDervTest IS 
 
 
    COMPONENT sigDerivative
    PORT(
         input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(7 downto 0) := (others => '0');
	signal clk : std_logic;
 	--Outputs
   signal output : std_logic_vector(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: sigDerivative PORT MAP (
          input => input,
          output => output
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;


		for i in 0 to 255 loop
			input <= std_logic_vector(to_unsigned(i,8));
			wait for clk_period;
		end loop;
		
		
      wait;
   end process;

END;
