----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.03.2022 14:21:18
-- Design Name: 
-- Module Name: MUX_2_1 - Behavioral
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

entity MUX_2_1 is
--  Port ( );
    port ( InA: in std_logic_vector(31 downto 0);
           InB: in std_logic_vector(31 downto 0);
           sel: in std_logic;
           mux_out: out std_logic_vector(31 downto 0)
           );
end MUX_2_1;

architecture Behavioral of MUX_2_1 is

begin
    mux_out <= InA  when sel = '0' else
               InB ;

end Behavioral;
