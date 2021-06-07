----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 22.05.2021 18:04:34
-- Design Name: 
-- Module Name: iobuffer_tb - Behavioral
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

entity iobuffer_tb is
--  Port ( );
end iobuffer_tb;

architecture Behavioral of iobuffer_tb is

Component iobuffer_example is
    Port ( 
      I_CLK                : in    std_logic;  -- synchronized with bidir bus
      IO_DATA              : inout std_logic;  -- data to/from external pin on bidir bus
      I_DIR_CTRL           : in    std_logic;  -- from other VHDL logic, controlling bidir bus direction
      O_DATA_FROM_EXTERNAL : out   std_logic;  -- data received over bidir bus
      I_DATA_TO_EXTERNAL   : in    std_logic);  -- data to send over bidir bus
    end component;

signal I_CLK_tb : std_logic;  -- synchronized with bidir bus
signal IO_DATA_tb : std_logic;  -- data to/from external pin on bidir bus
signal  I_DIR_CTRL_tb  : std_logic;  -- from other VHDL logic, controlling bidir bus direction
signal  O_DATA_FROM_EXTERNAL_tb :std_logic;  -- data received over bidir bus
signal  I_DATA_TO_EXTERNAL_tb : std_logic;  -- data to send over bidir bus

     -- Clock period definitions
   constant CLK_period : time := 10 ns;
   
begin

   -- Definicja Zegara
   CLK_process :process
   begin
        I_CLK_tb <= '0';
        wait for CLK_period/2;
        I_CLK_tb <= '1';
        wait for CLK_period/2;
   end process;

    i_iobuffer_example : iobuffer_example
    port map(
      I_CLK => I_CLK_tb,
      IO_DATA => IO_DATA_tb,
      I_DIR_CTRL => I_DIR_CTRL_tb,
      O_DATA_FROM_EXTERNAL => O_DATA_FROM_EXTERNAL_tb,
      I_DATA_TO_EXTERNAL => I_DATA_TO_EXTERNAL_tb
      );
      
      tb : process
      begin
      
        wait for 60 ns;
        
        
        assert false severity failure;
       
     END PROCESS tb;
  --  End Test Bench   
end Behavioral;
