----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2021 08:21:06
-- Design Name: 
-- Module Name: spi - Behavioral
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
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity spi is
    Port ( chipS : out STD_LOGIC := '1';
           clk : out STD_LOGIC := '0';
           mosi : out STD_LOGIC := '0';
           miso : in std_logic_vector(7 downto 0) := "00000000";
           przycisk : in std_logic);
end spi;

architecture Behavioral of spi is

type STANY is (stabilny, wysylanie);
signal stan, stan_nast : STANY;
signal czas : std_logic_vector(3 downto 0) := "0000" ; 
signal clkIN : std_logic ;
signal dane : std_logic_vector(7 downto 0) :="00000000";
begin

clk_proc : process
begin 
    clkIN <= '0';
    wait for 5 ns;
    clkIN <= '1';
    wait for 5 ns;
end process;


reg: process(clkIN)
begin
if (clkIN'event and clkIN='1') then
    stan <= stan_nast;
end if;
end process reg;

komb: process(stan, czas, przycisk, clkIN, miso)
begin
    stan_nast <= stan;
    if (stan'event and stan = stabilny) then
        dane <= "00000000"; 
    end if;
    case stan is 
    
        when stabilny => 
                clk <= '0';
                chipS <= '1'; 
                mosi <= '0';
                
            if (przycisk'event and przycisk = '1') then
                stan_nast <= wysylanie;
                dane <= miso;
            else
                stan_nast <= stabilny;                 
            end if;

        when wysylanie => 
                clk <= clkIN;
                chipS <= '0';
                mosi <= dane(7);
            if ( czas < "0111") then
                if (clkIN'event and clkIN = '1') then
                    dane <= dane (6 downto 0) & '0';
                end if;
            else
                stan_nast <= stabilny;
                
            end if;    
           
    end case;
end process komb;

licznik: process(clkIN, czas)
begin

        if (clkIN'event and clkIN='1') then
            if (stan = wysylanie and czas /= "1000" ) then
                czas <= czas + "0001";
            else
                czas <="0000";
            end if;
        end if;
     
end process licznik; 


end Behavioral;
