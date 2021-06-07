library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity bramka_tb is

end bramka_tb;

architecture Behavioral of bramka_tb is

component bramka is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C : in STD_LOGIC;
           D : out STD_LOGIC);
end component;

    signal Atb : std_logic;
    signal Btb : std_logic;
    signal Ctb : std_logic;
    signal Dtb : std_logic;

begin
   -- Stimulus process
   stim_proc: process
   begin		
     Atb <= '0'; Btb <= '0'; Ctb <= '0'; wait for 10 ns ;
     Atb <= '0'; Btb <= '0'; Ctb <= '1'; wait for 10 ns ;
	 Atb <= '0'; Btb <= '1'; Ctb <= '0'; wait for 10 ns ;
	 
	 assert false severity  failure;    
   end process;

    i_bramka : bramka
    Port map(
        A => Atb,
        B => Btb,
        C => Ctb,
        D => Dtb
        );

end Behavioral;
