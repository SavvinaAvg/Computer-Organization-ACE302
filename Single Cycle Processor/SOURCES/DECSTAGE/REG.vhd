----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 12:35:08
-- Design Name: 
-- Module Name: REG - Behavioral
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

entity REG is
--  Port ( );

    port(
        CLK: in std_logic;
        RST: in std_logic;
        WE: in std_logic;
        Datain: in std_logic_vector(31 downto 0);
        Dataout: out std_logic_vector(31 downto 0)
    );
    
end REG;

architecture Behavioral of REG is

signal Reg_DataTemp: std_logic_vector(31 downto 0);

begin

Process
begin

    WAIT UNTIL CLK'EVENT AND CLK = '1';

    if RST = '1' then 
        Reg_DataTemp <= x"00000000";
        
    else
        if WE = '1' then
            Reg_DataTemp <= Datain;
        else
            Reg_DataTemp <= Reg_DataTemp;
        end if;
        
    end if;
    
end Process;

    Dataout <= Reg_DataTemp after 10ns;
end Behavioral;
