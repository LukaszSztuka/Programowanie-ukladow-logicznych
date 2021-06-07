----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2021 10:09:24
-- Design Name: 
-- Module Name: Tb_spi - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Tb_spi is
end Tb_spi;

architecture Behavioral of Tb_spi is

    Component spi is 
        Port ( chipS : out STD_LOGIC;
           clk : out STD_LOGIC;
           mosi : out STD_LOGIC;
           miso : in std_logic_vector(7 downto 0);
           przycisk : in std_logic);
    end component;

 signal chipS_tb :  STD_LOGIC;
 signal clk_tb :  STD_LOGIC;
 signal mosi_tb :  STD_LOGIC;
 signal przycisk_tb :  std_logic := '0';
 signal miso_tb : std_logic_vector (7 downto 0 );
 

begin

i_spi : spi
port map( chipS => chipS_tb,
        clk => clk_tb,
        mosi => mosi_tb,
        miso => miso_tb,
        przycisk => przycisk_tb);
        
        
    tb : process
    begin
        miso_tb <= "01010101";
        wait for 100 ns;
        przycisk_tb <= '1';        
        wait for 20 ns;
        przycisk_tb <= '0';
        wait for 100 ns;
        
        miso_tb <= "11001100";
        wait for 200 ns;
        przycisk_tb <= '1';        
        wait for 10 ns;
        przycisk_tb <= '0';
        wait for 100 ns;
        assert false severity failure;
    end process tb;

end Behavioral;
