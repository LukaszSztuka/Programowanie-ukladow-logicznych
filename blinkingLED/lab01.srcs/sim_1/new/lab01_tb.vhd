----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 17:20:28
-- Design Name: 
-- Module Name: lab01_tb - Behavioral
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

entity lab01_tb is
end lab01_tb;

architecture Behavioral of lab01_tb is

    Component lab01 is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           LED : out STD_LOGIC;
           przycisk : in STD_LOGIC);
    end component;
    
    signal reset_tb : std_logic := '0';
    signal clk_tb : std_logic := '0';
    signal LED_tb : std_logic := '0';
    signal przycisk_tb : std_logic := '0';
    
    
     -- Clock period definitions
   constant CLK_period : time := 10 ns;
 
begin

   -- Definicja Zegara
   CLK_process :process
   begin
		clk_tb <= '0';
		wait for CLK_period/2;
		clk_tb <= '1';
		wait for CLK_period/2;
   end process;

    i_lab01 : lab01
    port map ( reset => reset_tb,
    clk => clk_tb,
    LED => LED_tb,
    przycisk => przycisk_tb);
     

  --  Test Bench Statements
     tb : PROCESS
     BEGIN

        wait for 10 ns; 
        przycisk_tb <= '1';
        wait for 310 ns; 
        przycisk_tb <= '0';
        wait for 700 ns;
        przycisk_tb <= '1';
        wait for 310 ns; 
        przycisk_tb <= '0';
        wait for 10 ns;
        reset_tb <= '1';
        wait for 10 ns;
        reset_tb <= '0';
        wait for 200 ns;
        przycisk_tb <= '1';
        wait for 25 ns; 
        przycisk_tb <= '0';
        wait for 700 ns;
        assert false severity failure;

     END PROCESS tb;
  --  End Test Bench 


end Behavioral;
