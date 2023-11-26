----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 15.03.2022 17:24:58
-- Design Name: 
-- Module Name: MUX_32 - Behavioral
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

package mux_pkg is
    type muxIn is array(31 downto 0)of std_logic_vector(31 downto 0);
end package;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use work.mux_pkg.all;

entity MUX_32 is
--  Port ( );
    port(
        Min:  in muxIn;
        sel:  in std_logic_vector(4 downto 0);
        Mout: out std_logic_vector(31 downto 0)
        );
end MUX_32;

architecture Behavioral of MUX_32 is

signal temp: std_logic_vector(31 downto 0);
begin

process(Min,temp,sel)
begin
  
       if sel = "00000" then temp <= Min(0);  
    elsif sel = "00001" then temp <= Min(1);
    elsif sel = "00010" then temp <= Min(2);
    elsif sel = "00011" then temp <= Min(3);
    elsif sel = "00100" then temp <= Min(4);
    elsif sel = "00101" then temp <= Min(5);
    elsif sel = "00110" then temp <= Min(6);
    elsif sel = "00111" then temp <= Min(7);
    elsif sel = "01000" then temp <= Min(8);
    elsif sel = "01001" then temp <= Min(9);
    elsif sel = "01010" then temp <= Min(10);
    elsif sel = "01011" then temp <= Min(11);
    elsif sel = "01100" then temp <= Min(12);
    elsif sel = "01101" then temp <= Min(13);
    elsif sel = "01110" then temp <= Min(14);
    elsif sel = "01111" then temp <= Min(15);
    elsif sel = "10000" then temp <= Min(16);
    elsif sel = "10001" then temp <= Min(17);
    elsif sel = "10010" then temp <= Min(18);
    elsif sel = "10011" then temp <= Min(19);
    elsif sel = "10100" then temp <= Min(20);
    elsif sel = "10101" then temp <= Min(21);
    elsif sel = "10110" then temp <= Min(22);
    elsif sel = "10111" then temp <= Min(23);
    elsif sel = "11000" then temp <= Min(24);
    elsif sel = "11001" then temp <= Min(25);
    elsif sel = "11010" then temp <= Min(26);
    elsif sel = "11011" then temp <= Min(27);
    elsif sel = "11100" then temp <= Min(28);
    elsif sel = "11101" then temp <= Min(29);
    elsif sel = "11110" then temp <= Min(30);
    elsif sel = "11111" then temp <= Min(31);


end if;
end process;

Mout <= temp after 10ns;
end Behavioral;
