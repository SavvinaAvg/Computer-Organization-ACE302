----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 08.04.2022 15:39:54
-- Design Name: 
-- Module Name: CONV_TB - Behavior
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

entity CONV_TB is
--  Port ( );
end CONV_TB;

architecture Behavior of CONV_TB is

    component CONV is
        port(Instr: in std_logic_vector(15 downto 0);
             ImmExt:   in std_logic_vector(1 downto 0);
             Immed: out std_logic_vector(31 downto 0)
        );   
    end component;
    
    signal Instr: std_logic_vector(15 downto 0) := (others => '0');
    signal ImmExt: std_logic_vector(1 downto 0) := (others => '0');
    signal Immed: std_logic_vector(31 downto 0);
    
begin

    uut: CONV port map (Instr   =>  Instr,
                        ImmExt  =>  ImmExt,
                        Immed   =>  Immed
                        );   

    stim_proc: process
    begin
    
        Instr <= "0000000000111111";
        ImmExt <= "00";
        wait for 100ns;
        
        Instr <= "0000000000111111";
        ImmExt <= "01";
        wait for 100ns;
        
        Instr <= "0000000000111111";
        ImmExt <= "10";
        wait for 100ns;
        
        Instr <= "0000000000111111";
        ImmExt <= "11";
        wait for 100ns;
        
    end process;

end Behavior;
