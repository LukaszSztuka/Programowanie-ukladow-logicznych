----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.05.2021 19:22:32
-- Design Name: 
-- Module Name: i2c_tb - Behavioral
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
USE ieee.numeric_std.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity i2c_tb is

end i2c_tb;

architecture Behavioral of i2c_tb is


    Component i2c is
    Port ( reset : in STD_LOGIC;
           clk : in STD_LOGIC;
           adres : in STD_LOGIC_VECTOR(6 downto 0);
           przycisk : in STD_LOGIC;
           scl : out STD_LOGIC := '1';
           sda : inout STD_LOGIC);
    end component;
     
    signal reset_tb : std_logic := '0';
    signal clk_tb : std_logic := '0';
    signal adres_tb : std_logic_vector(6 downto 0);
    signal przycisk_tb : std_logic := '0';
    signal scl_tb : std_logic := '0';
    signal sda_tb : std_logic := 'Z';
    
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
   
   i_i2c : i2c
   port map ( reset => reset_tb,
   clk => clk_tb,
   przycisk => przycisk_tb,
   adres => adres_tb,
   sda => sda_tb,
   scl => scl_tb);
   
   tb :process
   begin 
   
        wait for 10 ns; 
        reset_tb <= '1';
        adres_tb <= "1010101";
        wait for 10 ns;
        reset_tb <= '0';
        wait for 10 ns;
        przycisk_tb <= '1';
        wait for 10 ns; 
        przycisk_tb <= '0';
        wait for 85 ns;    --ACK1 + 1
        sda_tb <= '1';
        wait for 20 ns;     --2
        sda_tb <= '0';
        wait for 10 ns;     --3
        sda_tb <= '1';
        wait for 10 ns;     --4
        sda_tb <= '0';
        wait for 10 ns;     --5
        sda_tb <= '1';
        wait for 10 ns;     --6
        sda_tb <= '0';
        wait for 10 ns;     --7
        sda_tb <= '1';
        wait for 10 ns;     --8
        sda_tb <= '0';
        wait for 10 ns; 
        sda_tb <= '1';      --ACK2
        wait for 10 ns;     
        sda_tb <= 'Z';
        wait for 60 ns;

        przycisk_tb <= '1';
        wait for 10 ns; 
        przycisk_tb <= '0';
        wait for 80 ns;    --ACK1 + 1
        sda_tb <= '1';
        wait for 20 ns;     --2
        sda_tb <= '0';
        wait for 10 ns;     --3
        sda_tb <= '1';
        wait for 10 ns;     --4
        sda_tb <= '0';
        wait for 10 ns;     --5
        sda_tb <= '1';
        wait for 10 ns;     --6
        sda_tb <= '0';
        wait for 10 ns;     --7
        sda_tb <= '1';
        wait for 10 ns;     --8
        sda_tb <= '0';
        wait for 10 ns; 
        sda_tb <= '1';      --ACK2
        wait for 20 ns;     
        sda_tb <= 'Z';
        wait for 60 ns;
        assert false severity failure;
 
     END PROCESS tb;
  --  End Test Bench 

end Behavioral;
