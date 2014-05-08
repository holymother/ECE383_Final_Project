--Test of the synchronous capabilities of the output node
--383 Final Project
--By C2C William Parks
--8 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY hiddenFullTest IS
END hiddenFullTest;
 
ARCHITECTURE behavior OF hiddenFullTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT HiddenNode
    PORT(
         input : IN  std_logic_vector(39 downto 0);
         weightDeltaKIn : IN  std_logic_vector(63 downto 0);
         update : IN  std_logic;
         newWeight : OUT  std_logic_vector(7 downto 0);
         testOutWeight : OUT  std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(4 downto 0) := (others => '0');
   signal weightDeltaKIn : std_logic_vector(7 downto 0) := (others => '0');
   signal update : std_logic := '0';

 	--Outputs
   signal newWeight : std_logic_vector(7 downto 0);
   signal testOutWeight : std_logic_vector(7 downto 0);
   signal output : std_logic_vector(4 downto 0);
	signal clk : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
  uut: entity work.hiddenNode(behavioral) 
		generic map(
			numActive => 1,
			default0 => "00010000",
			defLearnRate => "00101000"
		)		
	PORT MAP (
          input => "00000000000000000000000000000000000" & input,
          weightDeltaKIn => "00000000000000000000000000000000000000000000000000000000" & weightDeltaKIn,
          update => update,
          newWeight => newWeight,
          testOutWeight => testOutWeight,
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
	  weightDeltaKIn <= "00000000";
      wait for clk_period*5;
	  assert newWeight = "00010000" report "Failure on correct output (Delta K array of 0";

	  weightDeltaKIn <= "00011100";
	  input <= "00000";
      wait for clk_period*5;
	  assert newWeight = "00010000" report "Failure on 0 value for input";

	  input <= "10000";
      wait for clk_period*5;
	  assert newWeight = "00101001" report "Failure to raise weight";
		
		input <= "10000";
		weightDeltaKIn <= "11111000";
      wait for clk_period*5;
	  assert newWeight = "00001001" report "Failure to lower weight";
	  
	  update <= '1';
	  wait for clk_period*5;
	  update <= '0';
	  wait for clk_period*5;
	  assert testOutWeight = testOutWeight report "Failure to update";

      wait;
   end process;

END;
