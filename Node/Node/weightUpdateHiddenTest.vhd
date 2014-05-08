--Test module for weight update for hidden layer nodes
--383 Final Project
--By C2C William Parks
--8 May 2014
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
--USE ieee.numeric_std.ALL;
 
ENTITY weightUpdateHiddenTest IS
END weightUpdateHiddenTest;
 
ARCHITECTURE behavior OF weightUpdateHiddenTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT weightUpdateHidden
    PORT(
         currWeight : IN  std_logic_vector(7 downto 0);
         learnRate : IN  std_logic_vector(7 downto 0);
         prevNodeActiv : IN  std_logic_vector(4 downto 0);
         deltaKArray : IN  std_logic_vector(63 downto 0);
         sigIn : IN  std_logic_vector(7 downto 0);
         newWeight : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal currWeight : std_logic_vector(7 downto 0) := (others => '0');
   signal learnRate : std_logic_vector(7 downto 0) := (others => '0');
   signal prevNodeActiv : std_logic_vector(4 downto 0) := (others => '0');
   signal deltaKArray : std_logic_vector(7 downto 0) := (others => '0');
   signal sigIn : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal newWeight : std_logic_vector(7 downto 0);
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: weightUpdateHidden PORT MAP (
          currWeight => currWeight,
          learnRate => learnRate,
          prevNodeActiv => prevNodeActiv,
          deltaKArray => "00000000000000000000000000000000000000000000000000000000" & deltaKArray,
          sigIn => sigIn,
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
		currWeight <= "00010000";
		learnRate <= "00000010";
		prevNodeActiv <= "10000";
		sigIn <= "00001011";
      wait for clk_period*5;
		assert newWeight = currWeight report "Initial Zero failed";
		deltaKArray <= "00110000";
      wait for clk_period*5;
		assert newWeight = "00010011" report "Should increase failure";

      wait;
   end process;

END;
