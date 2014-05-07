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
         inputActVal : IN  std_logic_vector(7 downto 0);
         outErr : IN  std_logic_vector(7 downto 0);
         internActVal : IN  std_logic_vector(7 downto 0);
         weightUpdateTest : OUT  std_logic_vector(7 downto 0);
         leftProd : OUT  std_logic_vector(7 downto 0);
         rightProd : OUT  std_logic_vector(7 downto 0);
         newWeight : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal currWeight : std_logic_vector(7 downto 0) := (others => '0');
   signal learnRate : std_logic_vector(7 downto 0) := (others => '0');
   signal inputActVal : std_logic_vector(7 downto 0) := (others => '0');
   signal outErr : std_logic_vector(7 downto 0) := (others => '0');
   signal internActVal : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal weightUpdateTest : std_logic_vector(7 downto 0);
   signal leftProd : std_logic_vector(7 downto 0);
   signal rightProd : std_logic_vector(7 downto 0);
   signal newWeight : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: weightUpdateOutput PORT MAP (
          currWeight => currWeight,
          learnRate => learnRate,
          inputActVal => inputActVal,
          outErr => outErr,
          internActVal => internActVal,
          weightUpdateTest => weightUpdateTest,
          leftProd => leftProd,
          rightProd => rightProd,
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
		inputActVal <= "00000000";
		outErr <= "00000000";
		internActval <= "00000000";
      wait for clk_period;

		currWeight <= "01000000";
		learnRate <= "00000010";
		inputActVal <= "00001100";
		outErr <= "11100000";
		internActval <= "00000010";
      wait for clk_period;

		currWeight <= "10110000";
		learnRate <= "00000010";
		inputActVal <= "00001100";
		outErr <= "11100000";
		internActval <= "00000010";
      wait for clk_period;

      wait;
   end process;

END;
