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
	signal o0,o1,o2,o3,o4 :unsigned(7 downto 0); --4 is highest. These are based off of activiation value
begin
	o4 <= unsigned(weight) when activationVal(4) = '1' else
			(others => '0');
	o3 <= unsigned("0" & weight(7 downto 1)) when activationVal(3) = '1' else
			(others => '0');
	o2 <= unsigned("00" & weight(7 downto 2)) when activationVal(2) = '1' else
			(others => '0');
	o1 <= unsigned("000" & weight(7 downto 3)) when activationVal(1) = '1' else
			(others => '0');
	o0 <= unsigned("0000" & weight(7 downto 4)) when activationVal(0) = '1' else
			(others => '0');
			
	output <= STD_LOGIC_VECTOR(o4 + o3 + o2 + o1 + o0);

end Behavioral;

