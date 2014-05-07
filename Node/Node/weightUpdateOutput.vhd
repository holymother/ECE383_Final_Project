--Based on given input, returns an updated weight value
--383 Final Project
--By C2C William Parks
--6 May 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity weightUpdateOutput is
    Port ( currWeight : in  std_logic_vector(7 downto 0);
			  learnRate : in std_logic_vector(7 downto 0);
			  inputActVal : in std_logic_vector(7 downto 0); --from previous node
			  outErr : in std_logic_vector(7 downto 0);
			  internActVal : in std_logic_vector(7 downto 0);
			  weightUpdateTest : out std_logic_vector(7 downto 0);
			  leftProd : out std_logic_vector(7 downto 0);
			  rightProd : out std_logic_vector(7 downto 0);
			  newWeight : out std_logic_vector(7 downto 0));
end weightUpdateOutput;

architecture Behavioral of weightUpdateOutput is
	signal sigDerOut : std_logic_vector(4 downto 0);
	signal leftMultTemp, rightMultTemp, fullProd : std_logic_vector(7 downto 0);
begin
	sigDerMod : entity work.sigDerivative(behavioral)
		PORT MAP(input => internActVal, output => sigDerOut);
	multL : entity work.multiplier(behavioral)
		PORT MAP(in1 => learnRate, in2 => inputActVal, output => leftMultTemp);
	multR : entity work.multiplier(behavioral)
		PORT MAP(in1 => outErr, in2 => "000" & sigDerOut, output => rightMultTemp);
	multAll : entity work.multiplier(behavioral)
		PORT MAP(in1 => leftMultTemp, in2 => rightMultTemp, output => fullProd);
	weightUpdateTest <= fullProd;
	leftProd <= leftMultTemp;
	rightProd <= rightMultTemp;
	newWeight <= std_logic_vector(signed(fullProd) + signed(currWeight));

end Behavioral;