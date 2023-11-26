----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2022 12:57:11
-- Design Name: 
-- Module Name: Adder_Immed - Behavioral
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

entity Adder_Immed is
--  Port ( );
    port(din:       in std_logic_vector(31 downto 0);
         dout:      out std_logic_vector(31 downto 0);
         PC_Immed:  in std_logic_vector(31 downto 0)
         );
end Adder_Immed;

architecture Behavioral of Adder_Immed is
    
begin

    dout <= din + PC_Immed;

end Behavioral;
