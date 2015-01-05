library ieee;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_1164.all;
entity REG32B is
	port( load : in std_logic;
		  din : in std_logic_vector(31 downto 0);
		  fout:out std_logic_vector(31 downto 0)
		 );
end entity REG32B;
architecture bhv of REG32B is
 begin
	process(load,din)
	  begin
		if load'event and load='1' 
			then fout<=din;
		end if;
	end process;
end architecture bhv;
