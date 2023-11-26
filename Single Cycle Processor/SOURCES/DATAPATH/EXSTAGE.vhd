----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.04.2022 13:49:19
-- Design Name: 
-- Module Name: EXSTAGE - Behavioral
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

entity EXSTAGE is
--  Port ( );
    port(RF_A: in std_logic_vector(31 downto 0);
         RF_B: in std_logic_vector(31 downto 0);
         Immed: in std_logic_vector(31 downto 0);
         ALU_Bin_sel: in std_logic;
         ALU_func: in std_logic_vector(3 downto 0);
         ALU_out: out std_logic_vector(31 downto 0);
         ALU_zero: out std_logic
        );
        
end EXSTAGE;

architecture Behavioral of EXSTAGE is

------------------------- ALU ---------------------------
    component ALU is
        port (A: in std_logic_vector(31 downto 0);
              B: in std_logic_vector(31 downto 0);
              Op: in std_logic_vector(3 downto 0);
              Output: out std_logic_vector(31 downto 0);
              Zero: out std_logic;
              Cout: out std_logic;
              Ovf: out std_logic
             );
    end component;
   
------------------------ MUX 2x1 ---------------------------
    component MUX_2_1 is
        port ( InA: in std_logic_vector(31 downto 0);
               InB: in std_logic_vector(31 downto 0);
               sel: in std_logic;
               mux_out: out std_logic_vector(31 downto 0)
             );
    end component;
    
signal mux_out_temp: std_logic_vector(31 downto 0);
    
begin

-------------------------- ALU --------------------------------
    ex_ALU:
        ALU port map(A          =>  RF_A,
                     B          =>  mux_out_temp,
                     Op         =>  ALU_func,
                     Output     =>  ALU_out,
                     Zero       =>  ALU_zero,
                     Cout       =>  open,
                     Ovf        =>  open
                    );
 
------------------------------ MUX 2x1 ----------------------------
    mux2x1:
        MUX_2_1 port map(InA        =>  RF_B,
                         InB        =>  Immed,
                         sel        =>  ALU_Bin_sel,
                         mux_out    =>  mux_out_temp
                        );                
end Behavioral;
