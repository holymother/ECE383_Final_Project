--Learning Network
--Should have full back propagation capabilities
--383 Final Project
--By C2C William Parks
--8 May 2014

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LearningNetwork is
    Port ( Input : in  STD_LOGIC_VECTOR (1 downto 0);
           Output : out  STD_LOGIC_VECTOR (4 downto 0);
           update : in  STD_LOGIC;
           corrOut : in  STD_LOGIC_VECTOR (4 downto 0));
end LearningNetwork;

architecture Behavioral of LearningNetwork is
	signal leftIn, rightIn : std_logic_vector(4 downto 0);
	signal middleIn : std_logic_vector(9 downto 0);
	signal mLOut, mMOut, mROut : std_logic_vector(4 downto 0);
	signal weightDeltaKLeft, weightDeltaKMiddle, weightDeltaKRight : std_logic_vector(63 downto 0);
	signal topIn : std_logic_vector(14 downto 0);
begin

	leftIn <= "10000" when input(1) = '1' else
				 "00000";
				 
	rightIn <= "10000" when input(0) = '1' else
				  "00000";
	
	weightDeltaKLeft <= (others => '0');
	weightDeltaKMiddle <= (others => '0');
	weightDeltaKRight <= (others => '0');
	
	middleIn <= rightIn & leftIn;
	topIn <= mROut & mMOut & mLOut;
	
	mL : entity work.hiddenNode(behavioral)
		generic map(
			numActive => 2,
			default0 => "01100000",
			default1 => "10000000"
		)	
		PORT MAP(
			input => "000000000000000000000000000000" & middleIn,
			weightDeltaKIn => weightDeltaKLeft,
			update => update,
			output => mLOut
		);

	mM : entity work.hiddenNode(behavioral)
		generic map(
			numActive => 2,
			default0 => "10000000",
			default1 => "01100000"
		)	
		PORT MAP(
			input => "000000000000000000000000000000" & middleIn,
			weightDeltaKIn => weightDeltaKMiddle,
			update => update,
			output => mMOut
		);

	mR : entity work.hiddenNode(behavioral)
		generic map(
			numActive => 2,
			default0 => "00010100",
			default1 => "00010100"
		)	
		PORT MAP(
			input => "000000000000000000000000000000" & middleIn,
			weightDeltaKIn => weightDeltaKRight,
			update => update,
			output => mROut
		);

--	Port ( input : in  STD_LOGIC_VECTOR(39 downto 0); -- For 8 total 5 bit inputs
--			  weightDeltaKIn : in std_logic_vector(63 downto 0);
--			  update : in std_logic;
--			  newWeight : out std_logic_vector(7 downto 0); --for testing
--			  testOutWeight : out std_logic_vector(7 downto 0);
--			  output : out STD_LOGIC_VECTOR(4 downto 0)
--	 );
		
		
	t : entity work.OutputNode(behavioral)
		generic map(
			numActive => 3,
			default0 => "10100000",
			default1 => "10100000",
			default2 => "01010110"
		)
		PORT MAP(
			input => "0000000000000000000000000" & topIn,
			corrOut => corrOut,
			update => update,
--			weightDeltaK => ,
			output => output
		);
		
--		    Port ( input : in  STD_LOGIC_VECTOR(39 downto 0); -- For 8 total 5 bit inputs
--			  corrOut : in STD_LOGIC_VECTOR(4 downto 0);
--			  update : in std_logic;
--			  weightDeltaK : out std_logic_vector(63 downto 0);
--			  deltaK : out std_logic_vector(7 downto 0);
--			  newWeight : out std_logic_vector(7 downto 0); --for testing
--			  testOutWeight : out std_logic_vector(7 downto 0); --for testing
--			  output : out STD_LOGIC_VECTOR(4 downto 0)
--	 );

end Behavioral;

