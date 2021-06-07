library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bramka is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : out STD_LOGIC);
end bramka;

architecture Behavioral of bramka is

begin

    D <= A or B or C;

end Behavioral;
