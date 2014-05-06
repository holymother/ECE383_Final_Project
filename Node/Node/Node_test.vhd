--Module to test the node implementation
--Part of 383 final project
--By C2C William Parks
--5 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY Node_test IS
END Node_test;
 
ARCHITECTURE behavior OF Node_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Node
    PORT(
         input : IN  std_logic_vector(39 downto 0);
         output : OUT  std_logic_vector(4 downto 0);
						  sigInTemp : out STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(9 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(4 downto 0);
	signal sigInTemp : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.Node(behavioral)
		  generic map(
			numActive => 2,
			default0 => "10000000",
			default1 => "01100000"
			)
        PORT MAP (
          input => "000000000000000000000000000000" & input,
          output => output,
			 sigInTemp => sigInTemp
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
		input <= (others => '0');
      wait for clk_period*10;
		input <= "0000011111";
		wait for clk_period*10;
		input <= "1111100000";
		wait for clk_period*10;
		input <= "1111111111";
      wait for clk_period*10;
      wait;
   end process;

END;
