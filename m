library ieee;
use ieee.std_logic_1164.all;
entity MUX41A is
	port( a,b,c,d,s0,s1 : in std_logic;
	                  y : out std_logic
	     );
end entity MUX41A;
architecture bhv of MUX41A is
 signal s : std_logic_vector(1 downto 0);
  begin 
  s <= s1&s0;
	process(s1,s0)
	begin
	 case (s) is
	 when "00" => y<=a;
    when "01" => y<=b;
	 when "10" => y<=c;
	 when "11" => y<=d;
	 when others => NULL;
	 end case;
	end process;
end architecture bhv;
