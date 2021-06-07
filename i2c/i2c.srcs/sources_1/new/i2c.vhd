----------------------------------------------------------------------------------
-- Company: Politechnika Wroc³awska
-- Engineer: £ukasz Sztuka 243168
-- 
-- Create Date: 02.05.2021 12:38:10
-- Design Name: 
-- Module Name: i2c - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 2020.2
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
USE ieee.numeric_std.ALL;

entity i2c is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           adres : in STD_LOGIC_VECTOR(6 downto 0) := "1001000";
           przycisk : in STD_LOGIC;
           scl : out STD_LOGIC := '1';
           sda : inout STD_LOGIC);
end i2c;

architecture Behavioral of i2c is

type STANY is (Oczekiwanie, SekStart, WysAdr, WysRW, OdbACK, OdbACK2, OdbData, SekStop);
signal stan, stan_nast : STANY;
signal czas7  : STD_LOGIC_VECTOR(3 downto 0) := "0000" ;
signal czas8 : STD_LOGIC_VECTOR(3 downto 0) := "0000" ;
signal adresSig : STD_LOGIC_VECTOR(6 downto 0) := "0000000";

begin

reg:process(clk, reset)
begin
if (reset='1') then
    stan <= Oczekiwanie;
elsif (clk'event and clk='1') then
    stan <=stan_nast;
end if;
end process reg;

komb:process(stan, przycisk, clk, czas7, czas8)
begin
    stan_nast <= stan;
    case stan is
    
        when Oczekiwanie =>
            sda <= '1';
            scl <= '1';         
            if (przycisk='1') then
                stan_nast <= SekStart;
            else 
                stan_nast <= Oczekiwanie;  
            end if;
            
        when SekStart =>
            stan_nast <= WysAdr;
            sda <= '0';            
            adresSig <= adres;
            scl <= clk;
            
        when WysAdr =>            
            if (czas7 < "0110") then
                sda <= adresSig(6);
                scl <= clk;
                if (clk'event and clk = '1') then
                    adresSig <= adresSig (5 downto 0) & '0';
                end if;
            elsif (czas7 < "0111") then
                sda <= adresSig(6);
                scl <= clk;
                stan_nast <= WysRW;
                if (clk'event and clk = '1') then
                    adresSig <= adresSig (5 downto 0) & '0';
                end if;
                scl <= clk;
                stan_nast <= WysRW;
            end if;
            
        when WysRW =>
            sda <= '1';
            stan_nast <= OdbACK;
            scl <= clk;
            adresSig <= adres;
        when OdbACK =>
            scl <= clk;
            sda <= 'Z';           
            if (sda /= '0') then            -- 1 =dzia³a 0=nie dzi³a 
                stan_nast <= OdbData;
            else
                stan_nast <= WysAdr;
            end if;
        when OdbData =>
            scl <= clk;

            if (czas8 < "0111") then
                stan_nast <= OdbData;
            else
                stan_nast <= OdbACK2;
            end if;
        when OdbACK2 =>
            scl <= clk;
            if (sda /= '0') then            -- 1 =dzia³a 0=nie dzi³a 
                stan_nast <= SekStop;
            else
                stan_nast <= OdbData;
            end if; 
        when SekStop =>
            sda <= '0';
            scl <= '1';
            if (clk'event and clk='0') then
                sda <= '1';
            end if;
            stan_nast <= Oczekiwanie;
    end case;
end process komb;

licznik: process(clk, czas7, czas8)
begin

    if (clk'event and clk='1') then
        if (stan = WysAdr) then
            czas7 <= czas7 + "0001";
        elsif (stan = OdbData) then 
            czas8 <= czas8 + "0001";
        else
            czas7 <="0000";
            czas8 <="0000";
        end if;
    end if;
end process licznik;  

end Behavioral;
