library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity TESTCTL is 
	port ( clk : in std_logic;
	       clr : out std_logic;
	       load : out std_logic;
	       ena : out std_logic
	      );
end entity TESTCTL;
architecture bhv of TESTCTL is
signal Div2CLK : std_logic;
	begin
	 process (clk) begin
	 	if clk'event and clk='1' then 
		   Div2CLK <= not Div2CLK;
	 	end if;
	 end process;
	 process (clk,Div2CLK) 
	 	begin	
	  		if clk='0' and Div2CLK='0' then clr <= '1';
	    		else clr <= '0'; 
	     	end if;
	end process;
	load <= not Div2CLK;
	ena <= Div2CLK;
end architecture bhv;
