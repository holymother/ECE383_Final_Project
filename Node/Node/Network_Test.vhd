--Test for the basic implementation of an entire network
--383 Final Project
--By C2C William Parks

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
ENTITY Network_Test IS
END Network_Test;
 
ARCHITECTURE behavior OF Network_Test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Network
    PORT(
         Input : IN  std_logic_vector(1 downto 0);
         Output : OUT  std_logic_vector(4 downto 0);
			bROutput : out STD_LOGIC_VECTOR(4 downto 0);
			bLOutput : out STD_LOGIC_VECTOR(4 downto 0);
			mLOutput : out STD_LOGIC_VECTOR(4 downto 0);
			mMOutput : out STD_LOGIC_VECTOR(4 downto 0);
			MROutput : out STD_LOGIC_VECTOR(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal Input : std_logic_vector(1 downto 0) := (others => '0');

 	--Outputs
   signal Output : std_logic_vector(4 downto 0);
	signal bROutput : STD_LOGIC_VECTOR(4 downto 0);
	signal bLOutput : STD_LOGIC_VECTOR(4 downto 0);
	signal mLOutput : STD_LOGIC_VECTOR(4 downto 0);
	signal mMOutput : STD_LOGIC_VECTOR(4 downto 0);
	signal MROutput : STD_LOGIC_VECTOR(4 downto 0);
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Network PORT MAP (
          Input => Input,
          Output => Output,
			 bROutput => bROutput,
			 bLOutput => bLOutput,
			 mLOutput => mLOutput,
			 mMOutput => mMOutput,
			 mROutput => mROutput
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

      wait for clk_period*10;
		input <= "00";
      wait for clk_period*10;
		input <= "01";
      wait for clk_period*10;
		input <= "10";
      wait for clk_period*10;
		input <= "11";

      wait;
   end process;

END;
