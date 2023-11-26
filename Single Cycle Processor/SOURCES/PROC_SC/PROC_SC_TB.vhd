----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 13.04.2022 00:15:27
-- Design Name: 
-- Module Name: PROC_SC_TB - Behavior
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

entity PROC_SC_TB is
--  Port ( );
end PROC_SC_TB;

architecture Behavior of PROC_SC_TB is

    component PROC_SC is
    
        port(rst: in std_logic;
             clk: in std_logic
            );
 
    end component;

    signal clk: std_logic := '0';
    signal rst: std_logic := '0';
    constant clk_period: time := 100ns; 

begin

    uut: PROC_SC port map(clk => clk,
                          rst => rst
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
   
        rst <= '1';
        wait for clk_period*2;
        
        rst <= '0';
        wait;
        
   end process;
   
end;
