--Test module for deltaK calculation of an output node
--383 Final Project
--By C2C William Parks
--7 May 2014

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY outputNodeDeltaKTest IS
END outputNodeDeltaKTest;
 
ARCHITECTURE behavior OF outputNodeDeltaKTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OutputNode
    PORT(
         input : IN  std_logic_vector(39 downto 0);
         corrOut : IN  std_logic_vector(4 downto 0);
         deltaK : OUT  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(4 downto 0) := (others => '0');
   signal corrOut : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal deltaK : std_logic_vector(7 downto 0);
   signal output : std_logic_vector(4 downto 0);
	
	signal clk : std_logic;

   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.OutputNode(behavioral) 
		generic map(
			numActive => 1,
			default0 => "00010000"
		)
		PORT MAP (
          input => "00000000000000000000000000000000000" & input,
          corrOut => corrOut,
          deltaK => deltaK,
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

		input <= "10000";
		corrOut <= "10000";
      wait for clk_period*2;
		
		corrOut <= "01100";
		wait for clk_period;
		assert deltaK = "00000000" report "Should output 0";


      wait;
   end process;

END;
