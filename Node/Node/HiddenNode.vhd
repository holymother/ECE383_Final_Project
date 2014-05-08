--Implementation of a single hidden level node
--Should have back propagation learning capability
--383 Final Project
--By C2C William Parks
--7 May 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity HiddenNode is
	 generic(
		numActive: natural := 8;
		defLearnRate: std_logic_vector(7 downto 0) := "00000001";
		default0: std_logic_vector(7 downto 0) := (others => '0');
		default1: std_logic_vector(7 downto 0) := (others => '0');
		default2: std_logic_vector(7 downto 0) := (others => '0');
		default3: std_logic_vector(7 downto 0) := (others => '0');
		default4: std_logic_vector(7 downto 0) := (others => '0');
		default5: std_logic_vector(7 downto 0) := (others => '0');
		default6: std_logic_vector(7 downto 0) := (others => '0');
		default7: std_logic_vector(7 downto 0) := (others => '0')); --Number of active inputs for this particular node. Since I cannot instantiate a generic based number of internal modules.

    Port ( input : in  STD_LOGIC_VECTOR(39 downto 0); -- For 8 total 5 bit inputs
			 -- corrOut : in STD_LOGIC_VECTOR(4 downto 0);
			  weightDeltaKIn : in std_logic_vector(63 downto 0);
--			  weightDeltaKOut : out std_logic_vector(63 downto 0);
--			  deltaK : out std_logic_vector(7 downto 0);
			  newWeight : out std_logic_vector(7 downto 0); --for testing
			  output : out STD_LOGIC_VECTOR(4 downto 0)
	 );
end HiddenNode;


architecture Behavioral of HiddenNode is
	signal errorK : std_logic_vector(7 downto 0);
	signal extCorrOut, extActOut : std_logic_vector(7 downto 0);
	signal sigDer : std_logic_vector(4 downto 0);
	signal extSigDer : std_logic_vector(7 downto 0);
	signal deltaKTemp : std_logic_vector(7 downto 0);

	signal newWeightTemp0, newWeightTemp1, newWeightTemp2, newWeightTemp3, newWeightTemp4, newWeightTemp5, newWeightTemp6, newWeightTemp7 : std_logic_vector(7 downto 0);

	signal tempOut : std_logic_vector(4 downto 0);
	signal weightOut0, weightOut1, weightOut2, weightOut3, weightOut4, weightOut5, weightOut6, weightOut7 : STD_LOGIC_VECTOR(7 downto 0);
	signal weightIn0, weightIn1, weightIn2, weightIn3, weightIn4, weightIn5, weightIn6, weightIn7 : std_logic_vector(7 downto 0);
	signal sigIn : std_logic_vector(7 downto 0);

begin	
	sigDerMod : entity work.sigDerivative(behavioral)
		PORT MAP(input => sigIn, output => sigDer);

	extSigDer <= "000" & sigDer;

	weightUpdateMod0 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn0,
					learnRate => defLearnRate,
					prevNodeActiv => input(4 downto 0),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp0);
	weightUpdateMod1 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn1,
					learnRate => defLearnRate,
					prevNodeActiv => input(9 downto 5),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp1);
	weightUpdateMod2 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn2,
					learnRate => defLearnRate,
					prevNodeActiv => input(14 downto 10),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp2);
	weightUpdateMod3 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn3,
					learnRate => defLearnRate,
					prevNodeActiv => input(19 downto 15),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp3);
	weightUpdateMod4 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn4,
					learnRate => defLearnRate,
					prevNodeActiv => input(24 downto 20),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp4);
	weightUpdateMod5 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn5,
					learnRate => defLearnRate,
					prevNodeActiv => input(29 downto 25),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp5);
	weightUpdateMod6 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn6,
					learnRate => defLearnRate,
					prevNodeActiv => input(34 downto 30),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp6);
	weightUpdateMod7 : entity work.weightUpdateHidden(behavioral)
		PORT MAP(currWeight => weightIn7,
					learnRate => defLearnRate,
					prevNodeActiv => input(39 downto 35),
					deltaKArray => weightDeltaKIn,
					sigIn => sigIn,
					newWeight => newWeightTemp7);
		
	newWeight <= newWeightTemp0; -- for verification purposes

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
	sig : entity work.Sigmoid(behavioral)
		PORT MAP(input => sigIn, output => tempOut);		
	output <= tempOut;
	
end Behavioral;

