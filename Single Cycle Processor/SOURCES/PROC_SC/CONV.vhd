----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03.04.2022 15:11:23
-- Design Name: 
-- Module Name: CONV - Behavioral
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

entity CONV is
--  Port ( );
    port( Instr: in std_logic_vector(15 downto 0);
          ImmExt: in std_logic_vector(1 downto 0);
          Immed: out std_logic_vector(31 downto 0)
        );   
end CONV;

architecture Behavioral of CONV is

    signal immed_temp: std_logic_vector(31 downto 0);

begin

process(instr, ImmExt, immed_temp)
    begin
            
        if ImmExt = "00" then  -- zero filling
            immed_temp(31 downto 16) <= "0000000000000000";
            immed_temp(15 downto 0) <= instr(15 downto 0);
            
        elsif ImmExt = "01" then     -- zero filling with shift
            immed_temp(31 downto 16) <= instr(15 downto 0);
            immed_temp(15 downto 0) <= "0000000000000000";
            
        elsif ImmExt = "10" then   -- sign extend
            for i in 16 downto 31 loop
                immed_temp(i) <= instr(15);
            end loop;
            immed_temp(15 downto 0) <= instr(15 downto 0);
            
        elsif ImmExt = "11" then     -- sign extend with shift
            for j in 16 to 31 loop
                immed_temp(j) <= instr(15);
            end loop;
            immed_temp(15 downto 0) <= instr(15 downto 0);
                       
       end if;
       
end process;

Immed <= immed_temp after 10ns;
       
end Behavioral;
