----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 17.03.2022 22:04:11
-- Design Name: 
-- Module Name: DEC_5_32 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity DEC_5_32 is
--  Port ( );
    port(
        input: in std_logic_vector(4 downto 0);
        output: out std_logic_vector(31 downto 0)
        );
        
end DEC_5_32;

architecture Behavioral of DEC_5_32 is
signal temp: std_logic_vector(31 downto 0);

begin

decoder:
    for i in 0 to 31 generate
        temp(i) <= '1' when input = i else '0';
    end generate;

output <= temp after 10ns;

end Behavioral;
