--Testbench to verify proper application of sigmoid functionality
--ECE 383 Final Project
--C2C William Parks

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY SigmoidTest IS
END SigmoidTest;
 
ARCHITECTURE behavior OF SigmoidTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Sigmoid
    PORT(
         input : IN  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(4 downto 0);

	signal counter : unsigned(7 downto 0) := (others => '0');
	signal clk : std_logic;

   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Sigmoid PORT MAP (
          input => input,
          output => output
        );

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

		for i in 0 to 255 loop
			input <= std_logic_vector(to_unsigned(i,8));
			wait for clk_period;
		end loop;

      wait for clk_period*10;

      -- insert stimulus here 

      wait;
   end process;

END;
