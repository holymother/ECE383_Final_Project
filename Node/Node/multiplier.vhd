--Multiplier Module for use in back progagation
--383 Final Project
--By C2C William Parks
--6 May 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity multiplier is
    Port ( in1 : in  STD_LOGIC_VECTOR (7 downto 0);
           in2 : in  STD_LOGIC_VECTOR (7 downto 0);
			  posIn1Out : out signed(7 downto 0);
           output : out  STD_LOGIC_VECTOR (7 downto 0));
end multiplier;

architecture Behavioral of multiplier is
	signal posIn1, posIn2 : signed(7 downto 0);
	signal multRes : signed(15 downto 0);
	signal resScaled : std_logic_vector(7 downto 0);
	signal tempOut : signed(7 downto 0);
	
	signal o0,o1,o2,o3,o4,o5,o6,o7 : signed(7 downto 0);
	signal sum : signed(7 downto 0);
	
	signal upperProd : signed(15 downto 0);
begin

	posIn1Out <= posIn1;

	posIn1 <= signed(in1) when in1(7) = '0' else
				 -signed(in1);
	posIn2 <= signed(in2) when in2(7) = '0' else
				 -signed(in2);
	multRes <= posIn1 * posIn2;
	resScaled <= std_logic_vector(multRes(11 downto 4));
	tempOut <= signed(resScaled);
	output <= std_logic_vector(tempOut) when in1(7) = '0' and in2(7) = '0' else
				 std_logic_vector(tempOut) when in1(7) = '1' and in2(7) = '1' else
				 std_logic_vector(-tempOut);

end Behavioral;

