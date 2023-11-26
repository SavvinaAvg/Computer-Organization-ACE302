-- Company: 
-- Engineer: 
-- 
-- Create Date: 20.04.2021 12:35:38
-- Design Name: 
-- Module Name: RF - Behavioral
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
use work.mux_pkg.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RF is
--  Port ( );
    port(
        Ard1: in std_logic_vector(4 downto 0);
        Ard2: in std_logic_vector(4 downto 0);
        Awr: in std_logic_vector(4 downto 0);
        Dout1: out std_logic_vector(31 downto 0);
        Dout2: out std_logic_vector(31 downto 0);
        Din: in std_logic_vector(31 downto 0);
        WrEn: in std_logic;
        Clk: in std_logic;
        Rst: in std_logic
        );
end RF;

architecture Behavioral of RF is

--------------- DECODER--------------------------
component DEC_5_32 is
    port(
        input: in std_logic_vector(4 downto 0);
        output: out std_logic_vector(31 downto 0)
        );
end component;

--------------------- REGISTER ------------------------
component REG is
    port(
        CLK: in std_logic;
        RST: in std_logic;
        WE: in std_logic;
        Datain: in std_logic_vector(31 downto 0);
        Dataout: out std_logic_vector(31 downto 0)
        );
end component;

----------------------- MUX 32 ---------------------------
component MUX_32 is
    port(
        Min:  in muxIn;
        sel:  in std_logic_vector(4 downto 0);
        Mout: out std_logic_vector(31 downto 0)
        );
end component;

signal dec_out: std_logic_vector(31 downto 0);
signal inputs: muxIn;
signal temp_WE: std_logic_vector(31 downto 0);

begin

------------- DECODER --------------------
Decorder5x32:
    DEC_5_32 port map(input => Awr,
                      output => dec_out
                     );
                     
------------- WRITE ENABLE---------------------
WriteEnable:
    for i in 1 to 31 generate
        temp_WE(i) <= (WrEn AND dec_out(i)) after 2ns;
    end generate WriteEnable;

--temp_WE(0) <= '0' after 2ns;

--------------- REGISTERS ------------------------
Register_0:
    REG port map(CLK => Clk,
                 RST => Rst,
                 WE => '1',
                 Datain => "00000000000000000000000000000000",
                 Dataout => inputs(0)
                 );
                 
Registers:
    for k in 1 to 31 generate
        regs: REG port map(CLK => Clk,
                           RST => Rst,
                           WE => temp_WE(k),
                           Datain => Din,
                           Dataout => inputs(k)
                        );
    end generate Registers;
    
----------------- MUX ---------------------
MUX_1:
    MUX_32 port map(Min => inputs,
                    sel => Ard1,
                    Mout => Dout1
        );
        
MUX_2:
    MUX_32 port map(Min => inputs,
                    sel => Ard2,
                    Mout => Dout2
        );

end Behavioral;
