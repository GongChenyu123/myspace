library  ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity DIV10 is
	port (clkk : in std_logic;
	         k : out std_logic
	      );
end entity DIV10;
architecture bhv of DIV10 is
 signal s : std_logic;
 signal c : std_logic_vector(3 downto 0);
   begin
     process(clkk,c) begin
     	if rising_edge(clkk) then
         if (c="1001") then c<="0000"; 
				else c<=c+1;
		    end if;
         if (c="0100") then s<=not s; 
				elsif(c="0000") then s<=not s;
         end if;
      end if;
	  end process;
k<=s;
end architecture bhv;
