--Takes in a weight and an activation value
--Returns input to sigmoid (after summing all together)
--383 Final Project
--By C2C William Parks
--5 May 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity WeightMult is
    Port ( weight : in  STD_LOGIC_VECTOR (7 downto 0);
           activationVal : in  STD_LOGIC_VECTOR (4 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end WeightMult;

architecture Behavioral of WeightMult is
	signal sum : signed(7 downto 0);
	signal tempOut : signed(7 downto 0);
	signal o0,o1,o2,o3,o4 :signed(7 downto 0); --4 is highest. These are based off of activiation value
begin
	o4 <= signed(weight) when activationVal(4) = '1' else
			(others => '0');
	o3 <= signed("0" & weight(7 downto 1)) when activationVal(3) = '1' else
			(others => '0');
	o2 <= signed("00" & weight(7 downto 2)) when activationVal(2) = '1' else
			(others => '0');
	o1 <= signed("000" & weight(7 downto 3)) when activationVal(1) = '1' else
			(others => '0');
	o0 <= signed("0000" & weight(7 downto 4)) when activationVal(0) = '1' else
			(others => '0');
			
	sum <= o4 + o3 + o2 + o1 + o0;
	output <= std_logic_vector(sum) when weight(7) = '0' else --if weight is positive, leave as is
				 std_logic_vector(weight) when activationVal = "10000" else
				 std_logic_vector(-sum);

end Behavioral;

