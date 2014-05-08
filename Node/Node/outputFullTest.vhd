--Test of the synchronous capabilites of the output node
--383 Final Project
--By C2C William Parks
--8 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY outputFullTest IS
END outputFullTest;
 
ARCHITECTURE behavior OF outputFullTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT OutputNode
    PORT(
         input : IN  std_logic_vector(39 downto 0);
         corrOut : IN  std_logic_vector(4 downto 0);
         update : IN  std_logic;
         weightDeltaK : OUT  std_logic_vector(63 downto 0);
         deltaK : OUT  std_logic_vector(7 downto 0);
         newWeight : OUT  std_logic_vector(7 downto 0);
		testOutWeight : out std_logic_vector(7 downto 0);
         output : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal input : std_logic_vector(14 downto 0) := (others => '0');
   signal corrOut : std_logic_vector(4 downto 0) := (others => '0');
   signal update : std_logic := '0';

 	--Outputs
   signal weightDeltaK : std_logic_vector(63 downto 0);
   signal deltaK : std_logic_vector(7 downto 0);
   signal newWeight : std_logic_vector(7 downto 0);
   signal output : std_logic_vector(4 downto 0);
	signal testOutWeight : std_logic_vector(7 downto 0);
	signal clk : std_logic;
   -- appropriate port name 
 
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: entity work.OutputNode(behavioral) 
		generic map(
			numActive => 3,
			default0 => "11000000",--"10100000",
			default1 => "10010000",--"10100000",
			default2 => "01000000",--"01010110",
			defLearnRate => "00001000"
		)	
	PORT MAP (
          input =>  "0000000000000000000000000" & input,
          corrOut => corrOut,
          update => update,
          weightDeltaK => weightDeltaK,
          deltaK => deltaK,
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
		assert newWeight = "00010000" report "Failure on correct output"; --should not get update here 

--		input <= "00000";
--		corrOut <= "10000";
--		wait for clk_period*5;
--		assert newWeight = "00010000" report "Failure on 0 value for input"; --should not get update here 
--
--		input <= "10000";
--		corrOut <= "00000";
--      wait for clk_period*5;
--		assert newWeight = "00000110" report "Failure to lower weight";
--		
--		input <= "00100";
--		corrOut <= "10000";
--      wait for clk_period*5;
--		assert newWeight = "00010001" report "Failure to raise weight";
--		
--		update <= '1';
--		wait for clk_period;
--		update <= '0';
--		wait for clk_period;
--		assert testOutWeight = "00010001" report "Failed to transfer weight";

		for i in 0 to 255 loop
			input <= "010000011000011";
			corrOut <= "00000";
			update <= '1';
			wait for clk_period;
			update <= '0';
			wait for clk_period;
			
			input <= "001101100010000";
			corrOut <= "10000";
			update <= '1';
			wait for clk_period;
			update <= '0';
			wait for clk_period;
		end loop;
      wait;
   end process;

END;
