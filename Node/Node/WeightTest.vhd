--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   17:59:27 05/05/2014
-- Design Name:   
-- Module Name:   C:/Users/C15William.Parks/Desktop/Academics/ECE383/FinalProject/Node/Node/WeightTest.vhd
-- Project Name:  Node
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: WeightMult
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY WeightTest IS
END WeightTest;
 
ARCHITECTURE behavior OF WeightTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT WeightMult
    PORT(
         weight : IN  std_logic_vector(7 downto 0);
         activationVal : IN  std_logic_vector(4 downto 0);
         output : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal weight : std_logic_vector(7 downto 0) := (others => '0');
   signal activationVal : std_logic_vector(4 downto 0) := (others => '0');

 	--Outputs
   signal output : std_logic_vector(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
	signal clk : std_logic;
   constant clk_period : time := 10 ns;
 
BEGIN
 
   uut: WeightMult PORT MAP (
          weight => weight,
          activationVal => activationVal,
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

		weight <= "10000000";
		activationVal <= (others => '0');

      wait for clk_period*10;
		activationVal <= "01100";
      wait for clk_period*10;
		activationVal <= "10000";
		
		wait for clk_period*10;
		weight <= "00101100";
		activationVal <= "01100";
		

      wait;
   end process;

END;
