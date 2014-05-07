--Test network for the neural net implementation
--383 Final project
--By C2C William Parks
--5 May 2014
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Network is
    Port ( Input : in  STD_LOGIC_VECTOR (1 downto 0);
			  bROutput : out STD_LOGIC_VECTOR(4 downto 0);
			  bLOutput : out STD_LOGIC_VECTOR(4 downto 0);
			  mLOutput : out STD_LOGIC_VECTOR(4 downto 0);
			  mMOutput : out STD_LOGIC_VECTOR(4 downto 0);
			  mROutput : out STD_LOGIC_VECTOR(4 downto 0);
           Output : out  STD_LOGIC_VECTOR(4 downto 0));
end Network;

architecture Behavioral of Network is
	signal leftIn, rightIn : std_logic_vector(4 downto 0);
	signal middleIn : std_logic_vector(9 downto 0);
	signal topIn : std_logic_vector(14 downto 0);
	signal bLOut, bROut, mLOut, mMOut, mROut : std_logic_vector(4 downto 0);
begin
		
	leftIn <= "10000" when input(1) = '1' else
				 "00000";
				 
	rightIn <= "10000" when input(0) = '1' else
				  "00000";
	
	bROutput <= bROut;
	bLOutput <= bLOut;
	mLOutput <= mLOut;
	mMOutput <= mMOut;
	mROutput <= mROut;
	
	--intput is 5 bit. output is 8 bit
	--middleIn <= bROut & bLOut;
	middleIn <= rightIn & leftIn;
	topIn <= mROut & mMOut & mLOut;
	
	bL : entity work.Node(behavioral)
		generic map(
			numActive => 1,
			default0 => "01000000"
		)
		PORT MAP (
			input => "00000000000000000000000000000000000" & leftIn,
			output => bLOut
	);

	bR : entity work.Node(behavioral)
		generic map(
			numActive => 1,
			default0 => "01000000"
		)
		PORT MAP (
			input => "00000000000000000000000000000000000" & rightIn,
			output => bROut
	);
	
	mL : entity work.Node(behavioral)
		generic map(
			numActive => 2,
			default0 => "01100000",
			default1 => "10000000"
		)
		PORT MAP (
			input => "000000000000000000000000000000" & middleIn,
			output => mLOut
	);
	
	mM : entity work.Node(behavioral)
		generic map(
			numActive => 2,
			default0 => "10000000",
			default1 => "01100000"
		)
		PORT MAP (
			input => "000000000000000000000000000000" & middleIn,
			output => mMOut
	);
	
	mR : entity work.Node(behavioral)
		generic map(
			numActive => 2,
			default0 => "00010100",
			default1 => "00010100"
		)
		PORT MAP (
			input => "000000000000000000000000000000" & middleIn,
			output => mROut
	);
	
	t : entity work.Node(behavioral)
		generic map(
			numActive => 3,
			default0 => "10100000",
			default1 => "10100000",
			default2 => "01010110" --01010110
		)
		PORT MAP (
			input => "0000000000000000000000000" & topIn,
			output => output
	);
	
end Behavioral;

