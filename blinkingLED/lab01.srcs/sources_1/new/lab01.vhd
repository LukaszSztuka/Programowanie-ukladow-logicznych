----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.03.2021 08:35:47
-- Design Name: 
-- Module Name: lab01 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lab01 is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           LED : out STD_LOGIC := '0';
           przycisk : in STD_LOGIC);
end lab01;

architecture Behavioral of lab01 is
type STANY is (stabilny, niestabilny, opoznienie);
signal stan, stan_nast : STANY;
signal czas : STD_LOGIC_VECTOR(4 downto 0 ) := "00000" ;
signal czas2 : STD_LOGIC_VECTOR(5 downto 0) := "000000" ;



begin

reg:process(clk, reset)
begin
if (reset='1') then
    stan <= stabilny;
elsif (clk'event and clk='1') then
    stan <=stan_nast;
end if;
end process reg;

komb:process(stan, czas, czas2, przycisk)
begin
    stan_nast<= stan;
    case stan is
        when stabilny =>
            if (przycisk='1') then
                stan_nast<= opoznienie;
                LED <= '0';
            else 
                stan_nast<= stabilny;
                LED <= '0';
            end if;
        when opoznienie =>
            if (przycisk='1') then
                if ( czas < "10100") then
                    stan_nast <= opoznienie;
                   
                else 
                    stan_nast <= niestabilny;
                end if;
                
            else 
                stan_nast <= stabilny;
            end if;
        when niestabilny =>
            if (czas2 < "101000") then -- ustawiæ na 1111101000 = 1000ms
                stan_nast <= niestabilny;
                LED <= '1';
            else
                stan_nast <= stabilny;
                
            end if;
    end case;
end process komb;

licznik: process(clk, reset, czas, czas2)
begin

    if reset = '1' then 
        czas <="00000";
        czas2 <="000000";
        
    elsif (clk'event and clk='1') then
        if (stan = opoznienie and czas /= "10100" ) then
            czas <= czas + "00001";
        elsif (stan = niestabilny and czas2 /= "101000") then  -- ustawiæ na 1111101000 = 1000ms
            czas2 <= czas2 + "000001";
        else
            czas <="00000";
            czas2 <="000000";
        end if;
    end if;
end process licznik;     

end Behavioral;
