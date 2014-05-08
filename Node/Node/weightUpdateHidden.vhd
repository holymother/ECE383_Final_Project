--Based on given input, returns an updated weight value, for hidden level weights
--383 Final Project
--By C2C William Parks
--7 May 2014

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

use IEEE.NUMERIC_STD.ALL;

entity weightUpdateHidden is
	Port (
		currWeight : in std_logic_vector(7 downto 0);
		learnRate : in std_logic_vector(7 downto 0);
		prevNodeActiv : in std_logic_vector(4 downto 0);
		deltaKArray : in std_logic_vector(63 downto 0);
		sigIn : in std_logic_vector(7 downto 0);
		newWeight : out std_logic_vector(7 downto 0)
	);
end weightUpdateHidden;

architecture Behavioral of weightUpdateHidden is
	signal deltaKSum : std_logic_vector(7 downto 0);
	signal sigDer : std_logic_vector(4 downto 0);
	signal extSigDer : std_logic_vector(7 downto 0);
	signal extPrevNode : std_logic_vector(7 downto 0);
	signal leftMultTemp, rightMultTemp, fullProd : std_logic_vector(7 downto 0);
begin
	
	deltaKSum <= std_logic_vector(signed(deltaKArray(7 downto 0)) + signed(deltaKArray(15 downto 8)) + signed(deltaKArray(23 downto 16)) + signed(deltaKArray(31 downto 24)) + signed(deltaKArray(39 downto 32)) + signed(deltaKArray(47 downto 40)) + signed(deltaKArray(55 downto 48)) + signed(deltaKArray(63 downto 56)));

	sigDerMod : entity work.sigDerivative(behavioral)
		PORT MAP(input => sigIn, output => sigDer);	
	
	extSigDer <= "000" & sigDer;
	extPrevNode <= "000" & prevNodeActiv;

	multL : entity work.multiplier(behavioral)
		PORT MAP(in1 => learnRate, in2 => extPrevNode, output => leftMultTemp);
	multR : entity work.multiplier(behavioral)
		PORT MAP(in1 => extSigDer, in2 => deltaKSum, output => rightMultTemp);
	multAll : entity work.multiplier(behavioral)
		PORT MAP(in1 => leftMultTemp, in2 => rightMultTemp, output => fullProd );
		
	newWeight <= std_logic_vector(signed(fullProd) + signed(currWeight));
end Behavioral;

