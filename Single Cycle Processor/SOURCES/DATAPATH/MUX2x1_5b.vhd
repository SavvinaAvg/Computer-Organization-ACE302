----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2022 15:01:05
-- Design Name: 
-- Module Name: MUX2x1_5b - Behavioral
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

entity MUX2x1_5b is
--  Port ( );
    port( din1: in std_logic_vector(4 downto 0);
          din2: in std_logic_vector(4 downto 0);
          sel:  in std_logic;
          dout: out std_logic_vector(4 downto 0)
         );
         
end MUX2x1_5b;

architecture Behavioral of MUX2x1_5b is

begin

    dout <= din1  when sel = '0' else
            din2 ;

end Behavioral;
