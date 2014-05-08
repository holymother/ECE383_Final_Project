--Test module for the update weight for the output level nodes module
--383 Final Project
--By C2C William Parks
--7 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

--USE ieee.numeric_std.ALL;
 
ENTITY weightUpdateOutputTest IS
END weightUpdateOutputTest;
 
ARCHITECTURE behavior OF weightUpdateOutputTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT weightUpdateOutput
    PORT(
         currWeight : IN  std_logic_vector(7 downto 0);
         learnRate : IN  std_logic_vector(7 downto 0);
         deltaK : IN  std_logic_vector(7 downto 0);
			prevNodeActiv : in std_logic_vector(4 downto 0);
         weightUpdateTest : OUT  std_logic_vector(7 downto 0);
         leftProd : OUT  std_logic_vector(7 downto 0);
         newWeight : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal currWeight : std_logic_vector(7 downto 0) := (others => '0');
   signal learnRate : std_logic_vector(7 downto 0) := (others => '0');
   signal deltaK : std_logic_vector(7 downto 0) := (others => '0');
   signal prevNodeActiv : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal weightUpdateTest : std_logic_vector(7 downto 0);
   signal leftProd : std_logic_vector(7 downto 0);
   signal newWeight : std_logic_vector(7 downto 0);
 
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: weightUpdateOutput PORT MAP (
          currWeight => currWeight,
          learnRate => learnRate,
          deltaK => deltaK,
          prevNodeActiv => prevNodeActiv,
          weightUpdateTest => weightUpdateTest,
          leftProd => leftProd,
          newWeight => newWeight
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

		currWeight <= "00000000";
		learnRate <= "00000000";
		deltaK <= "00010000";
		prevNodeActiv <= "10000";
      wait for clk_period;

		currWeight <= "01000000";
		learnRate <= "00000010";
		deltaK <= "00010000";
		prevNodeActiv <= "10000";
      wait for clk_period;

		currWeight <= "10110000";
		learnRate <= "00000010";
		deltaK <= "00010000";
		prevNodeActiv <= "10000";
      wait for clk_period;

      wait;
   end process;

END;
