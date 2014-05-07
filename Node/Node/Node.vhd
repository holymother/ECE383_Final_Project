--Instantiation of a single Node, as part of the final project for ECE 383
--C2C William Parks
--5 May 2014

--Note: Supports up to 8 inputs, of 5 bits each
--Had to hardcode due to inability to create arbitrary number of sigmoid modules

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

--library UNISIM;
--use UNISIM.VComponents.all;

entity Node is
	 generic(
		numActive: natural := 8;
		default0: std_logic_vector(7 downto 0) := (others => '0');
		default1: std_logic_vector(7 downto 0) := (others => '0');
		default2: std_logic_vector(7 downto 0) := (others => '0');
		default3: std_logic_vector(7 downto 0) := (others => '0');
		default4: std_logic_vector(7 downto 0) := (others => '0');
		default5: std_logic_vector(7 downto 0) := (others => '0');
		default6: std_logic_vector(7 downto 0) := (others => '0');
		default7: std_logic_vector(7 downto 0) := (others => '0')); --Number of active inputs for this particular node. Since I cannot instantiate a generic based number of internal modules.

    Port ( input : in  STD_LOGIC_VECTOR(39 downto 0); -- For 8 total 5 bit inputs
			  sigInTemp : out STD_LOGIC_VECTOR(7 downto 0);
			  output : out STD_LOGIC_VECTOR(4 downto 0)
	 );
end Node;

architecture Behavioral of Node is
	signal weightOut0, weightOut1, weightOut2, weightOut3, weightOut4, weightOut5, weightOut6, weightOut7 : STD_LOGIC_VECTOR(7 downto 0);
	signal weightIn0, weightIn1, weightIn2, weightIn3, weightIn4, weightIn5, weightIn6, weightIn7 : std_logic_vector(7 downto 0);
	signal sigIn : std_logic_vector(7 downto 0);
begin

	--NOTE: THESE ARE THE RECEIVING WEIGHTS

	weightIn0 <= default0 when numActive >= 1 else
					 (others => '0');
   weightIn1 <= default1 when numActive >= 2 else
					 (others => '0');
   weightIn2 <= default2 when numActive >= 3 else
					 (others => '0');
   weightIn3 <= default3 when numActive >= 4 else
					 (others => '0');
   weightIn4 <= default4 when numActive >= 5 else
					 (others => '0');
   weightIn5 <= default5 when numActive >= 6 else
					 (others => '0');
   weightIn6 <= default6 when numActive >= 7 else
					 (others => '0');
   weightIn7 <= default7 when numActive = 8 else
					 (others => '0');

	--Weight Modules corresponding to each of the 8 possible hardcoded inputs
	weight0 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn0, activationVal => input(4 downto 0), output=> weightOut0);
	weight1 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn1, activationVal => input(9 downto 5), output=> weightOut1);
	weight2 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn2, activationVal => input(14 downto 10), output=> weightOut2);
	weight3 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn3, activationVal => input(19 downto 15), output=> weightOut3);
	weight4 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn4, activationVal => input(24 downto 20), output=> weightOut4);
	weight5 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn5, activationVal => input(29 downto 25), output=> weightOut5);
	weight6 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn6, activationVal => input(34 downto 30), output=> weightOut6);
	weight7 : entity work.WeightMult(behavioral)
		PORT MAP(weight => weightIn7, activationVal => input(39 downto 35), output=> weightOut7);		

	--Sum the output of each weight multiplier to use as input to the sigmoid
	sigIn <= std_logic_vector(unsigned(weightOut0) + unsigned(weightOut1) + unsigned(weightOut2) + unsigned(weightOut3) + unsigned(weightOut4) + unsigned(weightOut5) + unsigned(weightOut6) + unsigned(weightOut7));
	sigInTemp <= sigIn;
	sig : entity work.Sigmoid(behavioral)
		PORT MAP(input => sigIn, output => output);
	
end Behavioral;

