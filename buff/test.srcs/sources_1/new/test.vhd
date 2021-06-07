library ieee;
use ieee.std_logic_1164.all; 

library unisim; -- for xilinx IOBUF
use unisim.vcomponents.all;

entity iobuffer_example is
   port (
      I_CLK                : in    std_logic;  -- synchronized with bidir bus
      IO_DATA              : inout std_logic;  -- data to/from external pin on bidir bus
      I_DIR_CTRL           : in    std_logic;  -- from other VHDL logic, controlling bidir bus direction
      O_DATA_FROM_EXTERNAL : out   std_logic;  -- data received over bidir bus
      I_DATA_TO_EXTERNAL   : in    std_logic);  -- data to send over bidir bus

end entity iobuffer_example;

architecture io_buffer_arch of iobuffer_example is
   signal data_in : std_logic;
   signal data_out : std_logic;
begin

   IOBUF_Inst : IOBUF
      port map (
         O     => data_in,              -- data from bidir bus
         IO    => IO_DATA,              -- data on bidir bus
         I     => data_out,             -- data to bidir bus
         T     => I_DIR_CTRL); -- 3-state enable input, high=input, low=output

   Register_Input : process (I_CLK) is
   begin
      if (falling_edge(I_CLK)) then
         O_DATA_FROM_EXTERNAL <= data_in;
      end if;
   end process Register_Input;

   Register_Output : process (I_CLK) is
   begin
      if (rising_edge(I_CLK)) then
         data_out <= I_DATA_TO_EXTERNAL;
      end if;
   end process Register_Output;

end architecture io_buffer_arch;
