--Based on given input, returns an updated weight value, for output level weights
--383 Final Project
--By C2C William Parks
--6 May 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity weightUpdateOutput is
    Port ( currWeight : in std_logic_vector(7 downto 0);
			  learnRate : in std_logic_vector(7 downto 0);
			  prevNodeActiv : in std_logic_vector(4 downto 0);
			  deltaK : in std_logic_vector(7 downto 0);
			  weightUpdateTest : out std_logic_vector(7 downto 0);
			  leftProd : out std_logic_vector(7 downto 0);
			  newWeight : out std_logic_vector(7 downto 0));
end weightUpdateOutput;

architecture Behavioral of weightUpdateOutput is
	signal leftMultTemp, fullProd : std_logic_vector(7 downto 0);
	signal extPrevNode : std_logic_vector(7 downto 0);
begin
	extPrevNode <= "000" & prevNodeActiv;
	multL : entity work.multiplier(behavioral)
		PORT MAP(in1 => learnRate, in2 => deltaK, output => leftMultTemp);
	multAll : entity work.multiplier(behavioral)
		PORT MAP(in1 => leftMultTemp, in2 => extPrevNode, output => fullProd);
	weightUpdateTest <= fullProd;
	leftProd <= leftMultTemp;
	newWeight <= std_logic_vector(signed(fullProd) + signed(currWeight));

end Behavioral;