--Testbench for the multiplier functionality
--383 Final Project
--C2C William Parks
--6 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

USE ieee.numeric_std.ALL;
 
ENTITY multTest IS
END multTest;
 
ARCHITECTURE behavior OF multTest IS 
  
    COMPONENT multiplier
    PORT(
         in1 : IN  std_logic_vector(7 downto 0);
         in2 : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal in1 : std_logic_vector(7 downto 0) := (others => '0');
   signal in2 : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(7 downto 0);
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: multiplier PORT MAP (
          in1 => in1,
          in2 => in2,
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

		in1 <= "00010000";
		in2 <= "10000000";
		wait for clk_period;
		assert output = "10000000" report "First x1 failed";
      wait for clk_period;
		
		in1 <= "00010000";
		in2 <= "10000000";
		wait for clk_period;
		assert output = "10000000" report "Second x1 failed";
		wait for clk_period;

		in1 <= "00010000";
		in2 <= "01000000";
		wait for clk_period;
		assert output = "01000000" report "Third x1 failed";
		wait for clk_period;

		in1 <= "10000000";
		in2 <= "00010000";
		wait for clk_period;
		assert output = "10000000" report "Fourth x1 failed";
		wait for clk_period;

		in1 <= "01000000";
		in2 <= "00010000";
		wait for clk_period;
		assert output = "01000000" report "Fifth x1 failed";
		wait for clk_period;	
		
		in1 <= "10000000";
		in2 <= "10000000";
		wait for clk_period;		
		
		in1 <= "10000000";
		in2 <= "01000000";
		wait for clk_period;	
		
		in1 <= "01000000";
		in2 <= "01000000";
		wait for clk_period;		

		in1 <= "11010000";
		in2 <= "00100000";
		wait for clk_period;
		assert output = "10100000" report "-3 * 2 failed";
		wait for clk_period;
		
		in1 <= "00011000";
		in2 <= "00100000";
		wait for clk_period;
		assert output = "00110000" report "1.5 * 2 failed";
		wait for clk_period;

		in1 <= "00100001"; --2 1/16
		in2 <= "00110010"; --3 1/8
		wait for clk_period;
		assert output = "01100111" report "2 1/16 * 3 1/8 failed";
		wait for clk_period;
		
		in1 <= "11010000";
		in2 <= "00010110";
		wait for clk_period;
		assert output = "10111110" report "-3 * 1 5/8 failure";
		wait for clk_period;
		
		in1 <= "11001010"; -- -3 3/8
		in2 <= "00100010"; -- 2 1/8
		wait for clk_period;
		assert output = "10001110" report "-3 3/8 * 2 1/8 failure";
		wait for clk_period;
		
		in1 <= "00000000";
		in2 <= "00000000";
		wait for clk_period;
		assert output = "00000000" report "0 * 0 failed";

      wait;
   end process;

END;
