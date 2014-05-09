--Test of the Learning Network
--383 Final Project
--By C2C William Parks
--8 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY LearningNetworkTest IS
END LearningNetworkTest;
 
ARCHITECTURE behavior OF LearningNetworkTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT LearningNetwork
    PORT(
         Input : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic_vector(4 downto 0);
         update : IN  std_logic;
         corrOut : IN  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(1 downto 0) := (others => '0');
   signal update : std_logic := '0';
   signal corrOut : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(4 downto 0);
	signal clk : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: LearningNetwork PORT MAP (
          Input => Input,
          Output => Output,
          update => update,
          corrOut => corrOut
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

		input <= "00";
		wait for clk_period*5;
		input <= "01";
		wait for clk_period*5;
		input <= "10";
		wait for clk_period*5;
		input <= "11";
		wait for clk_period*5;

		for i in 0 to 255 loop
			input <= "00";
			corrOut <= "00000";
			update <= '1';
			wait for clk_period;
			update <= '0';
			wait for clk_period;
			
			input <= "10";
			corrOut <= "10000";
			update <= '1';
			wait for clk_period;
			update <= '0';
			wait for clk_period;
			
			input <= "01";
			corrOut <= "10000";
			update <= '1';
			wait for clk_period;
			update <= '0';
			wait for clk_period;

			input <= "11";
			corrOut <= "00000";
			update <= '1';
			wait for clk_period;
			update <= '0';
			wait for clk_period;
		end loop;

		wait for clk_period*20;
		input <= "00";
		wait for clk_period*5;
		input <= "01";
		wait for clk_period*5;
		input <= "10";
		wait for clk_period*5;
		input <= "11";

      wait;
   end process;

END;
