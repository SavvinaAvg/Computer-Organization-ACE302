----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 12:09:33
-- Design Name: 
-- Module Name: RAM_TB - Behavior
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

entity RAM_TB is
--  Port ( );
end RAM_TB;

architecture Behavior of RAM_TB is

    component RAM is
        port(
            clk        :  in std_logic;
            inst_addr  :  in std_logic_vector(10 downto 0);
            inst_dout  :  out std_logic_vector(31 downto 0);
            data_we    :  in std_logic;
            data_addr  :  in std_logic_vector(10 downto 0);
            data_din   :  in std_logic_vector(31 downto 0);
            data_dout  :  out std_logic_vector(31 downto 0)
            );
   end component;
   
----------------------- INPUTS --------------------------------
   signal clk: std_logic := '0';
   signal inst_addr: std_logic_vector(10 downto 0) := (others => '0');
   signal data_we: std_logic := '0';
   signal data_addr: std_logic_vector(10 downto 0) := (others => '0');
   signal data_din: std_logic_vector(31 downto 0) := (others => '0');
            
------------------------ OUTPUTS -------------------------------------
   signal data_dout: std_logic_vector(31 downto 0);
   signal inst_dout: std_logic_vector(31 downto 0);
   
-------------------- CLOCK PERIOD DEFINITIONS -------------------------
   constant clk_period: time := 100ns;
   
begin

    uut: RAM port map(clk           =>  clk,
                      inst_addr     =>  inst_addr,
                      inst_dout     =>  inst_dout,
                      data_we       =>  data_we,
                      data_addr     =>  data_addr,
                      data_din      =>  data_din,
                      data_dout     =>  data_dout
                     );
                     
   clk_process: process
   begin
        clk <= '0';
        wait for clk_period/2;
        
        clk <= '1';
        wait for clk_period/2;
   end process;
   
   stim_proc: process
   begin
        
        data_we <= '0';
        data_addr <= "00000000000";
        data_din <= "00000000000000000000000000000000";
        inst_addr <= "00000000000";
        wait for clk_period;
        
        for i in 0 to 255 loop
            data_we <= '1';
            wait for 4ns;
            data_addr <= data_addr + 1;
            data_din <= data_din + 10;
        end loop;
        
        data_addr <= "00000000000";
        data_din <= "00000000000000000000000000000000";
        wait for clk_period;
        
        for i in 0 to 255 loop
            data_we <= '1';
            wait for 4ns;
            data_addr <= data_addr + 1;
            data_din <= data_din + 10;
        end loop;
        
        wait;
   end process;


end;
