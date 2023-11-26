----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.04.2022 16:37:21
-- Design Name: 
-- Module Name: IFSTAGE_TopModule - Behavioral
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

entity IFSTAGE_TopModule is
--  Port ( );
    port(PC_Immed:   in std_logic_vector(31 downto 0);
         PC_sel:     in std_logic;
         PC_LdEn:    in std_logic;
         Reset:      in std_logic;
         Clk:        in std_logic;
         Instr:      out std_logic_vector(31 downto 0)
         );
end IFSTAGE_TopModule;

architecture Behavioral of IFSTAGE_TopModule is

-------------------- IFSTAGE ------------------------
    component IFSTAGE is
        port(PC_Immed:   in std_logic_vector(31 downto 0);
             PC_sel:     in std_logic;
             PC_LdEn:    in std_logic;
             Reset:      in std_logic;
             Clk:        in std_logic;
             PC:         out std_logic_vector(31 downto 0)
         );
    end component;
--------------------- RAM ---------------------
    component RAM is
        port(clk        :  in std_logic;
             inst_addr  :  in std_logic_vector(10 downto 0);
             inst_dout  :  out std_logic_vector(31 downto 0);
             data_we    :  in std_logic;
             data_addr  :  in std_logic_vector(10 downto 0);
             data_din   :  in std_logic_vector(31 downto 0);
             data_dout  :  out std_logic_vector(31 downto 0)
            );
    end component;
    
signal PC_out: std_logic_vector(31 downto 0);

begin
    
--------------------- IFSTAGE -------------------------------
ifstage1: 
    IFSTAGE port map(PC_Immed  =>    PC_Immed,
                     PC_sel    =>    PC_sel,
                     PC_LdEn   =>    PC_LdEn,
                     Reset     =>    Reset,
                     Clk       =>    Clk,
                     PC        =>    PC_out
                    );  
   
------------------------- RAM ---------------------------------
ram_pc: 
    RAM port map( clk        =>  Clk,
                  inst_addr  =>  PC_out(12 downto 2),
                  inst_dout  =>  Instr,
                  data_we    =>  '0',
                  data_addr  =>  "00000000000",
                  data_din   =>  "00000000000000000000000000000000",
                  data_dout  =>  open
                 );   
end Behavioral;
