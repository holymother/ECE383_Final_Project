--Tests the new weight determination abilities of an output node
--Node: Does not actually update at this stage
--383 Final Project
--By C2C William Parks
--7 May 2014

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY outputNodeUpdateTest IS
END outputNodeUpdateTest;
 
ARCHITECTURE behavior OF outputNodeUpdateTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OutputNode
    PORT(
         input : IN  std_logic_vector(39 downto 0);
         corrOut : IN  std_logic_vector(4 downto 0);
   		 weightDeltaK : out std_logic_vector(63 downto 0);
         deltaK : OUT  std_logic_vector(7 downto 0);
         newWeight : OUT  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(4 downto 0) := (others => '0');
   signal corrOut : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal deltaK : std_logic_vector(7 downto 0);
   signal newWeight : std_logic_vector(7 downto 0);
   signal output : std_logic_vector(4 downto 0);
	signal weightDeltaK : std_logic_vector(63 downto 0);

	
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.OutputNode(behavioral) 
		generic map(
			numActive => 1,
			default0 => "00010000",
			defLearnRate => "00101000"
		)
	PORT MAP (
          input => "00000000000000000000000000000000000" & input,
          corrOut => corrOut,
          deltaK => deltaK,
			 weightDeltaK => weightDeltaK,
          newWeight => newWeight,
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
		assert newWeight = "00010000" report "Failure on correct output"; --should not get update here 

		input <= "00000";
		corrOut <= "10000";
		wait for clk_period*5;
		assert newWeight = "00010000" report "Failure on 0 value for input"; --should not get update here 

		input <= "10000";
		corrOut <= "00000";
      wait for clk_period*5;
		assert newWeight = "00000110" report "Failure to lower weight";
		
		input <= "00100";
		corrOut <= "10000";
      wait for clk_period*5;
		assert newWeight = "00010001" report "Failure to raise weight";		

      wait;
   end process;

END;
