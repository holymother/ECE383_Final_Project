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
			  weightDeltaKIn : in std_logic_vector(63 downto 0);
			  update : in std_logic;
			  newWeight : out std_logic_vector(7 downto 0); --for testing
			  testOutWeight : out std_logic_vector(7 downto 0);
			  output : out STD_LOGIC_VECTOR(4 downto 0)
	 );
end HiddenNode;


architecture Behavioral of HiddenNode is
--	signal errorK : std_logic_vector(7 downto 0);
--	signal extCorrOut, extActOut : std_logic_vector(7 downto 0);
	signal sigDer : std_logic_vector(4 downto 0);
	signal extSigDer : std_logic_vector(7 downto 0);
	signal deltaKTemp : std_logic_vector(7 downto 0);

	--combinationally set to new value (continuously)
	signal newWeightTemp0, newWeightTemp1, newWeightTemp2, newWeightTemp3, newWeightTemp4, newWeightTemp5, newWeightTemp6, newWeightTemp7 : std_logic_vector(7 downto 0);

	--newWeightTemp, but controlled to see if that edge is connected. Forced to 0 otherwise
	signal updateWeight0, updateWeight1, updateWeight2, updateWeight3, updateWeight4, updateWeight5, updateWeight6, updateWeight7 : std_logic_vector(7 downto 0) := "00000000";

	--storage for synchronous update of all weight values
	signal w0Stor, w1Stor, w2Stor, w3Stor, w4Stor, w5Stor, w6Stor, w7Stor : std_logic_vector(7 downto 0);

	--Signal to access the output of the node
	signal tempOut : std_logic_vector(4 downto 0);
	
	--In and out refer to pre/post multiply with activation value.
	signal weightIn0 : std_logic_vector(7 downto 0) := default0;
	signal weightIn1 : std_logic_vector(7 downto 0) := default1;
	signal weightIn2 : std_logic_vector(7 downto 0) := default2;
	signal weightIn3 : std_logic_vector(7 downto 0) := default3;
	signal weightIn4 : std_logic_vector(7 downto 0) := default4;
	signal weightIn5 : std_logic_vector(7 downto 0) := default5;
	signal weightIn6 : std_logic_vector(7 downto 0) := default6;
	signal weightIn7 : std_logic_vector(7 downto 0) := default7;
	signal weightOut0, weightOut1, weightOut2, weightOut3, weightOut4, weightOut5, weightOut6, weightOut7 : std_logic_vector(7 downto 0);
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
	
	updateWeight0 <= newWeightTemp0 when numActive > 0 else (others => '0');
	updateWeight1 <= newWeightTemp1 when numActive > 1 else (others => '0');
	updateWeight2 <= newWeightTemp2 when numActive > 2 else (others => '0');
	updateWeight3 <= newWeightTemp3 when numActive > 3 else (others => '0');
	updateWeight4 <= newWeightTemp4 when numActive > 4 else (others => '0');
	updateWeight5 <= newWeightTemp5 when numActive > 5 else (others => '0');
	updateWeight6 <= newWeightTemp6 when numActive > 6 else (others => '0');
	updateWeight7 <= newWeightTemp7 when numActive > 7 else (others => '0');	

	--Sychronize updates, as update weights are dependent on other weights
	process(update)
	begin
		if rising_edge(update) then
			w0Stor <= updateWeight0;
			w1Stor <= updateWeight1;
			w2Stor <= updateWeight2;
			w3Stor <= updateWeight3;
			w4Stor <= updateWeight4;
			w5Stor <= updateWeight5;
			w6Stor <= updateWeight6;
			w7Stor <= updateWeight7;
		elsif falling_edge(update) then
			weightIn0 <= w0Stor;
			weightIn1 <= w1Stor;
			weightIn2 <= w2Stor;
			weightIn3 <= w3Stor;
			weightIn4 <= w4Stor;
			weightIn5 <= w5Stor;
			weightIn6 <= w6Stor;
			weightIn7 <= w7Stor;
		else
			w0Stor <= w0Stor;
			w1Stor <= w1Stor;
			w2Stor <= w2Stor;
			w3Stor <= w3Stor;
			w4Stor <= w4Stor;
			w5Stor <= w5Stor;
			w6Stor <= w6Stor;
			w7Stor <= w7Stor;
			weightIn0 <= weightIn0;
			weightIn1 <= weightIn1;
			weightIn2 <= weightIn2;
			weightIn3 <= weightIn3;
			weightIn4 <= weightIn4;
			weightIn5 <= weightIn5;
			weightIn6 <= weightIn6;
			weightIn7 <= weightIn7;
		end if;
	end process;

	testOutWeight <= weightIn0;

--	--NOTE: THESE ARE THE RECEIVING WEIGHTS
--	weightIn0 <= default0 when numActive >= 1 else
--					 (others => '0');
--   weightIn1 <= default1 when numActive >= 2 else
--					 (others => '0');
--   weightIn2 <= default2 when numActive >= 3 else
--					 (others => '0');
--   weightIn3 <= default3 when numActive >= 4 else
--					 (others => '0');
--   weightIn4 <= default4 when numActive >= 5 else
--					 (others => '0');
--   weightIn5 <= default5 when numActive >= 6 else
--					 (others => '0');
--   weightIn6 <= default6 when numActive >= 7 else
--					 (others => '0');
--   weightIn7 <= default7 when numActive = 8 else
--					 (others => '0');

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

